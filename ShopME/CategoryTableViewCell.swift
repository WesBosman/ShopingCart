//
//  CategoryTableViewCell.swift
//  ShopME
//
//  Created by Wes Bosman on 2/23/17.
//  Copyright © 2017 Wes Bosman. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryDescription: UILabel!
    @IBOutlet weak var categoryPrice: UILabel!
    @IBOutlet weak var addButton: UIButton!
    var category: String = String()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.categoryName.layer.backgroundColor = UIColor.blue.cgColor
        self.categoryName.textColor = UIColor.white
        self.categoryName.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addItemToCart(_ sender: Any) {
        print("Add button pressed")
        // Update the cart 
        var price = self.categoryPrice.text!
        price = price.replacingOccurrences(of: "$", with: "")
        let item = CartItem(cartItemTitle: self.categoryName.text!,
                            cartItemPrice: Double(price)!,
                            cartItemQuant: 1)
        
        // If the global array for sections does not have the current section add it
        if(!GlobalCategories.cartSectionsArray.contains(category)){
            GlobalCategories.cartSectionsArray.append(category)
        }
        
        // Dictionary is nil
        if(GlobalCategories.cartItemsDictionary[category] == nil){
            GlobalCategories.cartItemsDictionary[category] = [item]
        }
        // Dictionary has some values in it
        else{
            var array = GlobalCategories.cartItemsDictionary[category]
            
            // The array already contains this value so add to the quantity
            if let index = array?.index(where:
                {$0.cartItemTitle == item.cartItemTitle}){
                print("Item is contained at index -> \(index)")
                
                let newItemAtIndex = CartItem(cartItemTitle: item.cartItemTitle,
                                              cartItemPrice: item.cartItemPrice,
                                              cartItemQuant: item.cartItemQuant + 1)
                array?[index] = newItemAtIndex
                GlobalCategories.cartItemsDictionary[category] = array
                
            }
            // The array does not contain this item so append it
            else{
                array?.append(item)
                GlobalCategories.cartItemsDictionary[category] = array
            }
        }
    }
}
