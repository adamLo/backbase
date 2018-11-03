//
//  LocationForecastCell.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import UIKit

class LocationForecastCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    @IBOutlet weak var conditionLabel: UILabel!
    
    static let reuseId = "forecastCell"
    
    private lazy var dateFormatter: DateFormatter = {
       
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter
    }()
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        contentView.backgroundColor = UIColor.black.withAlphaComponent(0.07)
    }
    
    func setup(with item: WeatherForecastItem) {
        
        dateLabel.text = dateFormatter.string(from: item.time)
        
        if let temp = item.main?.temperature {
            
            temperatureLabel.text = "\(round(temp))"
            unitLabel.text = item.units.temperatureUnit
        }
        else {
            
            temperatureLabel.text = "--"
            unitLabel.text = nil
        }
        
        if let condition = item.weathers?.last?.wDescription {
        
            conditionLabel.text = condition
        }
        else {
            
            conditionLabel.text = nil
        }
    }
    
}
