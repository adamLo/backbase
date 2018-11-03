//
//  URLRequest.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    
    case post   = "POST"
    case patch  = "PATCH"
    case get    = "GET"
    case delete = "DELETE"
}

extension URLRequest {
    
    mutating func configure(for method: HTTPMethod, with data: Data? = nil, jsonContentType: Bool = true) {
        
        httpMethod = method.rawValue
        
        if jsonContentType {
            
            addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        addValue("application/json", forHTTPHeaderField: "Accept")
        
        httpBody = data
    }
    
}
