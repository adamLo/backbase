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
    
    var speedUnit: String {
        
        if self == .imperial {
            
            return "mph"
        }
        
        return "m/s"
    }
    
    var lengthUnit: String {
        
        if self == .imperial {
            
            return "in"
        }
        
        return "mm"
    }
    
    var localizedDescription: String {
        
        if self == .imperial {
            
            return NSLocalizedString("Imperial", comment: "Imperial units title")
        }
        
        return NSLocalizedString("Metric", comment: "Metric units title")
    }
}
