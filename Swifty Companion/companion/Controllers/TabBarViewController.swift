//
//  TabBarViewController.swift
//  companion
//
//  Created by Rapula MAAKE on 2018/10/25.
//  Copyright © 2018 Rapula MAAKE. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    var username: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveInfo()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func retrieveInfo()
    {
        var req = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/users/" + self.username!)!)
        req.setValue("Bearer " + ViewController.token, forHTTPHeaderField: "Authorization")
        req.httpMethod = "GET"
        URLSession.shared.dataTask(with: req, completionHandler: {(data: Data?, resp: URLResponse?, error: Error?) -> Void in
            do
            {
                if let data = data
                {
                    let dict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                    if (dict?.count)! > 0
                    {
                        ViewController.profile = ProfileData(dic: dict!)
                        let cursus = dict?.value(forKey: "cursus_users") as? NSArray
                        self.getSkills(dic: cursus?[0] as! NSDictionary)
                        self.getProjects(dic: (dict?.value(forKey: "projects_users"))! as! NSArray)
                        DispatchQueue.main.async {
                            let vc = self.viewControllers![0] as! ProfileViewController
                            let vc2 = self.viewControllers![1] as! SkillViewController
                            vc.displayData();
                            
                        }
                        //print(dict?.value(forKey: "projects_users"))
                    }
                    else
                    {
                        let alert = UIAlertController(title: "Error", message: "Username  " + self.username! + " was not found", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            switch action.style{
                            case .default:
                               self.performSegue(withIdentifier: "searchSegue", sender: self)
                               //view.indicator.isHidden = true
                                print("default")
                                
                            case .cancel:
                                print("cancel")
                                
                            case .destructive:
                                print("destructive")
                                
                                
                            }}))
                        self.present(alert, animated: true, completion: nil)
                    }
                    //print(camp.value(forKey: "address"))*/
                }
            }
            catch let err
            {
                print(err.localizedDescription)
            }
        }).resume()
    }
    func getSkills(dic: NSDictionary)
    {
        ViewController.skills = []
        let skills = dic.value(forKey: "skills") as? NSArray
        for skill in skills!{
            let sk = skill as! NSDictionary
            ViewController.skills.append(SkillsData(dic: sk))
        }
    }
    func getProjects(dic: NSArray)
    {
        ViewController.projects = []
        //print(dic)
        for project in dic{
            ViewController.projects.append(ProjectsData(dic: project as! NSDictionary))
            
            //print(pro)
        }
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
