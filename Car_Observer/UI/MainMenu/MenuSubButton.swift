//
//  MenuSubButton.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 25.05.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit

class MenuSubButton: NSObject {
    
    private let context = UIGraphicsGetCurrentContext()!
    private var token: NSKeyValueObservation?
    let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    let mediumImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)

    
    let path = UIBezierPath()
    
    var frame: CGRect!
    var incline: CGFloat!
    
    var color: UIColor?
    var labelText: String?
    
    var tag:Int!
    
 
    
  @objc dynamic var isHightlighted = false
    
    init(frame: CGRect, incline: CGFloat) {
        super.init()
        self.frame = frame
        self.incline = incline
        token = self.observe(\.isHightlighted, options: [.new, .old]) {[weak self] object, change in
            if change.oldValue != change.newValue {
                if (self?.isHightlighted)!{
                    self?.lightImpactFeedbackGenerator.prepare()
                    self?.lightImpactFeedbackGenerator.impactOccurred()
                }else{
                     self?.mediumImpactFeedbackGenerator.prepare()
                     self?.mediumImpactFeedbackGenerator.impactOccurred()
                }
            }
        }
    }
    
    func draw() {
        context.saveGState()
        context.setAlpha(0.65)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        let upperRightPoint = CGPoint(x: frame.size.width, y: frame.origin.y - incline)
        let lowerRightPoint = CGPoint(x: upperRightPoint.x, y: upperRightPoint.y + frame.size.height)
        let lowerLeftPoint = CGPoint(x: frame.origin.x , y: frame.origin.y + frame.size.height)
        
        path.move(to: frame.origin)
        path.addLine(to: upperRightPoint)
        path.addLine(to: lowerRightPoint)
        path.addLine(to: lowerLeftPoint)
        path.addLine(to: frame.origin)
        path.close()
        
        let shadow = makeShadow()
        context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        
        if isHightlighted{
            color = color?.withAlphaComponent(0.5)
            print(isHightlighted)
        }else{
            color = color?.withAlphaComponent(1)
            print(isHightlighted)
        }
        color?.setFill()
        path.fill()
        
        context.endTransparencyLayer()
        context.restoreGState()
        
        addLabel()
    }
    
    
    private func makeShadow() -> (NSShadow){
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black
        shadow.shadowOffset = CGSize(width: 3, height: 3)
        shadow.shadowBlurRadius = 5
        return shadow
    }
    
    private func addLabel(){
        
        context.saveGState()
        let labelHeight: CGFloat = 30
        let labelWidth: CGFloat = 290
        
        let x = (frame.origin.x + (frame.size.width/2 - labelWidth/2))
        let y = (frame.origin.y + ((frame.size.height - incline)/2) - (labelHeight/2))
        
        let labelRect = CGRect(x: x, y: y, width: labelWidth, height: labelHeight)
        let labelTextContent = labelText
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        
        let textFontAttributes = [
            .font: UIFont.systemFont(ofSize: 24),
            .foregroundColor: UIColor.white,
            .paragraphStyle: textStyle,
            ] as [NSAttributedStringKey: Any]
        
        let labelTextHeight: CGFloat = labelTextContent!.boundingRect(with: CGSize(width: labelRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        context.clip(to: labelRect)
        labelTextContent?.draw(in: CGRect(x: labelRect.minX, y: labelRect.minY + (labelRect.height - labelTextHeight) / 2, width: labelRect.width, height: labelTextHeight), withAttributes: textFontAttributes)
        context.restoreGState()
    }    
    
}




















