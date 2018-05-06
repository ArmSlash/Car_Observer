//
//  SensorsTableViewController.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 17.04.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit
import OBD2Swift

class SensorsTableViewController: UITableViewController {
    
    let observer = Observer<Command.Mode01>()
    
    
    var sensorsToShow = [12, 13]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        observer.observe(command: .pid(number: 12)) { (descriptor) in
            let respStr = descriptor?.value(metric: true)
            print("Observer : \(String(describing: respStr))")
        }
        
        ObserverQueue.shared.register(observer: observer)
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "SensorsBackground"))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ObserverQueue.shared.unregister(observer: observer)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sensorsToShow.count+1
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
        case 0..<self.sensorsToShow.count:
            cellIdentifire = "SensorCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire as String, for: indexPath) as! SensorsCell
            cell.backgroundView = UIImageView(image: UIImage(named: "SensorCell"))
            let sharedScanner = SharedScanner.shared
            cell.sensorDataLabel.text = "\(sharedScanner.resp)"
            return cell
        default:
            cellIdentifire = "okButtonCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire as String, for: indexPath) as UITableViewCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var heightForRow: CGFloat
        
        switch indexPath.section {
        case 0..<self.sensorsToShow.count:
            heightForRow = 191.0
        default:
            heightForRow = 51.0
        }
        return heightForRow
    }
    
    @IBAction func returnToPidsListVC(_ sender: Any) {
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
