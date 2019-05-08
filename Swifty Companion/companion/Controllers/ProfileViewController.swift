//
//  ProfileViewController.swift
//  companion
//
//  Created by Rapula MAAKE on 2018/10/24.
//  Copyright © 2018 Rapula MAAKE. All rights reserved.
//

import UIKit
extension UIImageView
{
    func getServerImage(url: String, view: ProfileViewController)
    {
        let u = URL(string: url)
        view.indicator.startAnimating()
        URLSession.shared.dataTask(with: u!, completionHandler: {(data: Data?, resp: URLResponse?, error: Error?) -> Void in
            if error == nil && data != nil
            {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                    view.indicator.isHidden = true
                    view.indicator.stopAnimating()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
            }
            else
            {
                let alert = UIAlertController(title: "Error", message: "Cannot get access to " + url, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        view.indicator.isHidden = true
                        print("default")
                        
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                        
                        
                    }}))
                view.present(alert, animated: true, completion: nil)
            }
        }).resume()
    }
}
class ProfileViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var levelProgressView: UIProgressView!
    @IBOutlet weak var walletTextFeild: UILabel!
    @IBOutlet weak var correctionTextFeild: UILabel!
    @IBOutlet weak var locationTextField: UILabel!
    @IBOutlet weak var mobileTextField: UILabel!
    @IBOutlet weak var emailTextField: UILabel!
    @IBOutlet weak var usernameTextField: UILabel!
    @IBOutlet weak var levelTextField: UILabel!
    @IBOutlet weak var nameTextField: UILabel!
    var username: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func displayData()
    {
        self.emailTextField.text! += (ViewController.profile?.email)!
        self.nameTextField.text! += (ViewController.profile?.name)!
        self.usernameTextField.text! += (ViewController.profile?.username)!
        self.mobileTextField.text! += (ViewController.profile?.mobile)!
        self.locationTextField.text! += (ViewController.profile?.location)!
        self.correctionTextFeild.text! += String((ViewController.profile?.correction)!)
        self.walletTextFeild.text! += String((ViewController.profile?.wallet)!)
        let level = String((ViewController.profile?.level)!)
        let parts = level.split(separator: ".")
        let dec = Int(parts[1])
        let desc = parts[0] + " - " + String(dec!) + "%"
        self.levelTextField.text! += desc
        self.levelProgressView.progress = (Float(dec!) / 100)
        self.levelProgressView.tintColor = UIColor.cyan
        self.imageView.getServerImage(url: (ViewController.profile?.imageUrl)!, view: self)
        //self.levelTextField.text! +
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
