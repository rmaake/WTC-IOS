//
//  ProjectsData.swift
//  companion
//
//  Created by Rapula MAAKE on 2018/10/24.
//  Copyright © 2018 Rapula MAAKE. All rights reserved.
//

import Foundation

public class ProjectsData
{
    var finalMark: Int32
    var name: String
    var status: String
    init (dic: NSDictionary)
    {
        self.status = dic.value(forKey: "status") as! String
        let vc = dic.value(forKey: "final_mark")
        if let s = vc.unsafelyUnwrapped as? Int32
        {
            self.finalMark = s
        }
        else
        {
            self.finalMark = 0
        }
        self.name = ""
        if let project = dic.value(forKey: "project") as? NSDictionary
        {
            self.name = project.value(forKey: "slug") as! String
        }
        
    }
}
