//
//  PidSelectionViewController.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 14.04.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit

class PidSelectionViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet var enginePidsButton: UIButton!
    @IBOutlet var vehicleStatPidButton: UIButton!
    @IBOutlet var gasPidButton: UIButton!
    @IBOutlet var outsideParamPidbutton: UIButton!
    var pidsToScan : [Int] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        //do som stuff from the popover
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return UIModalPresentationStyle.none
    }
    
    
    @IBAction func unwindToPidSelection(segue : UIStoryboardSegue){
        
    }
    
    
    @IBAction func showPidsList(_ sender: UIButton) {
        
        if  let popoverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pidsList") as? PidsListViewController{
            popoverView.modalPresentationStyle = .popover
            
            popoverView.popoverPresentationController?.permittedArrowDirections = .any
            popoverView.popoverPresentationController?.delegate = self
            popoverView.popoverPresentationController?.sourceView = sender            
            popoverView.popoverPresentationController?.sourceRect = sender.bounds
            popoverView.popoverPresentationController?.backgroundColor = UIColor.clear
            
            switch sender.tag {
            case 0:
                popoverView.pidsArray = [4, 14, 31, 33, 92]
            case 1:
                popoverView.pidsArray = [5, 12, 13]
            case 2:
                popoverView.pidsArray = [47]
            case 3:
                popoverView.pidsArray = [51, 70]
            default:break
            }
            
            let width = Int((self.view.bounds.width/3)*2)
            let height = Int((64 * popoverView.pidsArray.count)+4)
            
            popoverView.preferredContentSize = CGSize(width: width, height: height)
            
            self.present(popoverView, animated: true, completion: nil)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    }
    
    
}
