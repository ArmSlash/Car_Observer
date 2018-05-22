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
    
    
    let darkView = UIView()
    let sharedScanner = SharedScanner.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.darkView.backgroundColor = UIColor.black.withAlphaComponent(0)
        }, completion: { (true) in
            self.darkView.removeFromSuperview()
        })
        sharedScanner.stopScan()
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return UIModalPresentationStyle.none
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
                popoverView.pidsArray = [4, 14, 31, 33, 5]
            case 1:
                popoverView.pidsArray = [12, 13]
            case 2:
                popoverView.pidsArray = [47]
            case 3:
                popoverView.pidsArray = [51, 70]
            default:break
            }
            
            if sharedScanner.isConnected{
                self.startScan(for: popoverView.pidsArray)
            }
            
            let width = Int((self.view.bounds.width/3)*2)
            let height = Int((64 * popoverView.pidsArray.count)+4)
            
            popoverView.preferredContentSize = CGSize(width: width, height: height)
            let frame = self.view.bounds
            darkView.frame = frame
            darkView.backgroundColor = UIColor.black.withAlphaComponent(0)
            darkView.isOpaque = false
            self.view.addSubview(darkView)
            
            UIView.animate(withDuration: 0.3) {
                self.darkView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            }
            self.present(popoverView, animated: true, completion: nil)
        }
    }
    
    func startScan (for pidArray: [Int]){
        for pid in pidArray{
            sharedScanner.repeatRequestFor(pid: pid)
        }
    }

    
    
}
