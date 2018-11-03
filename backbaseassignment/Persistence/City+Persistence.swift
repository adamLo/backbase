//
//  City+Persistence.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import Foundation
import CoreData

extension City {
    
    static var entityName: String {
        
        return "City"
    }
    
    var actualUnits: Units {
        
        return Units(rawValue: units ?? "N/A") ?? Units.metric
    }
    
    var displayName: String {
        
        if let _name = name {
            
            return _name
        }
        else if latitude != 0.0 && longitude != 0.0 {
            
            return "(lat: \(latitude), lon: \(longitude))"
        }
        else if let _id = id {
            
            return "(id: \(_id))"
        }
        
        return "N/A"
    }
    
    class func newCity(in context: NSManagedObjectContext, from weather: WeatherQueryItem? = nil) -> City? {
        
        if let cityDecription = NSEntityDescription.entity(forEntityName: entityName, in: context) {
            
            let city = City(entity: cityDecription, insertInto: context)
            
            if let _weather = weather {
                
                city.update(with: _weather)
            }
            
            return city
        }
        
        return nil
    }
    
    func update(with weather: WeatherQueryItem) {
        
        name = weather.displayName
        id = weather.cityId
        
        if let coords = weather.coordinates {            
            latitude = coords.latitude
            longitude = coords.longitude
        }
        
        if let temp = weather.main?.temperature {
            currentTemp = Float(temp)
        }
        else {
            currentTemp = 0
        }
        
        if let maxTemp = weather.main?.maxiumTemperature {
            self.maxTemp = Float(maxTemp)
        }
        else {
            maxTemp = 0
        }
        
        if let minTemp = weather.main?.minimumTemperature {
            self.minTemp =  Float(minTemp)
        }
        else {
            minTemp = 0
        }
        
        if let data = weather.weathers?.first {
            conditions = data.wDescription
        }
        else {
            conditions = nil
        }
        
        lastUpdate = NSDate(timeIntervalSince1970: weather.time.timeIntervalSince1970)
    }
}
