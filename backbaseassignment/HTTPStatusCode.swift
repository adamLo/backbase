//
//  HTTPStatusCode.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import Foundation

public struct HTTPStatusCode {
    
    static let ok                           = 200
    static let created                      = 201
    static let accepted                     = 202
    static let nonAuthoritativeInformation  = 203
    static let noContent                    = 204
    static let resetContent                 = 205
    static let partialContent               = 206
    static let multiStatus                  = 207
    static let alreadyReported              = 208
    static let imUsed                       = 226
    
    static let okCodes                      = [ok, created, accepted]
    
    static let unauthorized                 = 401
    static let notFound                     = 404
    static let conflict                     = 409
    
    static let unknown                      = -666
}
