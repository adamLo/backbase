//
//  LocationPrecipationCell.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import UIKit

class LocationPrecipationCell: UITableViewCell {

    @IBOutlet weak var dataLabel: UILabel!
    
    static let reuseId = "precipationCell"
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        dataLabel.font = UIFont.defaultFont(style: .regular, size: .large)
    }

    func setup(with weather: WeatherQueryItem) {
        
        var text = ""
        
        if let humidity = weather.main?.humidity {
            
            text = String(format: NSLocalizedString("Humidity: %0.1f%%", comment: "Humidity format"), humidity)
        }
        
        var precipation = ""
        
        if let rain = weather.rain?.hour3, rain > 0.0 {
            
            precipation = String(format: NSLocalizedString("%0.1f %@ rain", comment: "Rain precipation format"), rain, weather.units.lengthUnit)
        }
        
        if let snow = weather.snow?.hour3, snow > 0.0 {
            
            precipation += precipation.isEmpty ? "" : ", "
            precipation = String(format: NSLocalizedString("%0.1f %@ snow", comment: "Rain precipation format"), snow, weather.units.lengthUnit)
        }
        
        text += text.isEmpty ? "" : " "
        text += String(format: NSLocalizedString("Precipation in 3h: %@", comment: "Main precipation format"), precipation.isEmpty ? NSLocalizedString("None", comment: "None") : precipation)
        
        if text.isEmpty {
            
            text = NSLocalizedString("No weather data", comment: "Placeholder when data missing")
        }
        
        dataLabel.text = text
    }

}
