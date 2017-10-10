//
//  TournamentTableViewCell.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 28/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class TournamentTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var topRightLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var subHeaderLabel: UILabel!
    @IBOutlet weak var mainHeaderLabel: UILabel!
    
    @IBOutlet weak var imageHeader: UIImageView!
    
    
    static let cellIdentifier = "TournamentCell"
    static let cellNib = UINib(nibName: "TournamentTableViewCell", bundle: Bundle.main)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        aestheticsFunction ()
        
    }
    
    func aestheticsFunction () {
        bgView.layer.cornerRadius = 10
        imageHeader.layer.cornerRadius = 10
        topRightLabel.layer.cornerRadius = 50
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        contentView.layer.borderWidth = 5
//        contentView.layer.borderColor = UIColor.black.cgColor
//        contentView.layer.cornerRadius = 0
    }
    
}
