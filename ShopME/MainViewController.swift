//
//  MainViewController.swift
//  ShopME
//
//  Created by Wes Bosman on 2/21/17.
//  Copyright © 2017 Wes Bosman. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var mainNavItem: UINavigationItem!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    let cellIdentifier: String = "CategoryCell"
    let headerIdentifier: String = "CategoryHeader"
    var cartItems   = 0
    let itemsPerRow = 2
    let cellHeight  = 125
    let cellWidth   = 125
    let titleImage  = UIImage(named: "TitleLogo")
    let recentSegue = "RecentOrderSegue"
    let cartSegue   = "CartSegue"
    let manageSegue = "ManageSegue"
    let categorySegue = "CategorySegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        self.navigationItem.titleView = UIImageView(image: titleImage)
        self.navigationItem.rightBarButtonItem?.title = "Manage"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        categoryCollectionView.reloadData()
        let backgroundImageView = UIImageView(image: UIImage(named: "Background"))
        backgroundImageView.alpha = 0.70
        backgroundImageView.contentMode = .scaleToFill
        categoryCollectionView.backgroundView = backgroundImageView
    }
    
    // Mark - Unwind segue from cart
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue){
        print("Unwound from cart to home")
    }
    
    // Mark - Collection View Methods
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Make a cell and return it
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:cellIdentifier, for: indexPath) as! CategoryCell
        let category = GlobalCategories.categoryArray[indexPath.row]
        
        // If the category name is cart add the number of items to the name
        if category.categoryName == "Cart"{
            
            // Get the number of items in the cart
            var total = 0
            for key in GlobalCategories.cartItemsDictionary.keys{
                if let array = GlobalCategories.cartItemsDictionary[key]{
                    for cartItem in array{
                        total += cartItem.cartItemQuant
                    }
                }
            }
            print("Total -> \(total)")
            let text = "\(category.categoryName) (\(total))"
            cell.categoryLabel.text = "\(text)"
            cell.categoryLabel.textColor = UIColor.white
            cell.categoryImage.image = category.categoryImage
        }
        else{
            cell.categoryLabel.text = "\(category.categoryName)"
            cell.categoryLabel.textColor = UIColor.white
            cell.categoryImage.image = category.categoryImage
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GlobalCategories.categoryArray.count
    }
    
    // Mark - Collection View Flow Layout Methods
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // The cell ought to be 125 X 125
        return CGSize(width: cellWidth, height: cellHeight)
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30.0, left: 30.0, bottom: 20.0, right: 30.0)
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        
        if(cell.categoryLabel.text?.contains("Recent Orders"))!{
            print("Cell contains recent orders")
            self.performSegue(withIdentifier: recentSegue, sender: cell)
        }
        else if(cell.categoryLabel.text?.contains("Cart"))!{
            print("Cell contains Cart")
            self.performSegue(withIdentifier: cartSegue, sender: cell)
        }
        else{
            print("Cell is a category")
            self.performSegue(withIdentifier: categorySegue, sender: cell)
        }
    }
    

    // MARK: - Navigation

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == categorySegue){
            print("Segue to Category View Controller")
            
            // Pass information for the given category
            if let cell = sender as? CategoryCell{
                let category = cell.categoryLabel.text
                
                // Send the title to the destination controller
                if let destinationVC = segue.destination as? CategoryViewController,
                    let cat = category{
                    
                    // Replace the text to make the banners
                    var newCategory = cat
                        .replacingOccurrences(of: "< ", with: "")
                    newCategory = newCategory
                        .replacingOccurrences(of: " >", with: "")
                    
                    // Pass the category in and use it as a dictionary key
                    print("New Category:\(newCategory)")
                    
                    destinationVC.categoryTitleLabel.title = newCategory
                    destinationVC.categoryPassedIn = newCategory
                }
            }
        }
        else if(segue.identifier == manageSegue){
            print("Segue to Manage View Controller")
            
        }
        else if(segue.identifier == recentSegue){
            print("Recent Order Segue")
        }
        else if(segue.identifier == cartSegue){
            print("Chart Segue")
        }
    }
}




