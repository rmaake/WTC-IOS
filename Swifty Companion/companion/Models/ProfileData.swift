//
//  ProfileData.swift
//  companion
//
//  Created by Rapula MAAKE on 2018/10/24.
//  Copyright © 2018 Rapula MAAKE. All rights reserved.
//

import Foundation

public class ProfileData
{
    var level: Double
    var username: String
    var name: String
    var email: String
    var mobile: String = ""
    var location: String
    var correction: Int32
    var wallet: Double
    var imageUrl: String
    init(dic: NSDictionary) {
        self.correction = dic.value(forKey: "correction_point") as! Int32
        self.wallet = dic.value(forKey: "wallet") as! Double
         if let mob = dic.value(forKey: "phone") as? String
         {
            self.mobile = mob
        }
        self.username = dic.value(forKey: "login") as! String
        self.name = dic.value(forKey: "displayname") as! String
        self.email = dic.value(forKey: "email") as! String
        self.imageUrl = dic.value(forKey: "image_url") as! String
        self.level = 0.0
        self.location = ""
        if let cursus = dic.value(forKey: "cursus_users") as? NSArray
        {
            if let cur = cursus[0] as? NSDictionary
            {
                self.level = cur.value(forKey: "level") as! Double
            }
        }
        if let campus = dic.value(forKey: "campus") as? NSArray
        {
            if let camp = campus[0] as? NSDictionary
            {
                self.location = (camp.value(forKey: "address") as! String) + ", " + (camp.value(forKey: "country") as! String)
            }
        }
    }
}
