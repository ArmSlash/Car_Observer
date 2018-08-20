//
//  PidSelectionViewController.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 14.04.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit
import OBD2Swift

class PidSelectionViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    
    @IBOutlet weak var engineButton: UIButton!
    @IBOutlet weak var paramButtton: UIButton!
    @IBOutlet weak var gasButton: UIButton!
    @IBOutlet weak var weatherButton: UIButton!
    
    var popoverView: PidsListViewController!
    
    let darkView = DarkView()
    let sharedScanner = OBD2.shared
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
         lightImpactFeedbackGenerator.prepare()
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    @IBAction func showPidsList(_ sender: UIButton) {
       
        lightImpactFeedbackGenerator.impactOccurred()
        if self.popoverView != nil {
            popoverView.dismiss(animated: false)
            self.popoverView = nil
            darkView.show(for: self.view, at: 1, animated: false)
        }else{
              darkView.show(for: self.view, at: 1, animated: true)
        }
        

       popoverView = makePopoverView(for: sender)
        
            switch sender.tag {
            case 0:
                popoverView.pidsArray = [4, 14, 31, 48, 49, 33, 5] //33 -> 48, 49
            case 1:
                popoverView.pidsArray = [12, 13]
            case 2:
                popoverView.pidsArray = [47]
            case 3:
                popoverView.pidsArray = [51, 70]
            default:break
            }
        let width = Int((self.view.bounds.width/3)*2)
        let height = (( 54 * popoverView.pidsArray.count)+4)
        popoverView.preferredContentSize = CGSize(width: width, height: height)
        
            if sharedScanner.isConnected{
                self.startScan(for: popoverView.pidsArray)
            }
        
        
            self.present(popoverView, animated: true, completion: nil)
        
    }
    
    private func makePopoverView(for sender: UIButton)->(PidsListViewController){
        popoverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pidsList") as! PidsListViewController
        popoverView.modalPresentationStyle = .popover
         let buttons = [engineButton,paramButtton,gasButton,weatherButton]
        popoverView.popoverPresentationController?.passthroughViews = buttons as? [UIView]
        popoverView.popoverPresentationController?.permittedArrowDirections = .down
        popoverView.popoverPresentationController?.delegate = self
        popoverView.popoverPresentationController?.sourceView = sender
        popoverView.popoverPresentationController?.sourceRect = sender.bounds
        popoverView.popoverPresentationController?.backgroundColor = UIColor.clear
        
        return popoverView
    }
  
    
    func startScan (for pidArray: [Int]){
        for pid in pidArray{
            let command = Command.Mode01.pid(number: pid)
            sharedScanner.request(repeat: command)
        }
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        if self.popoverView == nil {
        darkView.remove(animated: false)
        }else{
        darkView.remove(animated: true)
        }
        self.popoverView = nil
        sharedScanner.stopScan()
    }
    
}
