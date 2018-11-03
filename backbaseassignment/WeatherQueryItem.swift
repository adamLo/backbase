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
    
    let cityId: String?
    let coordinates: CLLocationCoordinate2D?
    let weathers: [WeatherOverView]?
    let name: String?
    let main: WeatherData?
    
    let windSpeed: Double?
    let windDirection: Double?
    
    let clouds: WeatherClouds?
    
    let rain: WeatherPrecipation?
    let snow: WeatherPrecipation?
    
    let time: Date
    
    let system: WeatherSystem?
    
    let units: Units
    
    var displayName: String {
        
        if let _name = name {
            
            return _name
        }
        else if let _coords = coordinates {
            
            return "(lat: \(_coords.latitude), lon: \(_coords.longitude))"
        }
        else if let _id = cityId {
            
            return "(id: \(_id))"
        }
        
        return "N/A"
    }
    
    private struct JSONKeys {
    
        static let coord    = "coord"
        static let lat      = "lat"
        static let lon      = "lon"
        static let weather  = "weather"
        static let name     = "name"
        static let main     = "main"
        static let wind     = "wind"
        static let deg      = "deg"
        static let speed    = "speed"
        static let clouds   = "clouds"
        static let id       = "id"
        static let dt       = "dt"
        static let rain     = "rain"
        static let snow     = "snow"
        static let sys      = "sys"
    }
    
    init(json: [String: Any], units: Units) {
        
        self.units = units
        
        if let _coord = json[JSONKeys.coord] as? [String: Any], let lat = _coord[JSONKeys.lat] as? Double, let lon = _coord[JSONKeys.lon] as? Double {
            
            coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        else {
            
            coordinates = nil
        }
        
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
        
        name = json[JSONKeys.name] as? String
        
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
        
        if let _id = json[JSONKeys.id] as? Int {
        
            cityId = "\(_id)"
        }
        else {
            
            cityId = nil
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
        
        if let _system = json[JSONKeys.sys] as? [String: Any] {
            
            system = WeatherSystem(json: _system)
        }
        else {
            
            system = nil
        }
    }
}
