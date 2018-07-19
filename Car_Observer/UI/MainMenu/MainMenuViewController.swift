//
//  ViewController.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 12.04.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit
import AudioToolbox.AudioServices
import OBD2Swift




class MainMenuViewController: UIViewController, UIApplicationDelegate, MainMenuButtonDelegate, ConnectionInspectorDelegate, UITextFieldDelegate {
    
    
    private let mediumImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
   
    
    private let sharedScanner = OBD2.shared
    private let inspector = ConnectionInspector()
    
    
    private var currentScannerState: ScanState = .none
    
    private var connectionIndicator: ConnIndicatorWithButton?
    private var menuButton: MainMenuButton?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarAppearence()
        inspector.delegate = self
        startObservingScanerState()
    }
    
    
    private func startObservingScanerState(){
        sharedScanner.stateChanged  = {[weak self] state in
            self?.currentScannerState = state
        }
    }
    
    private func setNavigationBarAppearence(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        print("appear")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(UIApplicationWillEnterForeground),
                                               name: .UIApplicationWillEnterForeground,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(UIApplicationDidEnterBackground),
                                               name: .UIApplicationDidEnterBackground,
                                               object: nil)
        mediumImpactFeedbackGenerator.prepare()
        addMainMenuButtons()
        addConnectionIndicator()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super .viewDidDisappear(animated)
        print("disapear")
        NotificationCenter.default.removeObserver(self,
                                                  name: .UIApplicationWillEnterForeground,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: .UIApplicationDidEnterBackground,
                                                  object: nil)
        removeConnectionIndicator()
    }
    
    @objc func UIApplicationWillEnterForeground(){
        addConnectionIndicator()
    }
    
    @objc func UIApplicationDidEnterBackground(){
        removeConnectionIndicator()
    }
    
    private func addConnectionIndicator(){
        if connectionIndicator == nil{
            let indicatorWidth:CGFloat = view.bounds.width*0.2
            let indicatorHeight:CGFloat = view.bounds.width*0.2
            let frame  = CGRect(x: (self.view.bounds.width / 2) - (indicatorWidth/2),
                                y: self.view.bounds.height*0.83,
                                width: indicatorWidth,
                                height: indicatorHeight)
            connectionIndicator = ConnIndicatorWithButton(for: currentScannerState, frame: frame)
            connectionIndicator?.connectButton.addTarget(self, action: #selector(connect(_:)), for: .touchUpInside)
            view.addSubview(connectionIndicator!)
        }
    }
    
    private func removeConnectionIndicator(){
        connectionIndicator?.removeFromSuperview()
        connectionIndicator = nil
    }
    private func addMainMenuButtons(){
        if menuButton == nil{
            menuButton = MainMenuButton(frame: CGRect(x: 0,
                                                      y: self.view.bounds.height*0.07,
                                                      width: self.view.bounds.width,
                                                      height: self.view.bounds.height*0.58))
            menuButton?.subButtonIncline = self.view.bounds.height*0.1
            menuButton?.delegate = self
            view.addSubview(menuButton!)
        }
    }
    
    
    
    @objc func connect(_ sender: Any) {
        mediumImpactFeedbackGenerator.impactOccurred()
        if sharedScanner.isConnected{
            return
        }
        inspector.waitForConnection(seconds: 3)
        
        sharedScanner.connect {[weak self] (success, error) in
            OperationQueue.main.addOperation({
                if let error = error {
                    print("OBD connection failed with \(error)")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.connectionIndicator?.stopRotation()
                    }
                }else{
                    self?.inspector.stop()
                    print("************** CONNECTED ***********")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self?.connectionIndicator?.changeToConnectedState()                       
                    }
                }
            })
        }
        self.connectionIndicator?.rotate()
    }
    
    //MARK: Connection Alert
    
    fileprivate func createTextField(_ textField: (UITextField), for param:OBD2.ConnectionParam) {
       
        textField.keyboardAppearance = .dark
        textField.keyboardType = .numbersAndPunctuation
        textField.clearsOnBeginEditing = true
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        
        switch param {
        case .host: textField.placeholder = "Host IP: \(self.sharedScanner.connectionSettings().host)"
                    textField.tag = 0
        case .port: textField.placeholder = "Port: \(self.sharedScanner.connectionSettings().port)"
                    textField.tag = 1
        }
    }
    
    func showAlert(){
        
        let alert = UIAlertController(title: "Ooops...", message: "Connection failed \n Try to change settings \n Or leave as it and try again :)", preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { (action) in
            self.connect(self)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(retryAction)
        
        alert.addTextField { (textField:UITextField) in
            self.createTextField(textField, for: .host)
        }
        alert.addTextField { (textField:UITextField) in
            self.createTextField(textField, for: .port)
        }
        
       present(alert, animated: true, completion: nil)
    }
    
    //MARK: ConnectionInspectorDelegate
    
    func noConnectiontoObd() {
//        self.connectionIndicator?.stopRotation()
       self.sharedScanner.disconnect()
//        showAlert()
        connectionIndicator?.changeToConnectedState()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.text?.count == 0{
            return
        }
        switch textField.tag {
        case 0: UserDefaults.standard.setValue((textField.text), forKeyPath: "host")
        case 1: UserDefaults.standard.set(Int(textField.text!), forKey:"port")
        default: return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let cSet = CharacterSet.decimalDigits.inverted
        let compSepByCharInSet = string.components(separatedBy: cSet)
        var char = compSepByCharInSet.joined(separator: ".")
        if textField.tag == 1{
         char = compSepByCharInSet.joined()
        }
        print(textField.tag)
        return string == char
    }
    
    //MARK: MainMenuButtonDelegate
    
    func mainManuSubButtonPressed(with tag: Int) {
        switch tag {
        case 0:
            performSegue(withIdentifier: "showPidSelection", sender: nil)
        case 1:
            print(1)
            performSegue(withIdentifier: "showTroubleCodeView", sender: nil)
        case 2:
            print(2)
            
            performSegue(withIdentifier: "showIntroVC", sender: nil)
        default:
            break
        }
    }
    
    
}

