//
//  ConnectionIndicatorView.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 16.05.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit

class ConnIndicatorWithButton: UIView {
    
    let rotatingImageView = UIImageView()
    let connectionStatusLabel = UILabel()
    let connectButton = UIButton()
    
    var rotating = false
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(rotatingImageView(for: self))
        self.addSubview(connectionStatusLabel(for: self))
        self.addSubview(connectonButton(for: self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func rotatingImageView(for view:UIView) -> UIImageView{
        let size = view.bounds.width
        let frame  = CGRect(x: 0, y: 0, width: size , height: size)
        
        rotatingImageView.frame = frame
        rotatingImageView.image = #imageLiteral(resourceName: "arrows")
        rotatingImageView.contentMode = .scaleAspectFit
        rotatingImageView.clipsToBounds = true
        
        return rotatingImageView
        
    }
    private func connectonButton(for view:UIView) -> (UIButton) {
        let frame = CGRect(x: 13, y: 13, width: 54, height: 54)
        connectButton.frame = frame
        
        connectButton.setImage(#imageLiteral(resourceName: "obd "), for: .normal)
        connectButton.imageView?.contentMode = .scaleAspectFit
        
        return connectButton
    }
    
    private func connectionStatusLabel (for view: UIView) -> UILabel {
        
        let width = view.bounds.width
        let yOffset = view.bounds.width
        connectionStatusLabel.frame = CGRect(x: 0, y: yOffset, width: width, height: 15)
        connectionStatusLabel.textAlignment = .center
        connectionStatusLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        connectionStatusLabel.text = "Connect"
        
        return connectionStatusLabel
    }
    
    func rotate() {
        if !rotating{
            rotating = !rotating
            let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.toValue = NSNumber(value: Double.pi * 2)
            rotation.duration = 1
            rotation.isCumulative = true
            rotation.repeatCount = Float.greatestFiniteMagnitude
            rotatingImageView.layer.add(rotation, forKey: "rotationAnimation")
           
        }
    }
    
    func stopRotation() {
        if rotating{
            rotating = !rotating
            UIView.animate(withDuration: 0.8, animations: {
                self.rotatingImageView.layer.opacity = 0
                let size = self.connectionStatusLabel.frame.size
                let newX = self.connectionStatusLabel.frame.minX
                let newY = self.connectionStatusLabel.frame.minY - 20
                let origin = CGPoint(x: newX, y: newY)
                
                self.connectionStatusLabel.frame = CGRect(origin: origin, size: size)
                
                self.connectButton.setImage( #imageLiteral(resourceName: "greenObd "), for: .normal)
            }) {_ in
                self.rotatingImageView.layer.removeAnimation(forKey: "rotationAnimation")
            }
        }
    }
    
}
