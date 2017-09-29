//
//  MenuItemsTableViewCell.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 29/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class MenuItemsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var menuItemsLabel: UILabel!
   
    static let cellIdentifier = "menuItemCells"
    static let cellNib = UINib(nibName: "MenuItemsTableViewCell", bundle: Bundle.main)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
