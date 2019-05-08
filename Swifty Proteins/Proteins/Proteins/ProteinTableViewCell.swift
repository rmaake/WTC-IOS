//
//  ProteinTableViewCell.swift
//  Proteins
//
//  Created by Rapula MAAKE on 2018/11/20.
//  Copyright © 2018 Rapula MAAKE. All rights reserved.
//

import UIKit

class ProteinTableViewCell: UITableViewCell {

    @IBOutlet weak var proteinLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func displayData(view: ListViewController, index: Int)
    {
        if (index % 2 == 0)
        {
            self.backgroundColor = UIColor.lightGray
            self.proteinLabel.textColor = UIColor.black
        }
        else
        {
            self.backgroundColor = UIColor.black
            self.proteinLabel.textColor = UIColor.lightText
        }
        if (view.isSearching == true)
        {
            self.proteinLabel.text = String(view.subList[index])
        }
        else
        {
            self.proteinLabel.text = String(view.list[index])
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
