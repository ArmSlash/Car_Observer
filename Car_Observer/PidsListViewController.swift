//
//  PidsListViewController.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 14.04.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit

class PidsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!
    
    let pidsArray = [12, 13, 14, 15]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.bounces = false
        self.tableView.isUserInteractionEnabled = true
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return pidsArray.count+1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //spacing between cell as spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0..<pidsArray.count:
            return 4
        default:
            return 10
        }

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
        
        switch indexPath.section {
        case 0..<pidsArray.count:
            cellIdentifire = "pidCell"
            let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifire as String) as! PidsListCell!
            cell?.pidImage.image = UIImage(named: "checkTimeIcon")
            return self.makePidCell(cell: cell!)
        default:
            cellIdentifire = "okCell"
            let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifire as String) as UITableViewCell!
            return self.makePidCell(cell: cell!)
        }
    }
    
    func  makePidCell(cell:UITableViewCell) -> UITableViewCell {
        cell.layer.borderWidth = 0
        cell.layer.cornerRadius = 12.5
        cell.clipsToBounds = true
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
//        print("highlight row at \(indexPath)")
//        let cell = self.tableView.cellForRow(at: indexPath)
//        cell!.backgroundColor = UIColor.blue
//    }
//    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
//        print("unhighlight row at \(indexPath)")
//        let cell = self.tableView.cellForRow(at: indexPath)
//        cell!.backgroundColor = UIColor.init(red: 131, green: 158, blue: 119, alpha: 100)
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == self.pidsArray.count{
            self.performSegue(withIdentifier: "unwindToPidSelection", sender: self)
        }
    }


    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
       
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
