//
//  Fonts.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 04/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import Foundation
import UIKit

enum FontStyle {
    
    case regular, bold
}

enum FontSize {
    
    case xxSmall, xSmall, small, base, large, larger, xLarge, xxLarge, xxxLarge
    
    var size: CGFloat {
        
        get {
            
            let portrait = UIApplication.shared.statusBarOrientation == .portrait || UIApplication.shared.statusBarOrientation == .portraitUpsideDown
            let screenWidth =  portrait ? UIScreen.main.bounds.size.width : UIScreen.main.bounds.size.height
            
            var divider: CGFloat = 1.0
            
            switch self {
                
            case .xxSmall:  divider = 39.0
            case .xSmall:   divider = 35.0
            case .small:    divider = 31.25
            case .base:     divider = 29.0
            case .large:    divider = 25.0
            case .larger:   divider = 20.0
            case .xLarge:   divider = 15.0
            case .xxLarge:  divider = 10.0
            case .xxxLarge: divider = 8.0
            }
            
            let calculatedSize = screenWidth / (divider > 0 ? divider : 1.0)
            
            let consolidatedSize = min(max(calculatedSize, 5), 100)
            
            return consolidatedSize
        }
    }
}

extension UIFont {
    
    class func defaultFont(style:FontStyle, size: FontSize) -> UIFont {
        
        let fontSize = size.size
        
        switch style {
        case .bold:
            return UIFont.boldSystemFont(ofSize: fontSize)
        default:
            return UIFont.systemFont(ofSize: fontSize)
        }
    }
    
}
