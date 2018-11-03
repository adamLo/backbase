//
//  WeatherData.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import Foundation

struct WeatherData {
    
    let temperature: Double?
    let pressure: Double?
    let humidity: Double?
    let minimumTemperature: Double?
    let maxiumTemperature: Double?
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
        
        temperature = json[JSONKeys.temp] as? Double
        pressure = json[JSONKeys.pressure] as? Double
        humidity = json[JSONKeys.humidity] as? Double
        minimumTemperature = json[JSONKeys.temp_min] as? Double
        maxiumTemperature = json[JSONKeys.temp_max] as? Double
        seaLevelPressure = json[JSONKeys.sea_level] as? Double
        groundLevelPressure = json[JSONKeys.grnd_level] as? Double
    }
}
