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
    @IBInspectable var borderWidth: CGFloat{
        set{ layer.borderWidth = 0}
        get{return layer.borderWidth}
    }
    
    @IBOutlet var pidDescription: UILabel!
    
    @IBOutlet var metricsLabel : UILabel!
    
    var pidImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setPidImageAppearance()
        self.contentView.addSubview(pidImage)
    }
    
    
    
    private func setPidImageAppearance() {
        
        self.pidImage.layer.borderWidth = 0
        self.pidImage.layer.cornerRadius = 12
        self.pidImage.layer.backgroundColor = #colorLiteral(red: 0.1715868941, green: 0.4612893582, blue: 0.6906835997, alpha: 1).cgColor
        self.pidImage.contentMode = .center
        self.pidImage.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            UIView.animate(withDuration: 0.5,
                           animations: {
                self.pidDescription.layer.opacity = 0
                
                let newX = self.pidImage.layer.frame.minX + (self.contentView.layer.bounds.width - self.pidImage.layer.frame.maxX)
                self.pidImage.layer.frame = CGRect(x: newX, y: self.pidImage.layer.frame.minY, width: self.pidImage.layer.frame.width, height: self.pidImage.layer.frame.height)
                
                self.contentView.layer.backgroundColor = #colorLiteral(red: 0.1715868941, green: 0.4612893582, blue: 0.6906835997, alpha: 1).cgColor
                
                self.metricsLabel.isHidden = false
                self.metricsLabel.layer.opacity = 1
            })
        }else{
            UIView.animate(withDuration: 0.5,
                           animations: {
                self.metricsLabel.layer.opacity = 0
                
                self.pidImage.layer.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
                
                self.contentView.layer.backgroundColor = #colorLiteral(red: 0.4612745006, green: 0.6196078431, blue: 0.3437318304, alpha: 1).cgColor
                
                self.pidDescription.layer.opacity = 1
            })
        }
        
    }
    
    
    
}
