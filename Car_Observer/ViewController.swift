//
//  ViewController.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 12.04.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit
import OBD2Swift

class ViewController: UIViewController {
    
    
    static var host = "192.168.0.10"
    static var port = 35000
    
    let obd = OBD2(host: host, port: port)
    
    @IBOutlet var connectButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
    }


    @IBAction func connection(_ sender: Any) {
        
        obd.connect { (success, error) in
            OperationQueue.main.addOperation({
                if let error = error {
                print("OBD connection failed with \(error)")
                    
                }
            })
        }
    }
    
}

