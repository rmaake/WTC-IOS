//
//  SplashViewController.swift
//  Proteins
//
//  Created by Rapula MAAKE on 2018/11/19.
//  Copyright © 2018 Rapula MAAKE. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        perform(#selector(SplashViewController.moveToHome), with: nil, afterDelay: 5)
        //perform(performSegue(withIdentifier: "home", sender: self), with: nil, afterDelay: 10)
        // Do any additional setup after loading the view.
    }
    @objc func moveToHome()
    {
        performSegue(withIdentifier: "home", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
