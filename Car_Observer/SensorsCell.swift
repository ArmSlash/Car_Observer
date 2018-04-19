//
//  SensorsCell.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 17.04.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit

class SensorsCell: UITableViewCell {

    @IBOutlet var sensorIconView: UIImageView!
    @IBOutlet var sensorDataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.sensorIconView.image = UIImage(named: "tempSensIco")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
