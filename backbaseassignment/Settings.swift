//
//  Settings.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 04/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    var units: Units {
        get {
            
            if let _value = string(forKey: "units"), let value = Units(rawValue: _value) {
                
                return value
            }
            
            return .metric
        }
        set {
            
            set(newValue.rawValue, forKey: "units")
        }
    }
}
