//
//  TableViewCell.swift
//  Sideslip&TabbarLikeQQDemo
//
//  Created by tayoMIS on 16/1/18.
//  Copyright © 2016年 刘旭东. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var code: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
