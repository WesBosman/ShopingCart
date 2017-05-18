//
//  RecentOrderTableViewCell.swift
//  ShopME
//
//  Created by Wes Bosman on 3/2/17.
//  Copyright © 2017 Wes Bosman. All rights reserved.
//

import UIKit

class RecentOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderTitle: UILabel!
    @IBOutlet weak var orderDetail: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        orderDetail.textColor = UIColor.lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
