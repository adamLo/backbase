//
//  LocationForecastHolderCell.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import UIKit

class LocationForecastHolderCell: UITableViewCell {

    static let reuseId = "forecastHolderCell"
    
    private(set) var forecastViewController: LocationForecastViewController?

    func setup(with forecast: [WeatherForecastItem]) {
        
        if forecastViewController == nil {
            
            forecastViewController = LocationForecastViewController.controller(forecast: forecast)
            forecastViewController!.view.frame = CGRect(x: 0, y: 0, width: contentView.bounds.size.width, height: contentView.bounds.size.height)
            forecastViewController!.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentView.addSubview(forecastViewController!.view)
        }
        else {
            
            forecastViewController?.forecast = forecast
        }
    }
}
