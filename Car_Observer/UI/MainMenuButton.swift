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

class MainMenuButton: UIButton {
    var delegate:MainMenuButtonDelegate?
    
    private  var context: CGContext!
    
    var firstPath = UIBezierPath()
    var secondPath = UIBezierPath()
    var thirdPath = UIBezierPath()
    
    var color = UIColor()
    
    var firstSubButtonColor = UIColor()
    var secondSubButtonColor = UIColor()
    var thirdSubButtonColor = UIColor()
    
    
    override func draw(_ rect: CGRect) {
        
        context = UIGraphicsGetCurrentContext()!
        
        firstSubButton()
        seconSubButton()
        thirdSubButton()
        addTextToFirstSubButton()
        addTextToSecondSubButton()
        addTextToThirdSubButton()
    }
    
    private func makeShadow() -> (NSShadow){
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black
        shadow.shadowOffset = CGSize(width: 3, height: 3)
        shadow.shadowBlurRadius = 5
        return shadow
    }
    
    private func firstSubButton(){
        context.saveGState()
        context.setAlpha(0.7)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        firstPath.move(to: CGPoint(x: 374.5, y: 40))
        firstPath.addLine(to: CGPoint(x: 0, y: 120))
        firstPath.addLine(to: CGPoint(x: 0, y: 240))
        firstPath.addLine(to: CGPoint(x: 374.5, y: 160))
        firstPath.addLine(to: CGPoint(x: 374.5, y: 40))
        firstPath.close()
        context.saveGState()
        let shadow = makeShadow()
        context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        firstSubButtonColor.setFill()
        firstPath.fill()
        context.restoreGState()
        
        
        context.endTransparencyLayer()
        context.restoreGState()
    }
    
    private func seconSubButton(){
        context.saveGState()
        context.setAlpha(0.7)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        secondPath.move(to: CGPoint(x: 374.5, y: 165))
        secondPath.addLine(to: CGPoint(x: 0, y: 245))
        secondPath.addLine(to: CGPoint(x: 0, y: 365))
        secondPath.addLine(to: CGPoint(x: 374.5, y: 285))
        secondPath.addLine(to: CGPoint(x: 374.5, y: 165))
        secondPath.close()
        context.saveGState()
        let shadow = makeShadow()
        context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        secondSubButtonColor.setFill()
        secondPath.fill()
        context.restoreGState()
        
        
        context.endTransparencyLayer()
        context.restoreGState()
    }
    
    private func thirdSubButton(){
        context.saveGState()
        context.setAlpha(0.7)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        thirdPath.move(to: CGPoint(x: 374.5, y: 290))
        thirdPath.addLine(to: CGPoint(x: 0, y: 370))
        thirdPath.addLine(to: CGPoint(x: 0, y: 490))
        thirdPath.addLine(to: CGPoint(x: 374.5, y: 410))
        thirdPath.addLine(to: CGPoint(x: 374.5, y: 290))
        thirdPath.close()
        context.saveGState()
        let shadow = makeShadow()
        context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        thirdSubButtonColor.setFill()
        thirdPath.fill()
        context.restoreGState()
        
        
        context.endTransparencyLayer()
        context.restoreGState()
    }
    
    private func addTextToFirstSubButton(){
        context.saveGState()
        context.translateBy(x: 42, y: 156.7)
        context.rotate(by: -12.38 * CGFloat.pi/180)
        
        let textRect = CGRect(x: 0, y: 0, width: 290, height: 30)
        let textTextContent = "Scann My Car"
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let textFontAttributes = [
            .font: UIFont.systemFont(ofSize: 24),
            .foregroundColor: UIColor.white,
            .paragraphStyle: textStyle,
            ] as [NSAttributedStringKey: Any]
        
        let textTextHeight: CGFloat = textTextContent.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: textRect)
        textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
        context.restoreGState()
        
        context.restoreGState()
    }
    
    private func addTextToSecondSubButton(){
        context.saveGState()
        context.translateBy(x: 42, y: 281.7)
        context.rotate(by: -12.38 * CGFloat.pi/180)
        
        let text2Rect = CGRect(x: 0, y: 0, width: 290, height: 30)
        let text2TextContent = "Trouble Codes"
        let text2Style = NSMutableParagraphStyle()
        text2Style.alignment = .center
        let text2FontAttributes = [
            .font: UIFont.systemFont(ofSize: 24),
            .foregroundColor: UIColor.white,
            .paragraphStyle: text2Style,
            ] as [NSAttributedStringKey: Any]
        
        let text2TextHeight: CGFloat = text2TextContent.boundingRect(with: CGSize(width: text2Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text2FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text2Rect)
        text2TextContent.draw(in: CGRect(x: text2Rect.minX, y: text2Rect.minY + (text2Rect.height - text2TextHeight) / 2, width: text2Rect.width, height: text2TextHeight), withAttributes: text2FontAttributes)
        context.restoreGState()
        
        context.restoreGState()
    }
    
    private func addTextToThirdSubButton(){
        context.saveGState()
        context.translateBy(x: 42, y: 406.7)
        context.rotate(by: -12.38 * CGFloat.pi/180)
        
        let text3Rect = CGRect(x: 0, y: 0, width: 290, height: 30)
        let text3TextContent = "How It Works?"
        let text3Style = NSMutableParagraphStyle()
        text3Style.alignment = .center
        let text3FontAttributes = [
            .font: UIFont.systemFont(ofSize: 24),
            .foregroundColor: UIColor.white,
            .paragraphStyle: text3Style,
            ] as [NSAttributedStringKey: Any]
        
        let text3TextHeight: CGFloat = text3TextContent.boundingRect(with: CGSize(width: text3Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text3FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: text3Rect)
        text3TextContent.draw(in: CGRect(x: text3Rect.minX, y: text3Rect.minY + (text3Rect.height - text3TextHeight) / 2, width: text3Rect.width, height: text3TextHeight), withAttributes: text3FontAttributes)
        context.restoreGState()
        
        context.restoreGState()
        
    }
    
    
    private func tagForSubButtonTouchedWith(_ touches: Set<UITouch>) -> (Int) {
        if let touch = touches.first{
            let location = touch.location(in: self)
            
//            if firstPath.contains(location){
//                firstSubButtonColor = firstSubButtonColor.withAlphaComponent(0.5)
//                self.setNeedsDisplay()
//            }else{
//                self.cancelTracking(with: nil)
//                firstSubButtonColor = UIColor(red: 0.447, green: 0.549, blue: 0.232, alpha: 1.000)
//                self.setNeedsDisplay()
//            }
           
            switch Bool(){
            case !firstPath.contains(location): tag = 0
            case !secondPath.contains(location): tag = 1
            case !thirdPath.contains(location): tag = 2
            default: tag = 3
            }
            self.setNeedsDisplay()
            
        }
        return tag
    }
    
    private func setHightlighted(for subButtonTag: Int){
        switch subButtonTag {
        case 0:
            firstSubButtonColor = firstSubButtonColor.withAlphaComponent(0.7)
            secondSubButtonColor = secondSubButtonColor.withAlphaComponent(1)
            thirdSubButtonColor = thirdSubButtonColor.withAlphaComponent(1)
        case 1:
            firstSubButtonColor = firstSubButtonColor.withAlphaComponent(1)
            secondSubButtonColor = secondSubButtonColor.withAlphaComponent(0.7)
            thirdSubButtonColor = thirdSubButtonColor.withAlphaComponent(1)
        case 2:
            firstSubButtonColor = firstSubButtonColor.withAlphaComponent(1)
            secondSubButtonColor = secondSubButtonColor.withAlphaComponent(1)
            thirdSubButtonColor = thirdSubButtonColor.withAlphaComponent(0.7)
        default:
            firstSubButtonColor = firstSubButtonColor.withAlphaComponent(1)
            secondSubButtonColor = secondSubButtonColor.withAlphaComponent(1)
            thirdSubButtonColor = thirdSubButtonColor.withAlphaComponent(1)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        print("----------BEGAN-------------")
       let tag = tagForSubButtonTouchedWith(touches)
         setHightlighted(for: tag)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
     let tag = tagForSubButtonTouchedWith(touches)
        setHightlighted(for: tag)
    }
    
    override  func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        print("----------ENDED-------------")
        let tag = tagForSubButtonTouchedWith(touches)
       setHightlighted(for: 3)
        delegate?.mainManuSubButtonPressed(with: tag)
        
        self.setNeedsDisplay()

        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?){
        print("----------CANCELLED-------------")
        firstSubButtonColor = UIColor(red: 0.447, green: 0.549, blue: 0.232, alpha: 1.000)
        self.setNeedsDisplay()
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
