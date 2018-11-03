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
        
        temperature = json[JSONKeys.temp] as? Float
        pressure = json[JSONKeys.pressure] as? Double
        humidity = json[JSONKeys.humidity] as? Double
        minimumTemperature = json[JSONKeys.temp_min] as? Float
        maxiumTemperature = json[JSONKeys.temp_max] as? Float
        seaLevelPressure = json[JSONKeys.sea_level] as? Double
        groundLevelPressure = json[JSONKeys.grnd_level] as? Double
    }
}
