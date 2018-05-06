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
    
    var pidsArray : [Int] = []
    var selectedPids : [Int] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor.clear
        self.tableView.bounces = false
        self.tableView.isUserInteractionEnabled = true
        
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
        
        let imageName = PidDisplayManager.imageFor(pid: pid)
        let pidDescription = PidDisplayManager.descriptionFor(pid: pid)
        
        cell?.pidImage.image = UIImage(named: imageName)
        cell?.pidDescription.text = pidDescription
        
        return cell!
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
}
