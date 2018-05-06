//
//  PidsListCell.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 15.04.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit

@IBDesignable class PidsListCell: UITableViewCell {
    
    @IBInspectable var cornerRadius: CGFloat{
        set{ layer.cornerRadius = newValue}
        get{return layer.cornerRadius}
    }
    
    @IBOutlet var pidImage: UIImageView!
    @IBOutlet var pidDescription: UILabel!
    @IBOutlet var checkmarkImageView: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setPidImageAppearance()
        self.setCheckmarkImageViewAppearance()
        
    }
    
    private func setCheckmarkImageViewAppearance() {
        
        self.checkmarkImageView.layer.borderWidth = 0
        self.checkmarkImageView.layer.cornerRadius = 4
        self.checkmarkImageView.clipsToBounds = true
        self.checkmarkImageView.layer.backgroundColor = UIColor.lightText.cgColor
    }
    
    private func setPidImageAppearance() {
        
        self.pidImage.layer.borderWidth = 3
        self.pidImage.layer.borderColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).cgColor
        self.pidImage.layer.cornerRadius = 12
        self.pidImage.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected == true && self.reuseIdentifier == "pidCell"{
            self.checkmarkImageView.image = UIImage(named: "checkmarkIcon")
        }else{
            self.checkmarkImageView.image = UIImage()
        }
        
    }
    
    
    
}
