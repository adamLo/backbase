//
//  WeatherData.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import Foundation

struct WeatherData {
    
    let temperature: Float?
    let pressure: Double?
    let humidity: Double?
    let minimumTemperature: Float?
    let maxiumTemperature: Float?
    let seaLevelPressure: Double?
    let groundLevelPressure: Double?
    
    private struct JSONKeys {
        
        static let temp         = "temp"
        static let pressure     = "pressure"
        static let humidity     = "humidity"
        static let temp_min     = "temp_min"
        static let temp_max     = "temp_max"
        static let sea_level    = "sea_level"
        static let grnd_level   = "grnd_level"
    }
    
    init(json: [String: Any]) {
        
        if let _temp = json[JSONKeys.temp] as? Float {
            temperature = _temp
        }
        else {
            temperature = -MAXFLOAT
        }
        
        if let _pressure = json[JSONKeys.pressure] as? Double {
            pressure = _pressure
        }
        else {
            pressure = Double(-MAXFLOAT)
        }
        
        if let _humidity = json[JSONKeys.humidity] as? Double {
            humidity = _humidity
        }
        else {
            humidity = Double(-MAXFLOAT)
        }
        
        if let _mintemp = json[JSONKeys.temp_min] as? Float {
            minimumTemperature = _mintemp
        }
        else {
            minimumTemperature = -MAXFLOAT
        }
        
        if let _maxtemp = json[JSONKeys.temp_max] as? Float {
            maxiumTemperature = _maxtemp
        }
        else {
            maxiumTemperature = -MAXFLOAT
        }
        
        if let _pressure = json[JSONKeys.sea_level] as? Double {
            seaLevelPressure = _pressure
        }
        else {
            seaLevelPressure = Double(-MAXFLOAT)
        }
        
        if let _pressure = json[JSONKeys.grnd_level] as? Double {
            groundLevelPressure = _pressure
        }
        else {
            groundLevelPressure = Double(-MAXFLOAT)
        }
    }
}
