//
//  ViewController.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 12.04.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit
import OBD2Swift

class ViewController: UIViewController, ScannerDelegate, MainMenuButtonDelegate {
    
    
    
    
    static var host = "192.168.0.10"
    static var port = 35000
    
    let sharedScanner = SharedScanner.shared
    var connectionView = ConnIndicatorWithButton()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sharedScanner.delegate = self
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        let frame  = CGRect(x: (self.view.bounds.width / 2) - 40, y: self.view.bounds.height - 130, width: 80, height: 110)
        
        connectionView = ConnIndicatorWithButton(frame: frame)
        connectionView.connectButton.addTarget(self, action: #selector(connect(_:)), for: .touchUpInside)
        
        
        let menuButton = MainMenuButton(frame: CGRect(x: 0, y: 60, width: self.view.bounds.width, height: 500))
        menuButton.firstSubButtonColor = UIColor(red: 0.447, green: 0.549, blue: 0.232, alpha: 1.000)
        menuButton.secondSubButtonColor = UIColor(red: 0.097, green: 0.367, blue: 0.599, alpha: 1.000)
        menuButton.thirdSubButtonColor = UIColor(red: 0.506, green: 0.386, blue: 0.773, alpha: 1.000)
        menuButton.delegate = self

        view.addSubview(menuButton)
            
        view.addSubview(connectionView)
        
        
    }
    
    
    func mainManuSubButtonPressed(with tag: Int) {
        switch tag {
        case 0:
            performSegue(withIdentifier: "showPidSelection", sender: nil)
            
       // case 1:
            
     //   case 2:
            
        default:
            break
        }
        print(tag)
    }
    
    func scannerIsConnected() {
        _ = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) {_ in
            self.connectionView.stopRotation()
            self.connectionView.connectionStatusLabel.textColor = #colorLiteral(red: 0.4196078431, green: 0.7294117647, blue: 0.0862745098, alpha: 1)
           
            self.connectionView.connectionStatusLabel.text = "OK"
        }
        
    }
    
    
    @objc func connect(_ sender: Any) {
        if !sharedScanner.isConnected{
            sharedScanner.connect()
        }
        
            connectionView.rotate()
    }
    @IBAction func sendRequest(_ sender: UIButton) {

        sharedScanner.requestTroubleCode()
    }
    

    
    
}

