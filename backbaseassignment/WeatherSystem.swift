//
//  WeatherSystem.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import Foundation

struct WeatherSystem {
    
    let id: Int?
    let countryCode: String?
    let sunrise: Date?
    let sunset: Date?
    
    private struct JSONKeys {
        
        static let id       = "id"
        static let country  = "country"
        static let sunrise  = "sunrise"
        static let sunset   = "sunset"
    }
    
    init(json: [String: Any]) {
        
        id = json[JSONKeys.id] as? Int
        countryCode = json[JSONKeys.country] as? String
        
        if let _sunrise = json[JSONKeys.sunrise] as? TimeInterval {
            
            sunrise = Date(timeIntervalSince1970: _sunrise)
        }
        else {
            
            sunrise = nil
        }
        
        if let _sunset = json[JSONKeys.sunset] as? TimeInterval {
            
            sunset = Date(timeIntervalSince1970: _sunset)
        }
        else {
            
            sunset = nil
        }
    }
}
