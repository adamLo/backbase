//
//  ErrorDialog.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func show(error: Error) {
        
        show(message: error.localizedDescription)
    }
    
    func show(message: String) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK Button title"), style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
