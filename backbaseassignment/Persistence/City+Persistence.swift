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
    
    class func newCity(in context: NSManagedObjectContext, from weather: WeatherQueryItem? = nil) -> City? {
        
        if let cityDecription = NSEntityDescription.entity(forEntityName: entityName, in: context) {
            
            let city = City(entity: cityDecription, insertInto: context)
            
            if let _weather = weather {
                
                city.name = _weather.displayName
                
                if let temp = _weather.main?.temperature {
                    city.currentTemp = temp
                }
                else {
                    city.currentTemp = 0
                }
                
                if let maxTemp = _weather.main?.maxiumTemperature {
                    city.maxTemp = maxTemp
                }
                else {
                    city.maxTemp = 0
                }
                
                if let minTemp = _weather.main?.minimumTemperature {
                    city.minTemp =  minTemp
                }
                else {
                    city.minTemp = 0
                }
                
                if let data = _weather.weathers?.first {
                    city.conditions = data.wDescription
                }
                else {
                    city.conditions = nil
                }
            }
            
            return city
        }
        
        return nil
    }
}
