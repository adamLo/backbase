//
//  WeatherRain.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import Foundation

struct WeatherPrecipation {
    
    let hour3: Double?
    
    private struct JSONKeys {
        
        static let h3   = "3h"
    }
    
    init(json: [String: Any]) {
        
        hour3 = json[JSONKeys.h3] as? Double
    }
}
