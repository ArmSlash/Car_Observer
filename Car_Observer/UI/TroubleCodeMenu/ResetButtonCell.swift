//
//  ResetButtonCell.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 06.06.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit
import OBD2Swift

class ResetButtonCell: UITableViewCell {
    let sharedScanner = OBD2.shared
    
    @IBOutlet var resetTruobleCodesButton: UIButton!
    
    var buttonColor: UIColor = UIColor.lightGray
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resetTruobleCodesButton.setTitle("Reset DTC", for: .normal)
        resetTruobleCodesButton.backgroundColor = buttonColor
        resetTruobleCodesButton.layer.cornerRadius = 12
        resetTruobleCodesButton.clipsToBounds = true
    }
    
    func  setButtonEnabled(){
        buttonColor = #colorLiteral(red: 0.1725490196, green: 0.462745098, blue: 0.6901960784, alpha: 1)
        resetTruobleCodesButton.backgroundColor = buttonColor
        resetTruobleCodesButton.isUserInteractionEnabled = true
    }
    
}
