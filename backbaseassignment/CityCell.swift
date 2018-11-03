//
//  CityCell.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    
    static let reuseId = "cityCell"
    
    private lazy var dateFormatter: DateFormatter = {
       
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        
        return formatter
    }()

    func setup(with city: City) {
        
        nameLabel.text = city.name ?? "N/A"
        
        var updateText = NSLocalizedString("Last updated: ", comment: "Last update prefix")
        if let _time = city.lastUpdate {
            let time = Date(timeIntervalSince1970: _time.timeIntervalSince1970)
            updateText += dateFormatter.string(from: time)
        }
        else {
            updateText += "N/A"
        }
        lastUpdateLabel.text = updateText
        
        var tempString = ""
        if city.currentTemp > -MAXFLOAT {
            tempString = String(format: "%0.1f", city.currentTemp)
            tempString += city.actualUnits.temperatureUnit
        }
        if city.minTemp > -MAXFLOAT {
            
            tempString += tempString.isEmpty ? "" : " / ↓"
            tempString += String(format: "%0.1f", city.minTemp)
            tempString += city.actualUnits.temperatureUnit
        }
        if city.maxTemp > -MAXFLOAT {
            
            tempString += tempString.isEmpty ? "" : " / ↑"
            tempString += String(format: "%0.1f", city.maxTemp)
            tempString += city.actualUnits.temperatureUnit
        }
        temperatureLabel.text = tempString.isEmpty ? NSLocalizedString("--", comment: "Temparature placholder") : tempString
        
        conditionsLabel.text = city.conditions ?? NSLocalizedString("Conditions: N/A", comment: "Conditions placeholder")
    }

}
