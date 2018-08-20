//
//  ResetButtonCell.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 06.06.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit
import OBD2Swift


class ButtonCell: UITableViewCell {
    
    @IBOutlet var chameleonButton: UIButton!
    
    var buttonColor: UIColor = UIColor.lightGray
    
    override func awakeFromNib() {
        super.awakeFromNib()
        chameleonButton.backgroundColor = buttonColor
        chameleonButton.layer.cornerRadius = 12
        chameleonButton.clipsToBounds = true
    }
    
    func  setButtonEnabled(){
        buttonColor = #colorLiteral(red: 0.1725490196, green: 0.462745098, blue: 0.6901960784, alpha: 1)
        chameleonButton.backgroundColor = buttonColor
        chameleonButton.isUserInteractionEnabled = true
    }
    
}
