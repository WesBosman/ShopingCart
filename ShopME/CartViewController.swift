//
//  CartViewController.swift
//  ShopME
//
//  Created by Wes Bosman on 2/26/17.
//  Copyright © 2017 Wes Bosman. All rights reserved.
//

import UIKit

class CartViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource {

    @IBOutlet weak var cartTableView: UITableView!
    let cellID = "CartCell"
    let homeImg = UIImage(named: "Home")!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the datasource and delegate for the table view
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        // Create home navigation button
        let button: UIButton = UIButton(type: .custom)
        button.setImage(homeImg, for: .normal)
        button.addTarget(self, action: #selector(CartViewController.homeButtonPressed), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        // Set the view as the bar button item
        let cartButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = cartButton

        // Do any additional setup after loading the view.
        cartTableView.tableFooterView = UIView()
        cartTableView.allowsSelection = false
        
        // Initially set the subtotal and quantity
        subtotalLabel.text = "$0.00"
        quantityLabel.text = "0"
        
        setCartTotal()
        setCartQuantity()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cartTableView.reloadData()
        setCartTotal()
        setCartQuantity()
    }
    
    // Buy the items in the cart
    @IBAction func buyCartButtonPressed(_ sender: Any) {
        print("Buy items in cart")
        let alert = UIAlertController(title: "Payment",
                                      message: "Are you sure you want to buy the selected items for \(subtotalLabel.text!)?", preferredStyle: .alert)
        let buy = UIAlertAction(title: "Place Order", style: .default, handler: {(action) in
                // Add item to recent orders
                if let price = self.subtotalLabel.text,
                    let quant = self.quantityLabel.text{
                    let dateformatter = DateFormatter()
                    dateformatter.dateFormat = "MMM/d, EEE, h:mm a"
                    
                    let orderTitle = "\(quant) Items (\(price))"
                    let detailTitle = dateformatter.string(from: Date())
                    let recentOrder = RecentOrder(orderTitle: orderTitle,
                                                  orderDetail: detailTitle)
                    
                    // Add recent order to the array
                    GlobalCategories.recentOrders.append(recentOrder)
            }
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(buy)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    // Clear the items in the table and dictionary
    @IBAction func clearCartButtonPressed(_ sender: Any) {
        print("Clear items in cart")
        let alert = UIAlertController(title: "Clear Items",
                                      message: "Are you sure you want to remove these items?",
                                      preferredStyle: .alert)
        let clear = UIAlertAction(title: "Clear", style: .destructive,
                    handler: {(action) in
                        // Clear all items and reload the table
                        GlobalCategories.cartItemsDictionary.removeAll()
                        GlobalCategories.cartSectionsArray.removeAll()
                        self.cartTableView.reloadData()
        })
        let dismiss = UIAlertAction(title: "Exit Menu", style: .cancel, handler: nil)
        alert.addAction(clear)
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
    }
    
    // Set the total of the items in the cart
    func setCartTotal(){
        var totalPrice: Double = 0
        for section in GlobalCategories.cartSectionsArray{
            if let items = GlobalCategories.cartItemsDictionary[section]{
                for cartItem in items{
                    if cartItem.cartItemQuant > 0{
                        let price = cartItem.cartItemPrice
                        let quant = Double(cartItem.cartItemQuant)
                        totalPrice = totalPrice + (price * quant)
                    }
                }
            }
        }
        subtotalLabel.text = String(format: "$%.2f", totalPrice)
    }
    
    // Set the quantity of the items in the cart
    func setCartQuantity(){
        var totalQuantity: Int = 0
        for section in GlobalCategories.cartSectionsArray{
            if let items = GlobalCategories.cartItemsDictionary[section]{
                for cartItem in items{
                        totalQuantity = totalQuantity + cartItem.cartItemQuant
                }
            }
        }
        quantityLabel.text = "\(totalQuantity)"
    }
    
    func homeButtonPressed(){
        print("Home Button Pressed")
        self.performSegue(withIdentifier: "UnwindToHome", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return GlobalCategories.cartItemsDictionary.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalCategories.cartItemsDictionary[GlobalCategories.cartSectionsArray[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CartTableViewCell
        if let cartItems = GlobalCategories
                            .cartItemsDictionary[GlobalCategories
                                    .cartSectionsArray[indexPath.section]]{
            let cartItem = cartItems[indexPath.row] as CartItem

            cartCell.cartItemPrice.text = String(format: "$%.2f",
                                                 cartItem.cartItemPrice)
            cartCell.cartItemTitle.text    = cartItem.cartItemTitle
            cartCell.cartItemQuantity.text = "\(cartItem.cartItemQuant)"
            cartCell.cartIncreaseButton.tag = indexPath.row
            cartCell.cartDecreaseButton.tag = indexPath.row
            cartCell.cartIncreaseButton.addTarget(self,
                                                  action: #selector(CartViewController.cartQuantityIncreased), for: .touchUpInside)
            cartCell.cartDecreaseButton.addTarget(self,
                                                  action: #selector(CartViewController.cartQuantityDecreased),
                                                      for: .touchUpInside)

            return cartCell
        }
        
        else{
            return UITableViewCell()
        }
    }
    
    func cartQuantityIncreased(sender: UIButton){
        print("Cart Quantity Increased in View Controller")
        // Need to get the cell here 
        let buttonPoint = sender.convert(CGPoint.zero,
                                         to: self.cartTableView)
        if let indexPath = self.cartTableView.indexPathForRow(at: buttonPoint){
            if let cell: CartTableViewCell = self.cartTableView.cellForRow(at: indexPath) as? CartTableViewCell{

                // Get the old cell's values and change them
                if let cellTitle = cell.cartItemTitle.text,
                    let cellPrice = Double(cell.cartItemPrice.text!
                                    .replacingOccurrences(of: "$", with: "")),
                    let cellQuant = Int(cell.cartItemQuantity.text!){
                    
                    print("Cell Title -> \(cellTitle)")
                    print("Cell Price -> \(cellPrice)")
                    print("Cell Quant -> \(cellQuant)")
                    
                    let newQuant = cellQuant + 1
                    // Make a new cart item and update the dictionary
                    let newCartItem = CartItem(cartItemTitle: cellTitle,
                                               cartItemPrice: cellPrice,
                                               cartItemQuant: newQuant)
                    
                    print("New Quant -> \(newQuant)")
                    // Get the section from the global cart array
                    let key = GlobalCategories
                                .cartSectionsArray[indexPath.section]
                    
                    var array = GlobalCategories.cartItemsDictionary[key]
                    
                    array?[indexPath.row] = newCartItem
                    GlobalCategories.cartItemsDictionary[key] = array!
                    
                    self.cartTableView.reloadData()
                }
            }
        }
        // Reset the cart quantity and the total
        setCartQuantity()
        setCartTotal()
    }
    
    func cartQuantityDecreased(sender: UIButton){
        print("Cart Quantity Decreased in View Controller")
        // Get button location
        let buttonPoint = sender.convert(CGPoint.zero, to: self.cartTableView)
        
        // Get the index Path
        if let indexPath = self.cartTableView.indexPathForRow(at: buttonPoint){
            if let cell = self.cartTableView.cellForRow(at: indexPath) as? CartTableViewCell{
                
                // Get the old cells values
                if let cellTitle = cell.cartItemTitle.text,
                    let cellPrice = Double(cell.cartItemPrice.text!.replacingOccurrences(of: "$", with: "")),
                    let cellQuant = Int(cell.cartItemQuantity.text!){
                    
                    print("Cell Title -> \(cellTitle)")
                    print("Cell Price -> \(cellPrice)")
                    print("Cell Quant -> \(cellQuant)")
                    
                    if cellQuant > 0{
                        let newQuant = cellQuant - 1
                        
                        // TODO - Delete an item when the quantity is zero
                        if newQuant == 0{
                            print("New Quant is zero")
                            let key = GlobalCategories.cartSectionsArray[indexPath.section]
                            var array = GlobalCategories.cartItemsDictionary[key]
                            
                            array?.remove(at: indexPath.row)
                            GlobalCategories.cartItemsDictionary[key] = array
                            
                            // If there is nothing left in the array remove the section from the db
                            if array?.count == 0{
                                print("Nothing left in section remove section header")
                                GlobalCategories.cartItemsDictionary.removeValue(forKey: key)
                                GlobalCategories.cartSectionsArray.remove(at: indexPath.section)
                                
                            }
                            
                            
                        }
                        else{
                        
                        print("New Quant -> \(newQuant)")
                        // Create a new cart item
                        let newCartItem = CartItem(cartItemTitle: cellTitle,
                                                   cartItemPrice: cellPrice,
                                                   cartItemQuant: newQuant)
                        
                        // Update the dictionary
                        let key = GlobalCategories.cartSectionsArray[indexPath.section]
                        
                        // Update list in dictionary
                        var array = GlobalCategories.cartItemsDictionary[key]
                        array?[indexPath.row] = newCartItem
                        GlobalCategories.cartItemsDictionary[key] = array!
                        }
                        
                        // Reload table view
                        self.cartTableView.reloadData()
                }
                else{
                    let alert = UIAlertController(title: "Error",
                                                      message: "Can not have a negative amount of items in the cart", preferredStyle: .alert)
                    let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                    alert.addAction(dismissAction)
                    self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        
        // Update the cart quantity and price
        setCartQuantity()
        setCartTotal()
    }
    
    // Mark - Header Methods
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let key = GlobalCategories.cartSectionsArray[section]
        return key
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
