//
//  CityDetailViewController.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import UIKit

class CityDetailViewController: UIViewController {
    
    var city: City?

    // MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        distributeData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        updateData()
    }
    
    // MARK: - Data integration
    
    private func distributeData() {
        
        if let _city = city {
            
            title = _city.displayName
        }
        else {
            
            title = "N/A"
        }
    }
    
    // MARK: - API integration
    
    private func updateData() {
        
        if let _city = city {
            
            OpenWeatherMap.shared.update(city: _city) {[weak self] (success, error) in
                
                if success,let _self = self {
                    
                    if let context = Persistence.shared.managedObjectContext {
                        
                        context.refresh(_city, mergeChanges: true)
                        _self.distributeData()
                    }
                }
            }
        }
    }
}
