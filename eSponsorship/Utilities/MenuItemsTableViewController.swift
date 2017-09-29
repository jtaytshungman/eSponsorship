//
//  MenuItemsTableViewController.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 28/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class MenuItemsTableViewController: UITableViewController {
    
    let menuItems : [String]  = [
        "Profile",
        "Add Team",
        "Add Tournament",
        "Add Gamers",
        "About",
        "Sponsors"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Menu"
        tableView.register(TournamentTableViewCell.cellNib, forCellReuseIdentifier: TournamentTableViewCell.cellIdentifier)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cellMenu", for: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TournamentTableViewCell.cellIdentifier, for: indexPath) as? TournamentTableViewCell else {return UITableViewCell()}
        //cell.textLabel?.text = menuItems[indexPath.row]
        return cell
        //return UITableViewCell()
    }
}
