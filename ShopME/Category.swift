//
//  Category.swift
//  ShopME
//
//  Created by Wes Bosman on 2/27/17.
//  Copyright © 2017 Wes Bosman. All rights reserved.
//

import Foundation
import UIKit

// Static structure to access the categories accross different classes
struct GlobalCategories{
    static var categoryDictionary: [String: [CategoryItem]] = [
        // Grocery Items
        "Grocery": [CategoryItem(name: "Apples",
                                 price: 2.50,
                                 descript: "Fuji Apples",
                                 itemImage: UIImage(named: "Apples")!),
                    CategoryItem(name: "Bananas",
                                 price: 1.50,
                                 descript: "Yellow Bananas",
                                 itemImage: UIImage(named: "Bananas")! ),
                    CategoryItem(name: "Milk",
                                 price: 4.50,
                                 descript: "2% Milk",
                                 itemImage: UIImage(named: "Milk")! ),
                    CategoryItem(name: "Bread",
                                 price: 0.89,
                                 descript: "Wheat Bread",
                                 itemImage: UIImage(named: "Bread")! ),
                    CategoryItem(name: "Tomatoes",
                                 price: 2.00,
                                 descript: "Red Tomatoes",
                                 itemImage: UIImage(named: "Tomatoes")! ) ] ,
        // Garden Items
        "Garden": [CategoryItem(name: "Rake",
                                  price: 15.00,
                                  descript: "A rake for fall",
                                  itemImage: UIImage(named: "Rake")!) ,
                   CategoryItem(name: "Plant",
                                price: 5.00,
                                descript: "A nice plant for indoors",
                                itemImage: UIImage(named: "Plant")!) ,
                   CategoryItem(name: "Lawnmower",
                                price: 115.00,
                                descript: "A push mower for the lawn",
                                itemImage: UIImage(named: "Lawnmower")!) ,
                   CategoryItem(name: "Shovel",
                                price: 15.00,
                                descript: "A nice sturdy shovel",
                                itemImage: UIImage(named: "Shovel")!) ,
                   CategoryItem(name: "Pear Tree",
                                price: 8.50,
                                descript: "A nice pear tree",
                                itemImage: UIImage(named: "Peartree")! ) ] ,
        // Clothing Items
        "Clothing": [CategoryItem(name: "Hat",
                                price: 9.99,
                                descript: "Fedora hats",
                                itemImage: UIImage(named: "Hats")!) ,
                   CategoryItem(name: "Belt",
                                price: 15.00,
                                descript: "Brown leather belt",
                                itemImage: UIImage(named: "Belt")!) ,
                   CategoryItem(name: "Jeans",
                                price: 19.99,
                                descript: "Denim blue jeans",
                                itemImage: UIImage(named: "Jeans")!) ,
                   CategoryItem(name: "Shoes",
                                price: 35.00,
                                descript: "Blue and white sneakers",
                                itemImage: UIImage(named: "Shoes")!) ,
                   CategoryItem(name: "Watch",
                                price: 85.00,
                                descript: "Nice watch",
                                itemImage: UIImage(named: "Watch")!)],
        // Movie Items
        "Movies": [CategoryItem(name: "The Godfather",
                                price: 13.00,
                                descript: "A gangster film",
                                itemImage: UIImage(named: "Godfather")!) ,
                   CategoryItem(name: "Shawshank Redemption",
                                price: 15.00,
                                descript: "A wrongly convicted criminal",
                                itemImage: UIImage(named: "Shawshank")!) ,
                   CategoryItem(name: "Lord of the Rings",
                                price: 14.99,
                                descript: "A battle for Middle Earth",
                                itemImage: UIImage(named: "LordOfTheRings")!),
                   CategoryItem(name: "Fight Club",
                                price: 5.00,
                                descript: "A dark twisted thriller",
                                itemImage: UIImage(named: "FightClub")!),
                   CategoryItem(name: "Goodfellas",
                                price: 8.99,
                                descript: "A classic mod movie",
                                itemImage: UIImage(named: "Goodfellas")!)] ,
        // Electronics Items
        "Electronics": [CategoryItem(name: "Television",
                                price: 230.99,
                                descript: "A great hd tv",
                                itemImage: UIImage(named: "Television")!) ,
                   CategoryItem(name: "Gameboy Color",
                                price: 65.00,
                                descript: "A portable game device",
                                itemImage: UIImage(named: "Gameboy")!) ,
                   CategoryItem(name: "iPhone",
                                price: 499.99,
                                descript: "An apple iPhone",
                                itemImage: UIImage(named: "iPhone")!),
                   CategoryItem(name: "Macbook",
                                price: 1299.99,
                                descript: "A great personal computer",
                                itemImage: UIImage(named: "Macbook")!),
                   CategoryItem(name: "Xbox",
                                price: 399.99,
                                descript: "A great videogame system",
                                itemImage: UIImage(named: "Xbox")!)] ,
        // Book Items
        "Books": [CategoryItem(name: "iRobot",
                                price: 10.99,
                                descript: "A post modern world with robots",
                                itemImage: UIImage(named: "iRobot")!) ,
                   CategoryItem(name: "Brave New World",
                                price: 11.99,
                                descript: "A modern eutopia",
                                itemImage: UIImage(named: "BraveNewWorld")!) ,
                   CategoryItem(name: "The Great Gatsby",
                                price: 9.99,
                                descript: "A classic love triangle",
                                itemImage: UIImage(named: "GreatGatsby")!),
                   CategoryItem(name: "Game of Thrones",
                                price: 10.99,
                                descript: "A popular war story",
                                itemImage: UIImage(named: "GameOfThrones")!),
                   CategoryItem(name: "Hunger Games",
                                price: 8.99,
                                descript: "A eutopian world where people fight to survive",
                                itemImage: UIImage(named: "HungerGames")!)] ,
        // Appliance Items
        "Appliances": [CategoryItem(name: "Toaster",
                               price: 19.99,
                               descript: "A great little toaster",
                               itemImage: UIImage(named: "Toaster")!) ,
                  CategoryItem(name: "Coffee Maker",
                               price: 29.99,
                               descript: "An awesome Keurig Coffee Maker",
                               itemImage: UIImage(named: "CoffeeMaker")!) ,
                  CategoryItem(name: "Mixer",
                               price: 19.99,
                               descript: "A mixer for baking",
                               itemImage: UIImage(named: "Mixer")!),
                  CategoryItem(name: "Blender",
                               price: 10.99,
                               descript: "A great blender for making smoothies and milkshakes",
                               itemImage: UIImage(named: "Blender")!),
                  CategoryItem(name: "Microwave",
                               price: 89.99,
                               descript: "A powerful microwave for cooking",
                               itemImage: UIImage(named: "Microwave")!)] ,
        // Toy Items
        "Toys": [CategoryItem(name: "Pikachu",
                               price: 10.99,
                               descript: "A awesome toy for a girl or a boy",
                               itemImage: UIImage(named: "Pikachu")!) ,
                  CategoryItem(name: "Mr. Potato Head",
                               price: 11.99,
                               descript: "A Mr. Potato Head Doll from Toy Story",
                               itemImage: UIImage(named: "Potatohead")!) ,
                  CategoryItem(name: "Transformer",
                               price: 9.99,
                               descript: "Optimus Prime an autobot from the transformer movies",
                               itemImage: UIImage(named: "Transformer")!),
                  CategoryItem(name: "Bicycle",
                               price: 59.99,
                               descript: "A kids bicycle",
                               itemImage: UIImage(named: "Bicycle")!),
                  CategoryItem(name: "Skateboard",
                               price: 24.99,
                               descript: "A great skateboard",
                               itemImage: UIImage(named: "Skateboard")!)]
    ]
    
    static var categoryArray: [Category] = [
        Category(category: "Recent Orders",
                categoryImage: UIImage(named: "Recent")!),
        Category(category: "Cart",
                 categoryImage: UIImage(named: "Cart")!),
        Category(category: "Grocery",
                 categoryImage: UIImage(named: "Grocery")!),
        Category(category: "Clothing",
                 categoryImage: UIImage(named: "Clothing")!),
        Category(category: "Movies",
                 categoryImage: UIImage(named: "Movies")!),
        Category(category: "Garden",
                 categoryImage: UIImage(named: "Garden")!),
        Category(category: "Electronics",
                 categoryImage: UIImage(named: "Electronics")!),
        Category(category: "Books",
                 categoryImage: UIImage(named: "Books")!),
        Category(category: "Appliances",
                 categoryImage: UIImage(named: "Appliances")!),
        Category(category: "Toys",
                 categoryImage: UIImage(named: "Toys")!),
    ]
    
    // Array to hold items in the cart
    static var cartItemsDictionary: [String: [CartItem]] = [:]
    static var cartSectionsArray: [String] = []
    
    // Array to keep track of recent orders
    static var recentOrders: [RecentOrder] = []
    
}

class Category{
    var categoryName: String
    var categoryImage: UIImage
    
    init(category: String, categoryImage: UIImage) {
        self.categoryName = category
        self.categoryImage = categoryImage
    }
}
