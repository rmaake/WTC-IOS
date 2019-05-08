//
//  ViewController.swift
//  Proteins
//
//  Created by Rapula MAAKE on 2018/11/19.
//  Copyright © 2018 Rapula MAAKE. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var notifyLabel: UILabel!
    @IBOutlet weak var touchBtn: UIButton!
    var context = LAContext();
    override func viewDidLoad() {
        super.viewDidLoad()
        var err: NSError?
        if (self.context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &err))
        {
            if self.context.biometryType != LABiometryType.touchID
            {
                DispatchQueue.main.async {
                    self.notifyLabel.text = "Opps... Your device doesn't support touchID";
                    self.touchBtn.isHidden = true;
                }
            }
        }
        else
        {
            DispatchQueue.main.async {
                self.notifyLabel.text = "Opps... Your device doesn't support touchID/" + (err?.localizedDescription)!;
                self.touchBtn.isHidden = true;
                ViewController.displayMessage(title: "Error", msg: (err?.localizedDescription)!, view: self)
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func signBtn(_ sender: UIButton) {
        self.context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We need to authenticate you using your fingerprint") { success, evaluateError in
            
            DispatchQueue.main.async {
                if success {
                    self.performSegue(withIdentifier: "proteinList", sender: self)
                } else {
                    ViewController.displayMessage(title: "Failure", msg: "TouchID Authentication failed", view: self)
                    
                }
            }
        }
    }
    
    public static func displayMessage(title: String, msg: String, view: UIViewController)
    {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        view.present(alert, animated: true, completion: nil)
    }
}

