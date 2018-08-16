//
//  SensorsTableViewController.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 17.04.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit
import OBD2Swift
import SQLite

enum State {
    case checking
    case checked
    case notChecked
}


class TroubleCodesViewController: UITableViewController, UIPopoverPresentationControllerDelegate, ResetPopoverDelegate {
    
    let mediumImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    var observers = [Int : ObserverType]()
    let sharedScanner = OBD2.shared
    var popoverView: ResetPopoverVC!
    let darkView = DarkView()
    
    
    var db:Connection!
    
    var troubleCodeNames : [String] = []
   // var troubleCodeNames : [String] = ["P0703", "U2019", "U1451","P0703", "U2019", "U1451","P0703", "U2019", "U1451","P0703", "U2019", "U1451"] //just for test
    var troubleCodeDescriptions: [String] = []
    
    var gotTroubleCodes: Bool{
        if self.troubleCodeNames.count > 0{
            return true
        }else{
            return false
        }
    }
    
    var dtcState: State = .notChecked{
        didSet{
            OperationQueue.main.addOperation{
            self.tableView.reloadData()
        }
    }
    }
    
    
    
    
    fileprivate func connectTroubleCodesDB(){
        do{
            let path = Bundle.main.path(forResource: "obd-trouble-codes", ofType: "sqlite3")!
            
            self.db = try Connection(path, readonly: true)
        }catch{
            print(error)
        }
    }
    
    fileprivate func getDescription(for troubleCode: String) -> (String){
        
        var description = "no value"
        do {
            let codes = Table("codes")
            let code = Expression<String>("id")
            let descr = Expression<String>("desc")
            let troubleCode = troubleCode
            for troubleCode in try db.prepare(codes.filter(code == troubleCode)) {
                print("descr: \(troubleCode[descr])")
                description = troubleCode[descr]
            }
        }catch{
            print(error)
        }
        return description
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "SensorsBackground"))
        connectTroubleCodesDB()
        mediumImpactFeedbackGenerator.prepare()
    }
    
    @objc fileprivate func checkForTroubleCodes() {
        dtcState = .checking
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if self.sharedScanner.isConnected{
                self.sharedScanner.request(command: Command.Mode03.troubleCode) { (descriptor) in
//self.troubleCodeNames = (descriptor?.getTroubleCodes())!
                    self.troubleCodeNames = ["P0703", "U2019", "U1451"]
                    self.dtcState = .checked
                }
            }
        }
    }
    
    // MARK: Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if troubleCodeNames.count > 0{
            return troubleCodeNames.count+1
        }else{
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellIdentifire: NSString
        
        switch indexPath.section {
        case 0..<tableView.numberOfSections-1:
            if gotTroubleCodes{
                cellIdentifire = "sensorCell"
                let  cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire as String, for: indexPath) as! SensorsCell
                let troubleCode = troubleCodeNames[indexPath.section]
                let description = getDescription(for: troubleCode)
                cell.troubleCodeLabel.text = troubleCode
                cell.troubleCodeDescriptionLabel.text = description
                return cell
            }else{
                cellIdentifire = "bigCell"
                let  cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire as String, for: indexPath) as! BigCell
                if dtcState == .notChecked{
                    cell.showRotatingImage()
                }else if dtcState == .checking{
                    cell.rotate()
                }else if dtcState == .checked{
                    cell.remove()
                }
                
                return cell
            }
        default:
            cellIdentifire = "resetButtonCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire as String, for: indexPath) as! ButtonCell
            cell.chameleonButton.addTarget(self, action: #selector(buttonActions), for: .touchUpInside)
            if !sharedScanner.isConnected{
                cell.chameleonButton.setTitle("No Connection", for: .normal)
            }else if sharedScanner.isConnected && dtcState == .notChecked{
                cell.setButtonEnabled()
                cell.chameleonButton.setTitle("Check DTC", for: .normal)
            }else if sharedScanner.isConnected && !gotTroubleCodes && dtcState == .checked{
                cell.setButtonEnabled()
                cell.chameleonButton.setTitle("OK", for: .normal)
            }else if gotTroubleCodes{
                cell.setButtonEnabled()
                cell.chameleonButton.setTitle("Reset DTC", for: .normal)
            }
            return cell
        }
    }
    
    @objc func buttonActions(sender: UIButton){
        mediumImpactFeedbackGenerator.impactOccurred()
        if sharedScanner.isConnected && dtcState == .notChecked{
            checkForTroubleCodes()
        }else if sharedScanner.isConnected && !gotTroubleCodes && dtcState == .checked{
            exit()
        }else if gotTroubleCodes{
            showResetPopover(sender)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let key = indexPath.section
        let observer = observers[key]
        if observer != nil{
            ObserverQueue.shared.unregister(observer: observer!)
            observers.removeValue(forKey: key)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var heightForRow: CGFloat
        
        switch indexPath.section {
        case 0..<tableView.numberOfSections-1:
            if self.gotTroubleCodes{
                heightForRow = 140.0
            }else{
                heightForRow = 329 //UIScreen.main.bounds.height*0.40
            }
            
        default:
            heightForRow = 51.0
        }
        return heightForRow
    }
    
    //MARK:  ResetPopover
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    
    private func makePopoverView(for sender: UIButton)->(ResetPopoverVC){
        popoverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "resetPopover") as! ResetPopoverVC
        popoverView.modalPresentationStyle = .popover
        popoverView.delegate = self
        popoverView.popoverPresentationController?.permittedArrowDirections = .down
        popoverView.popoverPresentationController?.delegate = self
        
        popoverView.popoverPresentationController?.sourceView = sender
        popoverView.popoverPresentationController?.sourceRect = sender.bounds
        popoverView.popoverPresentationController?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        
        return popoverView
    }
    
    @objc func showResetPopover(_ sender: UIButton){
        popoverView = makePopoverView(for: sender)
        
        let width:CGFloat = 330
        let height = UIScreen.main.bounds.height/2
        popoverView.preferredContentSize = CGSize(width: width, height: height)
        self.present(popoverView, animated: true, completion: nil)
        let view  = self.navigationController?.view
        darkView.show(for: view!, at: 2, animated: true)
        
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        darkView.remove(animated: true)
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>Dismissed<<<<<<<<<<<<<<<<<<<<<<<<")
    }
    
    func resetDone() {
        self.troubleCodeNames = []
        darkView.remove(animated: true)
        dtcState = .notChecked
        
    }
    
    @objc  func exit(){
        navigationController?.popViewController(animated: true)
    }
    
}
