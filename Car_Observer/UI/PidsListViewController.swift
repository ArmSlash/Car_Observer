//
//  PidsListViewController.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 14.04.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit
import OBD2Swift

class PidsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!
    
    var pidsArray : [Int] = []
    let observer = Observer<Command.Mode01>()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor.clear
        self.tableView.bounces = false
        self.tableView.isUserInteractionEnabled = true
        ObserverQueue.shared.register(observer: observer)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return pidsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //spacing between cell as spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifire : NSString
        
        cellIdentifire = "pidCell"
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifire as String) as? PidsListCell
        
        let pid = pidsArray[indexPath.section]
        
        let imageName = PidDisplayManager.image(for: pid)
        let pidDescription = PidDisplayManager.description(for: pid)
        
        cell?.pidImage.image = UIImage(named: imageName)
        cell?.pidDescription.text = pidDescription
        let sharedScanner = SharedScanner.shared
        
        if !sharedScanner.isConnected{
            cell?.metricsLabel.text = "No Connection..."
        }else{
            observer.observe(command: .pid(number: pid)) { (descriptor) in
                let respStr = descriptor?.valueMetrics
                let unitStr = descriptor?.unitMetric
                
                let scanResult = "\(respStr ?? 0)" + " " + unitStr!
                DispatchQueue.main.async{
                cell?.metricsLabel.text =  scanResult
                }
            }
            
        }
        return cell!
    }
    override func viewWillDisappear(_ animated: Bool) {
        ObserverQueue.shared.unregister(observer: observer)
    }
}
