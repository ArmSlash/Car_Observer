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

class TroubleCodesViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    var observers = [Int : ObserverType]()
    let sharedScanner = OBD2.shared
   var popoverView: UIViewController!
    let darkView = DarkView()
    
    var db:Connection!
    
    
    var troubleCodeNames : [String] = []
    //just for test
    //var troubleCodeNames : [String] = ["P0703", "U2019", "U1451"]
    var troubleCodeDescriptions: [String] = []
    
    
    
    
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
                    print("descr: \(troubleCode[descr]), ")
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
        
    }
    
    fileprivate func checkForTroubleCodes() {
        if sharedScanner.isConnected{
            sharedScanner.request(command: Command.Mode03.troubleCode) { (descriptor) in
                self.troubleCodeNames = (descriptor?.getTroubleCodes())!
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print(".............\(troubleCodeNames.count).............")
        checkForTroubleCodes()
        
       
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
            cellIdentifire = "SensorCell"
            let  cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire as String, for: indexPath) as! SensorsCell
            if troubleCodeNames.count > 0{
                let troubleCode = troubleCodeNames[indexPath.section]
                let description = getDescription(for: troubleCode)
                cell.troubleCodeLabel.text = troubleCode
                cell.troubleCodeDescriptionLabel.text = description
            }else{
                cell.troubleCodeLabel.text = "There's no critical Trouble Codes"
                cell.troubleCodeDescriptionLabel.text = ""
            }
            return cell
            
        default:
            cellIdentifire = "resetButtonCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire as String, for: indexPath) as! ResetButtonCell
            if troubleCodeNames.count > 0{
                cell.setButtonEnabled()
                cell.resetTruobleCodesButton.addTarget(self, action: #selector(showResetPopover(_:)), for: .touchUpInside)
            }
            return cell
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
            heightForRow = 140.0
        default:
            heightForRow = 51.0
        }
       return heightForRow
    }
    
    //MARK: reset popover
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    
    private func makePopoverView(for sender: UIButton)->(UIViewController){
        popoverView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "resetPopover")
        popoverView.modalPresentationStyle = .popover
       
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
    }

}
