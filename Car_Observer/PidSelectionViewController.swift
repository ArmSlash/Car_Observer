//
//  PidSelectionViewController.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 14.04.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit

class PidSelectionViewController: UIViewController {
    
    @IBOutlet var enginePidsButton: UIButton!
    @IBOutlet var vehicleStatPidButton: UIButton!
    @IBOutlet var gasPidButton: UIButton!
    @IBOutlet var outsideParamPidbutton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func showPidsList(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            print("engine")
        case 1:
            print("status")
        case 2:
           print("gas")
        case 3:
             print("outside")
        default:
            break
        }
    }
    
    @IBAction func unwindToPidSelection(segue : UIStoryboardSegue){
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
