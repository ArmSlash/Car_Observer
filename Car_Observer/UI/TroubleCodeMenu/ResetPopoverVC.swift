//
//  ResetPopoverVC.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 01.07.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit
import OBD2Swift

protocol ResetPopoverDelegate {
    func resetDone()
}

class ResetPopoverVC: UIViewController {
    
    var delegate:ResetPopoverDelegate?
    
    let obd = OBD2.shared
    let observer = Observer<Command.Mode01>()
    var resetIsCompleat = false
    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    
    @IBOutlet var resetButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        ObserverQueue.shared.register(observer: observer)
        sendRequest()
        impactFeedback.prepare()
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
    
    fileprivate func resetTroubleCodes() {
        obd.request(command:Command.Mode04.resetTroubleCode){ _ in
            OperationQueue.main.addOperation {
                self.resetButton.setTitle("Done", for: .normal)
                let buttonColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                self.resetButton.backgroundColor = buttonColor
            }
            self.resetIsCompleat = true
        }
    }
    
    @IBAction func buttonActions(_ sender: Any){
        impactFeedback.impactOccurred()
        print(">>>>>>>>>>>>>>R E S E T<<<<<<<<<<<<<<<<")
        if !resetIsCompleat{
            resetTroubleCodes()
        }else{
            exit()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ObserverQueue.shared.unregister(observer: observer)
        obd.stopScan()
    }
    
    func  exit(){
        dismiss(animated: true, completion: nil)
        delegate?.resetDone()
    }
    
}
