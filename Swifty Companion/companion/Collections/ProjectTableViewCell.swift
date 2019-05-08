//
//  ProjectTableViewCell.swift
//  companion
//
//  Created by Rapula MAAKE on 2018/10/24.
//  Copyright © 2018 Rapula MAAKE. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func displayData(data: ProjectsData)
    {
        self.statusLabel.text = "Status: " + data.status
        self.projectLabel.text = data.name
        self.valueLabel.text = String(data.finalMark) + "%"
        self.progressBar.progress = Float(data.finalMark) / 100
        self.backgroundColor = UIColor.clear
    }

}
