//
//  WeatherClouds.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import Foundation

struct WeatherClouds {
    
    let all: Float?
    
    private struct JSONKeys {
        
        static let all  = "all"
    }
    
    init(json: [String: Any]) {
        
        all = json[JSONKeys.all] as? Float
    }
}
