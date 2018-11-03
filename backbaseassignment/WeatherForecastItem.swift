//
//  WeatherForecastItem.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import Foundation

struct WeatherForecastItem {
    
    let time: Date
    let units: Units
    
    let main: WeatherData?
    let weathers: [WeatherOverView]?
    let clouds: WeatherClouds?
    
    let windSpeed: Double?
    let windDirection: Double?
    
    let rain: WeatherPrecipation?
    let snow: WeatherPrecipation?
    
    private struct JSONKeys {
        
        static let weather  = "weather"
        static let main     = "main"
        static let wind     = "wind"
        static let deg      = "deg"
        static let speed    = "speed"
        static let clouds   = "clouds"
        static let dt       = "dt"
        static let rain     = "rain"
        static let snow     = "snow"
        static let sys      = "sys"
    }
    
    init(json: [String: Any], units: Units) {
        
        self.units = units
        
        if let _weathers = json[JSONKeys.weather]as? [[String: Any]] {
            
            var weathers = [WeatherOverView]()
            for _weather in _weathers {
                
                let weather = WeatherOverView(json: _weather)
                weathers.append(weather)
            }
            self.weathers = weathers
        }
        else {
            
            weathers = nil
        }
        
        if let _main = json[JSONKeys.main] as? [String: Any] {
            
            main = WeatherData(json: _main)
        }
        else {
            
            main = nil
        }
        
        if let _wind = json[JSONKeys.wind] as? [String: Any], let _speed = _wind[JSONKeys.speed] as? Double, let _dir = _wind[JSONKeys.deg] as? Double {
            
            windSpeed = _speed
            windDirection = _dir
        }
        else {
            
            windSpeed = nil
            windDirection = nil
        }
        
        if let _clouds = json[JSONKeys.clouds] as? [String: Any] {
            
            clouds = WeatherClouds(json: _clouds)
        }
        else {
            
            clouds = nil
        }
        
        if let _timestamp = json[JSONKeys.dt] as? TimeInterval {
            
            time = Date(timeIntervalSince1970: _timestamp)
        }
        else {
            
            time = Date()
        }
        
        if let _rain = json[JSONKeys.rain] as? [String: Any] {
            
            rain = WeatherPrecipation(json: _rain)
        }
        else {
            
            rain = nil
        }
        
        if let _snow = json[JSONKeys.snow] as? [String: Any] {
            
            snow = WeatherPrecipation(json: _snow)
        }
        else {
            
            snow = nil
        }
    }
}
