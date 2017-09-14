//
//  OperationTableViewCell.swift
//  Demo1
//
//  Created by 智衡宋 on 2017/8/2.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class OperationTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
