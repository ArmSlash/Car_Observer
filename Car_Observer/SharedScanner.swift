//
//  SharedScanner.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 22.04.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import Foundation
import OBD2Swift

protocol ScannerDelegate: class {
    func scannerIsConnected()
}

class SharedScanner {
    
   weak var delegate:ScannerDelegate?
    
    var resp : Float = 0
    var isConnected = false
    
    
    static let shared = SharedScanner()
    private let obd = OBD2()
    
    private init() {}
    
    
    func connect(){
        obd.connect { (success, error) in
            OperationQueue.main.addOperation({
                if let error = error {
                    print("OBD connection failed with \(error)")
                }else{
                    print("************** CONNECTED ***********")
                    self.isConnected = true
                    self.delegate?.scannerIsConnected()
                    
                }
                
            })
        }
    }
 
    func repeatRequestFor(pid:Int) {
       // for pid in pidsArray{
            let pidForRequest = pid 
            let command = Command.Mode01.pid(number: pidForRequest)
            //if obd.isRepeating(repeat: command) {
             //   obd.stop(repeat: command)
           // } else {
                obd.request(repeat: command)
          //  }
       // }
    }
    
    func requestFor(pid:Int) {
        let pidForRequest = pid
        obd.request(command: Command.Mode01.pid(number: pidForRequest)) { (descriptor) in
            let respStr = descriptor?.value(metric: true)
            self.resp = respStr!
            print(respStr ?? "No value")
            
        }
    }
    
    func requestTroubleCode() {
        obd.request(command: Command.Mode03.troubleCode) { (descriptor) in
            let respStr = descriptor?.getTroubleCodes()
            let resp2 = descriptor?.troubleCodeCount()
            
            print(respStr ?? "No value")
            print(resp2 ?? "no")
        }
    }
    
    func custom(){
        obd.request(command: Command.Mode09.vin) { (descriptor) in
            let respStr = descriptor?.VIN()
            print("............\(String(describing: respStr))....................")
        }
    }
    
    
    func pause() {
        obd.pauseScan()
    }
    
    func resume() {
        obd.resumeScan()
    }
    func stopScan(){
        obd.stopScan()
    }
}
