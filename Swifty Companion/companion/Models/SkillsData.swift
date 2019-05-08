//
//  SkillsData.swift
//  companion
//
//  Created by Rapula MAAKE on 2018/10/24.
//  Copyright © 2018 Rapula MAAKE. All rights reserved.
//

import Foundation

public class SkillsData{
    var level: Double
    var name: String
    init (dic: NSDictionary)
    {
        self.level = dic.value(forKey: "level") as! Double
        self.name = dic.value(forKey: "name") as! String
    }
}
