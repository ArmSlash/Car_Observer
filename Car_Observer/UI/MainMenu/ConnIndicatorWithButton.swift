//
//  ConnectionIndicatorView.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 16.05.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit
import OBD2Swift

class ConnIndicatorWithButton: UIView {
    
    let rotatingImageView = UIImageView()
    let connectionStatusLabel = UILabel()
    let connectButton = UIButton()
    private let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
    
    var isRotating = false
    private var checkbox:TKAnimatedCheckButton!
    
    
    
    init(for currentScannerState: ScanState, frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(setRotatingImageView(for: self))
        self.addSubview(setConnectionStatusLabel(for: self))
        self.addSubview(setConnectonButton(for: self))
        setConnectionIndicatorState(for: currentScannerState)
        checkbox = TKAnimatedCheckButton(frame: rotatingImageView.frame)
        checkbox.layer.opacity = 0
        self.insertSubview(checkbox, at: 0)
        notificationFeedbackGenerator.prepare()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setRotatingImageView(for view:UIView) -> UIImageView{
        let size = view.bounds.width
        let frame  = CGRect(x: 0, y: 0, width: size , height: size)
        rotatingImageView.frame = frame
        rotatingImageView.image = #imageLiteral(resourceName: "arrows")
        rotatingImageView.contentMode = .scaleAspectFit
        rotatingImageView.clipsToBounds = true
        
        return rotatingImageView
    }
    
    private func setConnectionStatusLabel (for view: UIView) -> UILabel {
        let labelWidth = view.bounds.width
        let labelHeight = view.bounds.height*0.2
        let yOffset = view.bounds.width
        connectionStatusLabel.frame = CGRect(x: 0, y: yOffset, width: labelWidth, height: labelHeight )
        connectionStatusLabel.font = connectionStatusLabel.font.withSize(view.bounds.width*0.23)
        connectionStatusLabel.textAlignment = .center
        connectionStatusLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let defoultText = "Connect"
        connectionStatusLabel.text = defoultText
        
        return connectionStatusLabel
    }
    
    private func setConnectonButton(for view:UIView) -> (UIButton) {
        let buttonWidth = view.bounds.width*0.68
        let buttonHeight = view.bounds.width*0.68
        let buttonX = (view.bounds.width - buttonWidth)/2
        let buttoY = (view.bounds.width - buttonWidth)/2
        let frame = CGRect(x: buttonX, y: buttoY, width: buttonWidth, height: buttonHeight)
        connectButton.frame = frame
        
        connectButton.setImage(#imageLiteral(resourceName: "obd "), for: .normal)
        connectButton.imageView?.contentMode = .scaleAspectFit
        
        return connectButton
    }
    
    private func setConnectionIndicatorState(for currentScannerState:ScanState){
        switch currentScannerState {
        case .none: return
        case .openingConnection: rotate()
        case .initializing: rotate()
        case .connected: changeButtonToConnectedState()
            
        }
    }
    
    func changeToConnectedState(){
        UIView.animate(withDuration: 0.3, animations: {
            self.changeButtonToConnectedState()
        }) {_ in
            if self.isRotating{
                self.isRotating = !self.isRotating
                self.stopRotation()
            }
        }
    }
    
    private func changeButtonToConnectedState(){
        hideRotatingViewAndButton()
        showChekbox()
    }
    
    private func hideRotatingViewAndButton(){
        self.rotatingImageView.layer.opacity = 0
        self.connectionStatusLabel.layer.opacity = 0
        self.connectButton.layer.opacity = 0
    }
    
    private func showChekbox() {
        self.checkbox.layer.opacity = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.checkbox.color = UIColor.green.cgColor
            self.checkbox.checked = true
            self.notificationFeedbackGenerator.notificationOccurred(.success)
        }
    }
    
    
    func rotate() {
        if !isRotating{
            isRotating = !isRotating
            let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.toValue = NSNumber(value: Double.pi * 2)
            rotation.duration = 1
            rotation.isCumulative = true
            rotation.repeatCount = Float.greatestFiniteMagnitude
            rotatingImageView.layer.add(rotation, forKey: "rotationAnimation")
            
        }
    }
    
    func stopRotation() {
        if isRotating{
            isRotating = !isRotating
            DispatchQueue.main.async {
                self.rotatingImageView.layer.removeAnimation(forKey: "rotationAnimation")
            }
        }
    }
    
}



