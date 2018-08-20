//
//  DarkView.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 30.06.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import Foundation
import UIKit


class DarkView: UIView{
    
    
    func show(for view:UIView, at index:Int, animated:Bool) {
        let frame = view.bounds
        self.frame = frame
        backgroundColor = UIColor.black.withAlphaComponent(0)
        isOpaque = false
        view.insertSubview(self, at: index)
        
        if animated{
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            }
        }else{
            self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
    }
    
     func remove(animated: Bool) {
        if animated{
            UIView.animate(withDuration: 0.2, animations: {
                self.backgroundColor = UIColor.black.withAlphaComponent(0)
            }, completion: { _ in
                self.removeFromSuperview()
            })
        }else{
            self.removeFromSuperview()
        }
    }

    
}
