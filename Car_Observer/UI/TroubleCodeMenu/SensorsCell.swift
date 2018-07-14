//
//  SensorsCell.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 17.04.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit

class SensorsCell: UITableViewCell {

   
    @IBOutlet var troubleCodeDescriptionLabel: UILabel!
    @IBOutlet var troubleCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundView = UIImageView(image: UIImage(named: "troubleCell"))
    }

}
