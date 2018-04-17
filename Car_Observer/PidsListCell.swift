//
//  PidsListCell.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 15.04.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit

class PidsListCell: UITableViewCell {
    
    
    
    @IBOutlet var pidImage: UIImageView!
    @IBOutlet var pidDescription: UILabel!
    @IBOutlet var checkmarkImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.init(red: 131, green: 158, blue: 119, alpha: 100)
        
        
       
        
        self.checkmarkImageView.layer.borderWidth = 0
        self.checkmarkImageView.layer.cornerRadius = 4
        self.checkmarkImageView.clipsToBounds = true
        self.checkmarkImageView.backgroundColor = UIColor.lightText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected == true{
            self.checkmarkImageView.image = UIImage(named: "checkmarkIcon")
        }else{
            self.checkmarkImageView.image = UIImage()
        }
        
    }

}
