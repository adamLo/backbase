//
//  Units.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import Foundation

enum Units: String {
    
    case metric, imperial
    
    var temperatureUnit: String {
        
        if self == .imperial {
            
            return "℉"
        }
        
        return "℃ "
    }
}
