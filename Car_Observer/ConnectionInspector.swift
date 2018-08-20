//
//  ConnectionInspector.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 30.06.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import Foundation
import UIKit

import OBD2Swift

protocol ConnectionInspectorDelegate {
    func noConnectiontoObd()
}

class ConnectionInspector{
    
    var delegate:ConnectionInspectorDelegate?
    private var timer = Timer()
    private let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
    var isObserving = false
    
    
    
    func waitForConnection(seconds:Double){
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(noConnection), userInfo: nil, repeats: false)
        notificationFeedbackGenerator.prepare()
    }
    
    func stop(){
        timer.invalidate()
    }
    
    @objc func noConnection(){
        print("no connection")
       // notificationFeedbackGenerator.notificationOccurred(.error)
        delegate?.noConnectiontoObd()
    }
    
    
    
    
    
    
    
    
}
