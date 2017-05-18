//
//  RecentOrderViewController.swift
//  ShopME
//
//  Created by Wes Bosman on 2/28/17.
//  Copyright © 2017 Wes Bosman. All rights reserved.
//

import UIKit

class RecentOrderViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource{

    @IBOutlet weak var recentOrderTableView: UITableView!
    let cellID = "RecentOrderCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        recentOrderTableView.dataSource = self
        recentOrderTableView.delegate = self
        
        recentOrderTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Sort the recent orders
        GlobalCategories.recentOrders.sort(by: {(a: RecentOrder, b: RecentOrder) -> Bool in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM/d, EEE, h:mm a"
            let aDate = dateFormatter.date(from: a.orderDetail)
            let bDate = dateFormatter.date(from: b.orderDetail)
            
            if((aDate?.compare(bDate!)) == .orderedDescending){
                return true
            }
            return false
        })
    }

    @IBAction func editTableView(_ sender: Any) {
        // If the table is being edited give user a way to stop editing
        if (self.recentOrderTableView.isEditing){
            self.navigationItem.rightBarButtonItem?.title = "Edit"
            self.recentOrderTableView.setEditing(false, animated: true)
        }
        // Edit the table view
        else{
            self.navigationItem.rightBarButtonItem?.title = "Done"
            self.recentOrderTableView.setEditing(true, animated: true)
        }
    }
    // MARK - Table View Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if GlobalCategories.recentOrders.count > 10{
            GlobalCategories.recentOrders.remove(at: 0)
            return 10
        }
        return GlobalCategories.recentOrders.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RecentOrderTableViewCell
        let recentOrder = GlobalCategories.recentOrders[indexPath.row]
        cell.orderTitle.text = recentOrder.orderTitle
        cell.orderDetail.text = recentOrder.orderDetail
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        GlobalCategories.recentOrders.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        self.recentOrderTableView.reloadData()
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
