//
//  WeatherQueryItem.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherQueryItem {
    
    let coordinates: CLLocationCoordinate2D?
    let weathers: [Weather]?
    let name: String?
    
    var displayName: String {
        
        if let _name = name {
            
            return _name
        }
        else if let _coords = coordinates {
            
            return "(lat: \(_coords.latitude), lon: \(_coords.longitude))"
        }
        
        return "N/A"
    }
    
    private struct JSONKeys {
    
        static let coord    = "coord"
        static let lat      = "lat"
        static let lon      = "lon"
        static let weather  = "weather"
        static let name     = "name"
    }
    
    init(json: [String: Any]) {
        
        if let _coord = json[JSONKeys.coord] as? [String: Any], let lat = _coord[JSONKeys.lat] as? Double, let lon = _coord[JSONKeys.lon] as? Double {
            
            coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        else {
            
            coordinates = nil
        }
        
        if let _weathers = json[JSONKeys.weather]as? [[String: Any]] {
            
            var weathers = [Weather]()
            for _weather in _weathers {
                
                let weather = Weather(json: _weather)
                weathers.append(weather)
            }
            self.weathers = weathers
        }
        else {
            
            weathers = nil
        }
        
        name = json[JSONKeys.name] as? String
    }
}
