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
    
    static let reuseId = "cityCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(with city: City) {
        
        nameLabel.text = city.name ?? "N/A"
    }

}
