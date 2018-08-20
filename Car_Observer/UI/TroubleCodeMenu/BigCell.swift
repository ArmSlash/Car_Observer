//
//  BigCell.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 11.08.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit

class BigCell: UITableViewCell {
    
    @IBOutlet var innerView: UIImageView!
    @IBOutlet weak var rotatingImage: UIImageView!
    @IBOutlet weak var checkEngImage: UIImageView!
    @IBOutlet weak var engineOkImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var isRotating = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundView = UIImageView(image: UIImage(named: "bigCellBkg"))
        
    }
    
    func showRotatingImage(){
        self.rotatingImage.alpha = 1
        self.checkEngImage.alpha = 1
        self.engineOkImage.alpha = 0
        
    }
    
    func remove(){
        UIView.animate(withDuration: 1, delay: 0, options: .beginFromCurrentState, animations: {
            self.rotatingImage.alpha = 0
            self.checkEngImage.alpha = 0
        }) { (done) in
            self.stopRotation()
            self.showOkImage()
        }
    }
    
    private func removeRotation(){
        UIView.animate(withDuration: 1, delay: 1.5, options: .beginFromCurrentState, animations: {
            self.rotatingImage.alpha = 0
        }){ (done) in
           self.stopRotation()
        }
       
    }
    
    func showOkImage(){
        UIView.animate(withDuration: 1, delay: 0, options: .beginFromCurrentState, animations: {
            self.engineOkImage.alpha = 1
        }) { (done) in
            self.showMessege()
        }
    }
    
    func showMessege(){
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .beginFromCurrentState, animations: {
            self.engineOkImage.frame.origin.y += 20
            self.label.alpha = 1
            self.label.frame.origin.y += 40
        })
    }
    
    func rotate() {
        if !isRotating{
            isRotating = !isRotating
            let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.toValue = NSNumber(value: Double.pi * 2)
            rotation.duration = 1
            rotation.isCumulative = true
            rotation.repeatCount = Float.greatestFiniteMagnitude
            rotatingImage.layer.add(rotation, forKey: "rotationAnimation")
            removeRotation()
        }
    }
    
   func stopRotation() {
        print("stop")
        if isRotating{
            isRotating = !isRotating
            DispatchQueue.main.async {
                self.rotatingImage.layer.removeAnimation(forKey: "rotationAnimation")
            }
        }
    }
    
}
