//
//  ResetPopoverVC.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 01.07.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit
import OBD2Swift

class ResetPopoverVC: UIViewController {
    let obd = OBD2.shared
    let observer = Observer<Command.Mode01>()
    
    @IBOutlet var resetButton: UIButton!
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        ObserverQueue.shared.register(observer: observer)
        sendRequest()
    }
    
    private func sendRequest(){
        let pid = 12
        let command = Command.Mode01.pid(number: pid)
        obd.request(repeat: command)
        startObserve(for: command)
    }
    
    private func startObserve(for command: Command.Mode01){
        observer.observe(command: command) { (res) in
            let rpm = res?.valueMetrics
            DispatchQueue.main.async{
                if rpm == 0 && self.resetButton.isUserInteractionEnabled == false{
                    self.setButtonEnabled()
                }else if rpm != 0 && self.resetButton.isUserInteractionEnabled == true{
                    self.setButtonDisabled()
                }
            }
        }
        
    }
    
    private func setButtonEnabled(){
        resetButton.isUserInteractionEnabled = true
        let buttonColor = #colorLiteral(red: 0.1725490196, green: 0.462745098, blue: 0.6901960784, alpha: 1)
        resetButton.backgroundColor = buttonColor
    }
    
    private func setButtonDisabled(){
        resetButton.isUserInteractionEnabled = false
        let buttonColor = UIColor.lightGray
        resetButton.backgroundColor = buttonColor
    }
    
    @IBAction func resetTroubleCodes(_ sender: Any){
        print(">>>>>>>>>>>>>>R E S E T<<<<<<<<<<<<<<<<")
        obd.request(command:Command.Mode04.resetTroubleCode){ _ in}
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ObserverQueue.shared.unregister(observer: observer)
        obd.stopScan()
    }
    
}
