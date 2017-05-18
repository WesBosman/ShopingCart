//
//  ManageViewController.swift
//  ShopME
//
//  Created by Wes Bosman on 2/27/17.
//  Copyright © 2017 Wes Bosman. All rights reserved.
//

import UIKit

class ManageViewController:
    UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    UITextFieldDelegate,
    UITextViewDelegate{
    
    var predefinedCategories: [String] = []
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryItemImage: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryNameTextField: UITextField!
    @IBOutlet weak var categoryItemName: UILabel!
    @IBOutlet weak var categoryItemNameTextField: UITextField!
    @IBOutlet weak var categoryDescriptionLabel: UILabel!
    @IBOutlet weak var categoryDescriptionTextField: UITextField!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemPriceTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    let imagePicker = UIImagePickerController()
    var categoryImageClicked = false
    var categoryItemClicked  = false
    let cornerRad:CGFloat = 25
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        categoryNameTextField.delegate = self
        categoryItemNameTextField.delegate = self
        categoryDescriptionTextField.delegate = self
        itemPriceTextField.delegate = self
        
        // Set radius of corner labels
        categoryNameLabel.layer.cornerRadius = cornerRad
        categoryItemName.layer.cornerRadius = cornerRad
        categoryDescriptionLabel.layer.cornerRadius = cornerRad
        itemPriceLabel.layer.cornerRadius = cornerRad
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setItemImagePressed(_ sender: Any) {
        print("Set Item Image Pressed")
        categoryItemClicked = true
        categoryImageClicked = false
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func setCategoryImagePressed(_ sender: Any) {
        print("Set Category Image Pressed")
        categoryItemClicked = false
        categoryImageClicked = true
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        print("Add Button Pressed")
        if let category = categoryNameTextField.text,
            let categoryImage = categoryImage.image,
            let item = categoryItemNameTextField.text,
            let price = Double(itemPriceTextField.text!),
            let desc = categoryDescriptionTextField.text,
            let categoryItemImage = categoryItemImage.image{
            
            let categoryMain = Category(category: category,
                                        categoryImage: categoryImage)
            let categoryItem = CategoryItem(name: item,
                                            price: price,
                                            descript: desc,
                                            itemImage: categoryItemImage)
            
            if GlobalCategories.categoryArray.contains(where:
                {categoryMain.categoryName == $0.categoryName}){
                
                // If the category name is cart or recent orders do not create a new category
                if(categoryMain.categoryName == "Cart"
                    || categoryMain.categoryName == "Recent Orders"){
                    let alert = UIAlertController(title: "Error", message: "Can not create a category of the type \(categoryMain.categoryName). It is not allowed to add items to the cart or recent orders. You may add items to the other categories though or create a new one.", preferredStyle: .alert)
                    let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                    alert.addAction(dismiss)
                    self.present(alert, animated: true, completion: nil)
                }
                // Create a new category
                else{
                    print("Category: \(categoryMain.categoryName) is in predefined categories")
                
                    if let index = GlobalCategories.categoryArray.index(where:
                        {categoryMain.categoryName == $0.categoryName}){
                        print("Found Category -> \(categoryMain.categoryName) as index -> \(index)")
                    
                        // Add this info to the dictionary
                        if var array = GlobalCategories.categoryDictionary[categoryMain.categoryName]{
                            print("Adding to a main category in dictionary")
                            // Add item to array
                            array.append(categoryItem)
                            // Reset dictionary to be equal to new array
                            GlobalCategories.categoryDictionary[categoryMain.categoryName] = array
                        }
                        else{
                            print("Adding to dictionary a main category")
                            GlobalCategories.categoryDictionary[categoryMain.categoryName] = [categoryItem]
                        }
                    }
                    
                    let alert = UIAlertController(title: "Success", message: "Created a new item in the category \(categoryMain.categoryName)", preferredStyle: .alert)
                    let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                    alert.addAction(dismiss)
                    self.present(alert, animated: true, completion: nil)
                    
                    // Reset all the fields
                    self.categoryNameTextField.text = nil
                    self.itemPriceTextField.text = nil
                    self.categoryItemNameTextField.text = nil
                    self.categoryDescriptionTextField.text = nil
                    self.categoryItemImage.image = nil
                    self.categoryImage.image = nil
                }
            }
            else{
                print("Category: \(category) is not in predefined categories")
                let alert = UIAlertController(title: "Error",
                                              message: "Category has not been previously defined would you like to create a new category?",
                                              preferredStyle: .alert)
                let yes = UIAlertAction(title: "Yes", style: .default, handler: {
                    (action: UIAlertAction) in
                    GlobalCategories.categoryArray.append(categoryMain)
                    GlobalCategories
                        .categoryDictionary[categoryMain.categoryName] = [categoryItem]
                    
                    // Reset all the fields
                    self.categoryNameTextField.text = nil
                    self.itemPriceTextField.text = nil
                    self.categoryItemNameTextField.text = nil
                    self.categoryDescriptionTextField.text = nil
                    self.categoryItemImage.image = nil
                    self.categoryImage.image = nil
                })
                let no = UIAlertAction(title: "No", style: .destructive, handler: nil)
                alert.addAction(no)
                alert.addAction(yes)
                self.present(alert, animated: true, completion: nil)
            }
            
            
            
        }
        else{
            let alert = UIAlertController(title: "Error", message: "One or more fields is not filled in. Or the price text field does not contain a valid double", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            alert.addAction(dismiss)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Mark - TextField Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Should resign first responder")
        textField.resignFirstResponder()
        return true
    }
    
    // Mark - Image Picker Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("User Picked an Image")
        if let imagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            // Category image was clicked
            if (categoryImageClicked){
                categoryImage.image = imagePicked
            }
            // Category item was clicked
            else if (categoryItemClicked){
                categoryItemImage.image = imagePicked
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("User Canceled Picking an Image")
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
