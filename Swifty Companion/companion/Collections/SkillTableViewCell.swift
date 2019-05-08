//
//  SkillTableViewCell.swift
//  companion
//
//  Created by Rapula MAAKE on 2018/10/24.
//  Copyright © 2018 Rapula MAAKE. All rights reserved.
//

import UIKit

class SkillTableViewCell: UITableViewCell {

    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func displayData(data: SkillsData)
    {
        self.skillLabel.text = data.name
        let levelStr = String(data.level)
        var parts = levelStr.split(separator: ".")
        let dec = Int(parts[1])
        self.valueLabel.text = "Level " + parts[0] + " - " + String(dec!) + "%"
        let value = Float(parts[1])! / 100
        self.progressBar.progress = value
        self.progressBar.tintColor = UIColor.cyan
        self.progressBar.backgroundColor = UIColor.black
        self.backgroundColor = nil
        self.skillLabel.textColor = UIColor.white
        self.valueLabel.textColor = UIColor.white
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
