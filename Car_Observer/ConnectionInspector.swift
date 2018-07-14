//
//  ConnectionInspector.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 30.06.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import Foundation

import OBD2Swift

protocol ConnectionInspectorDelegate {
    func obdConectionLost()
}

class ConnectionInspector{
    
    var delegate:ConnectionInspectorDelegate?
    var timer = Timer()
   
    var isObserving = false
  
    
    
    func waitForConnection(seconds:Double){
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(noConnection), userInfo: nil, repeats: false)
        }
    
    func stop(){
        timer.invalidate()
    }
        
    @objc func noConnection(){
        print("no connection")
        delegate?.obdConectionLost()
    }
    
    
    
    
    
    
    
    
}
