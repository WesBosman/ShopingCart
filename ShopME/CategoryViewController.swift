//
//  ViewController.swift
//  ShopME
//
//  Created by Wes Bosman on 2/23/17.
//  Copyright © 2017 Wes Bosman. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController,
    UITableViewDelegate,
    UITableViewDataSource{
    
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var categoryTitleLabel: UINavigationItem!
    let cellID = "CategoryTableViewCell"
    let cartImage = UIImage(named: "SmallCart")
    let cartSegue: String = "CartSegue"
    var cartItemCount = 0
    var categoryPassedIn = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        calculateTotalCartItems()
        
        // Remove the lines when there are no items to show
        categoryTableView.tableFooterView = UIView()
        
        // Set the cells to resize themselves dynamically
        categoryTableView.rowHeight = UITableViewAutomaticDimension
        categoryTableView.estimatedRowHeight = 90
        
        // Don't allow selection of cells
        self.categoryTableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        calculateTotalCartItems()
    }
    
    func calculateTotalCartItems(){
        // Iterate through the keys of the dictionary sum up the quantity
        var total:Int = 0
        for item in GlobalCategories.cartItemsDictionary.keys{
            for cartItem in GlobalCategories.cartItemsDictionary[item]!{
                total += cartItem.cartItemQuant
            }
        }
        cartItemCount = total
        
        
        // Create a view
        let view = UIView(frame: CGRect(x:0, y:0, width: 80, height: 30))
        
        // Create a button
        let button: UIButton = UIButton(type: .custom)
        button.setImage(cartImage, for: .normal)
        button.addTarget(self, action: #selector(CategoryViewController.cartButtonPressed), for: .touchUpInside)
        button.frame = CGRect(x: 60, y: 0, width: 30, height: 30)
        
        // Create a label
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 5, width: 60, height: 30))
        label.font = UIFont(name: "Helvetica", size: 15)
        label.text = "Cart (\(cartItemCount))"
        
        // Add the button and label to the view
        view.addSubview(label)
        view.addSubview(button)
        
        // Set the view as the bar button item
        let cartButton = UIBarButtonItem(customView: view)
        self.navigationItem.rightBarButtonItem = cartButton
    }
    
    func cartButtonPressed(){
        print("Cart Button Pressed")
        performSegue(withIdentifier: cartSegue, sender: nil)
    }
    
    func cellAddButtonClicked(){
        print("Cell Add button clicked in View Controller")
        calculateTotalCartItems()
    }
    
    // MARK - Table View Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! CategoryTableViewCell

        // Get the list of category items from the dictionary
        if let item = GlobalCategories.categoryDictionary[categoryPassedIn]{
            let tableItem = item[indexPath.row]
            let priceAsString = String(format: "$%.2f", tableItem.price)
            cell.categoryImage.image = tableItem.itemImage
            cell.categoryName.text = tableItem.name
            cell.categoryPrice.text = priceAsString
            cell.categoryDescription.text = tableItem.descript
            cell.categoryDescription.sizeToFit()
            cell.category = categoryPassedIn
            cell.addButton.tag = indexPath.row
            cell.addButton.addTarget(self, action: #selector (CategoryViewController.cellAddButtonClicked),
                                     for: .touchUpInside)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if GlobalCategories.categoryDictionary[categoryPassedIn] == nil{
            return 0
        }
        return (GlobalCategories.categoryDictionary[categoryPassedIn]?.count)!
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
