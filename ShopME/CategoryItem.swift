//
//  CategoryItem.swift
//  ShopME
//
//  Created by Wes Bosman on 2/27/17.
//  Copyright © 2017 Wes Bosman. All rights reserved.
//

import Foundation
import UIKit

// This structure is for holding the information of an item that belongs to a category
struct CategoryItem{
    var name:        String
    var price:       Double
    var descript:    String
    var itemImage:   UIImage
    
    init(name:String,
         price:Double,
         descript:String,
         itemImage:UIImage){
        self.name = name
        self.price = price
        self.descript = descript
        self.itemImage = itemImage
    }
}
