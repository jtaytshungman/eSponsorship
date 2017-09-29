//
//  SideMenuTableViewController.swift
//  
//
//  Created by Jeremy Tay on 29/09/2017.
//

import UIKit

class SideMenuTableViewController: UITableViewController {
    
    // Array of items in menu to appear
    let menuItemsArray : [String] = [
        "Add Team",
        "Add Tournaments",
        "About",
        "Sponsors"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Menu"
        tableView.register(MenuItemsTableViewCell.cellNib, forCellReuseIdentifier: MenuItemsTableViewCell.cellIdentifier)
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemsTableViewCell.cellIdentifier, for: indexPath) as? MenuItemsTableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = menuItemsArray[indexPath.row]
        return cell
    }

}
