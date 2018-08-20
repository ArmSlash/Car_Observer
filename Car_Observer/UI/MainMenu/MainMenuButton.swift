//
//  MainMenuButton.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 18.05.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit

protocol MainMenuButtonDelegate {
    func mainManuSubButtonPressed(with tag:Int)
}

private var context: CGContext!
var subButtonIncline:CGFloat!



class MainMenuButton: UIButton {
    var delegate:MainMenuButtonDelegate?
    
    var subButtons = [MenuSubButton]()
    var subButtonName = ["Scan My Car", "Trouble Codes", "How It Works?"]
    var subButtonColor = [#colorLiteral(red: 0.4078431373, green: 0.5725490196, blue: 0.2196078431, alpha: 1), #colorLiteral(red: 0.01960784314, green: 0.3490196078, blue: 0.6039215686, alpha: 1), #colorLiteral(red: 0.5294117647, green: 0.3058823529, blue: 0.7725490196, alpha: 1)]
    
    var subButtonIncline:CGFloat!
    let mediumImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    override func draw(_ rect: CGRect) {
        subButton()
    }
    
    
    func subButton(){
        
        let subButtonOrigin = CGPoint(x: self.bounds.origin.x, y: self.bounds.origin.y + subButtonIncline)
        let subButtonHeight: CGFloat = (self.bounds.height - subButtonIncline)/3
        let subButtonWidth = self.bounds.width
        
        var subButtonFrame = CGRect(x: subButtonOrigin.x, y: subButtonOrigin.y, width: subButtonWidth, height: subButtonHeight)
        
        for (index, name) in subButtonName.enumerated(){
            if subButtons.count < subButtonName.count{
                subButtonFrame.origin.y = (subButtonHeight*CGFloat(index))+subButtonIncline
                let subButton = MenuSubButton(frame: subButtonFrame, incline: subButtonIncline)
                
                subButton.labelText = name
                subButton.color = subButtonColor[index]
                subButton.tag = index
                subButton.draw()
                subButtons.append(subButton)
                print(subButton.frame.origin.y)
                
            }else{
                subButtons[index].draw()
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        setSubButtonHightlighted(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        setSubButtonHightlighted(touches)
    }
    
    override  func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        
      
        
        for subButton in subButtons{
            if subButton.isHightlighted{
                delegate?.mainManuSubButtonPressed(with: subButton.tag)
            }
        }
        setAllSubButtonsUnhightlighted()
        self.setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?){
        setAllSubButtonsUnhightlighted()
        self.setNeedsDisplay()
    }
    
    
    private func setSubButtonHightlighted(_ touches: Set<UITouch>) {
        if let touch = touches.first{
            let location = touch.location(in: self)
            subButtons[0].isHightlighted = subButtons[0].path.contains(location)
            subButtons[1].isHightlighted = subButtons[1].path.contains(location)
            subButtons[2].isHightlighted = subButtons[2].path.contains(location)
            self.setNeedsDisplay()
        }
    }
    
    
    private func setAllSubButtonsUnhightlighted() {
        for subButton in subButtons{
            subButton.isHightlighted = false
        }
    }
}
