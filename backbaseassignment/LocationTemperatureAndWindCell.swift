//
//  LocationTemperatureAndWindCell.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import UIKit

class LocationTemperatureAndWindCell: UITableViewCell {
    
    @IBOutlet weak var dataLabel: UILabel!
    
    static let reuseId = "temperatureAndWindCell"

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        dataLabel.font = UIFont.defaultFont(style: .regular, size: .large)
    }

    func setup(with weather: WeatherQueryItem) {
        
        var text = ""
        
        if let minTemp = weather.main?.minimumTemperature {
            
            text = String(format: NSLocalizedString("Low: %0.1f%@", comment: "Low temperature format"), minTemp, weather.units.temperatureUnit)
        }
        
        if let maxTemp = weather.main?.maxiumTemperature {
            
            text += text.isEmpty ? "" : " "
            text += String(format: NSLocalizedString("High: %0.1f%@", comment: "High temperature format"), maxTemp, weather.units.temperatureUnit)
        }
            
        if let _speed = weather.windSpeed, let _dir = weather.windDirection {
            
            text += text.isEmpty ? "" : " "
            text += String(format: NSLocalizedString("Wind: %0.1f %@ direction: %0.1f°", comment: "Wind format"), _speed, weather.units.speedUnit, _dir)
        }
        
        if text.isEmpty {
            
            text = NSLocalizedString("No weather data", comment: "Placeholder when data missing")
        }
        
        dataLabel.text = text
    }

}
