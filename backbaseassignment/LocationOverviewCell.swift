//
//  LocationOverviewCell.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import UIKit

class LocationOverviewCell: UITableViewCell {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    
    static let reuseId = "overviewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setup(with city: City) {
        
        if city.currentTemp > -MAXFLOAT {
            
            temperatureLabel.text = "\(city.currentTemp)"
            unitLabel.text = city.actualUnits.temperatureUnit
        }
        else {
            temperatureLabel.text = "--"
            unitLabel.text = nil
        }
        
        conditionsLabel.text = city.conditions ?? "N/A"
    }

}
