//
//  RecentOrder.swift
//  ShopME
//
//  Created by Wes Bosman on 3/2/17.
//  Copyright © 2017 Wes Bosman. All rights reserved.
//

import Foundation

struct RecentOrder{
    var orderTitle: String
    var orderDetail: String
    
    init(orderTitle:String, orderDetail: String){
        self.orderTitle = orderTitle
        self.orderDetail = orderDetail
    }
}
