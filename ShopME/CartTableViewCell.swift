//
//  CartTableViewCell.swift
//  ShopME
//
//  Created by Wes Bosman on 2/26/17.
//  Copyright © 2017 Wes Bosman. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var cartItemTitle: UILabel!
    @IBOutlet weak var cartItemPrice: UILabel!
    @IBOutlet weak var cartIncreaseButton: UIButton!
    @IBOutlet weak var cartDecreaseButton: UIButton!
    @IBOutlet weak var cartItemQuantity: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cartItemTitle.layer.cornerRadius = 5
        cartItemTitle.textAlignment = .center
        cartItemTitle.layer.backgroundColor = UIColor.blue.cgColor
        cartItemTitle.textColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
