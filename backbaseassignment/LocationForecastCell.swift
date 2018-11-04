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
    
    @IBOutlet weak var humidityLabel: UILabel!
    
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
        
        dateLabel.font = UIFont.defaultFont(style: .regular, size: .xxSmall)
        temperatureLabel.font = UIFont.defaultFont(style: .bold, size: .xLarge)
        unitLabel.font = UIFont.defaultFont(style: .regular, size: .small)
        conditionLabel.font = UIFont.defaultFont(style: .regular, size: .xSmall)
        humidityLabel.font = UIFont.defaultFont(style: .regular, size: .xSmall)
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
        
        var condition = ""
        
        if let _condition = item.weathers?.last?.wDescription {
        
            condition = _condition
        }
        if let windSpeed = item.windSpeed, let windDir = item.windDirection {
            
            condition += condition.isEmpty ? "" : "\n"
            condition += String(format: NSLocalizedString("Wind %0.1f %@ %0.1f°", comment: "Forecast wind format") , windSpeed, item.units.speedUnit, windDir)
        }
        
        var precipation = ""
        
        if let rain = item.rain?.hour3, rain > 0.0 {
            
            precipation = String(format: NSLocalizedString("%0.1f %@ rain", comment: "Rain precipation format"), rain, item.units.lengthUnit)
        }
        
        if let snow = item.snow?.hour3, snow > 0.0 {
            
            precipation += precipation.isEmpty ? "" : ", "
            precipation = String(format: NSLocalizedString("%0.1f %@ snow", comment: "Rain precipation format"), snow, item.units.lengthUnit)
        }
        
        if !precipation.isEmpty {
        
            condition += condition.isEmpty ? "" : "\n"
            condition += String(format: NSLocalizedString("Precip 3h: %@", comment: "Forecast precipation format"), precipation.isEmpty ? NSLocalizedString("None", comment: "None") : precipation)
        }
        
        if !condition.isEmpty {
            
            conditionLabel.text = condition
        }
        else {
            
            conditionLabel.text = nil
        }
        
        if let humidity = item.main?.humidity {
            
            humidityLabel.text = String(format: NSLocalizedString("%0.1f%%", comment: "Humidity format n forecast cell"), humidity)
        }
        else {
            
            humidityLabel.text = NSLocalizedString("--", comment: "Humidity data placeholder")
        }
    }
    
}
