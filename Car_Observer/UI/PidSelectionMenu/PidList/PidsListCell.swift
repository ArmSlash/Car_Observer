//
//  PidsListCell.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 15.04.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit

class PidsListCell: UITableViewCell {
    
    let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    
    @IBOutlet var pidDescription: UILabel!
    
    @IBOutlet var metricsLabel : UILabel!
    
   private var pidImageContainer = UIView()
    var pidImageView: UIImageView!
    var autoSelect = true
    
    
    fileprivate func setPidImageViewAppearance(){
        let offset: CGFloat = 12
        let xCoord = offset/2
        let yCoord = offset/2
        let imageWidth = self.bounds.height - offset
        let imageHeight = self.bounds.height - offset
        let frame = CGRect(x: xCoord, y: yCoord, width: imageWidth, height: imageHeight)
        let imageView = UIImageView(frame: frame)
        imageView.layer.borderWidth = 0
        imageView.layer.backgroundColor = #colorLiteral(red: 0.1715868941, green: 0.4612893582, blue: 0.6906835997, alpha: 1).cgColor
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        pidImageView = imageView
    }
    
    
    fileprivate func setPidImageContainerAppearance(){
        let pidImageWidth = 50
        let pidImageHeight = 50
        print(pidImageWidth, pidImageHeight)
        let frame = CGRect(x: 0,
                           y: 0,
                           width: pidImageWidth,
                           height: pidImageHeight)
        let containerView = UIView(frame: frame)
        containerView.layer.borderWidth = 0
        containerView.layer.cornerRadius = 12
        containerView.layer.backgroundColor = #colorLiteral(red: 0.1715868941, green: 0.4612893582, blue: 0.6906835997, alpha: 1).cgColor
        containerView.contentMode = .scaleAspectFit
        containerView.clipsToBounds = true
        setPidImageViewAppearance()
        containerView.addSubview(pidImageView)
        pidImageContainer = containerView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 0
        self.layer.backgroundColor = UIColor.clear.cgColor
        setPidImageContainerAppearance()
        contentView.addSubview(pidImageContainer)
    }
    
     func showPidData() {
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.pidDescription.layer.opacity = 0
                        let newX = (self.pidImageContainer.layer.frame.minX) + (self.contentView.layer.bounds.width - (self.pidImageContainer.layer.frame.maxX))
                        self.pidImageContainer.layer.frame.origin = CGPoint(x: newX,
                                                                            y: (self.pidImageContainer.layer.frame.minY))
                        self.layer.backgroundColor = #colorLiteral(red: 0.1715868941, green: 0.4612893582, blue: 0.6906835997, alpha: 1).cgColor
                        self.metricsLabel.isHidden = false
                        self.metricsLabel.layer.opacity = 1
        })
    }
    
     func showPidName() {
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.metricsLabel.layer.opacity = 0
                        self.pidImageContainer.layer.frame.origin = CGPoint(x: 0,
                                                                            y: 0)
                        
                        self.layer.backgroundColor = #colorLiteral(red: 0.4612745006, green: 0.6196078431, blue: 0.3437318304, alpha: 1).cgColor
                        self.pidDescription.layer.opacity = 1
        })
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        lightImpactFeedbackGenerator.prepare()
        lightImpactFeedbackGenerator.impactOccurred()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        if selected {
            showPidData()
        }else{
            showPidName()
        }
        
    }
   
    
    
    
}
