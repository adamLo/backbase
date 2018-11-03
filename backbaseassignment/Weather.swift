//
//  Weather.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import Foundation

struct Weather {
    
    let id: String?
    let main: String?
    let wDescritption: String?
    let iconId: String?
    
    private struct JSONKeys {
        
        static let id           = "id"
        static let main         = "main"
        static let description  = "description"
        static let icon         = "icon"
    }
    
    init(json: [String: Any]) {
        
        id = json[JSONKeys.id] as? String
        main = json[JSONKeys.main] as? String
        wDescritption = json[JSONKeys.description] as? String
        iconId = json[JSONKeys.icon] as? String
    }
}
