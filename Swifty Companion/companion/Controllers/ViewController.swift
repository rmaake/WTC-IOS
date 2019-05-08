//
//  ViewController.swift
//  companion
//
//  Created by Rapula MAAKE on 2018/10/24.
//  Copyright © 2018 Rapula MAAKE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usrTextField: UITextField!
    var uid: String = "a71ce29d2687e0daa2358ef73d01069a2568d25f1922fed98b4876bf1e35b21d"
    var uis: String = "cbe96e02387ff8c7cfa34c2579b4059ceff8a21b201ac022f63bc69b7b1fc61e"
    var url = "https://api.intra.42.fr/oauth/token"
    
    static var token: String = ""
    static var skills: [SkillsData] = []
    static var projects: [ProjectsData] = []
    static var profile: ProfileData?
    
    @IBOutlet weak var searchButton: UIButton!
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchButton.isEnabled = false
        var req = URLRequest(url: URL(string: self.url)!)
        req.httpMethod = "POST"
        let dat = "grant_type=client_credentials&client_id=" + self.uid + "&client_secret=" + self.uis;
        req.httpBody = dat.data(using: .utf8)
        URLSession.shared.dataTask(with: req, completionHandler:  {(data: Data?, resp: URLResponse?, error: Error?) -> Void in
            do
            {
                if let data = data
                {
                    let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                    print(dictionary!)
                    if let tempToken = dictionary
                    {
                        //expirationDate = Date(timeIntervalSinceNow: 7200 + (tempToken["expires_in"] as! Double))
                        //print(expirationDate!)
                        ViewController.token = (tempToken["access_token"] as! String)
                        DispatchQueue.main.async {
                            self.searchButton.isEnabled = true
                        }
                    }
                }
                
            }
            catch let error
            {
                print(error)
            }
        }).resume()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //self.retrieveInfo()
        let tc = segue.destination as? TabBarViewController
        tc?.username = self.usrTextField.text!
        //vc?.username = self.usrTextField.text!
    }
    @IBAction func searchBtn(_ sender: UIButton) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        /*let tab = segue.destination as! UITabBarController
         let vc = tab.viewControllers![0] as! ProfileViewController
         print("Hellos")
         
         let u = URL(string: url)
         URLSession.shared.dataTask(with: u!, completionHandler: {(data: Data?, resp: URLResponse?, error: Error?) -> Void in
         if error == nil && data != nil
         {
         DispatchQueue.main.async {
         self.image = UIImage(data: data!)
         cell?.indicator.isHidden = true
         cell?.indicator.stopAnimating()
         UIApplication.shared.isNetworkActivityIndicatorVisible = false
         }
         
         }
         else
         {
         let alert = UIAlertController(title: "Error", message: "Cannot get access to " + url, preferredStyle: UIAlertControllerStyle.alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
         switch action.style{
         case .default:
         cell?.indicator.isHidden = true
         print("default")
         
         case .cancel:
         print("cancel")
         
         case .destructive:
         print("destructive")
         
         
         }}))
         view.present(alert, animated: true, completion: nil)
         }
         }).resume()*/
        // Dispose of any resources that can be recreated.
    }


}

