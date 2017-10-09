//
//  TournamentTableViewCell.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 28/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class GamersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tournamentNamek: UILabel!
    @IBOutlet weak var numberOfParticipantsk: UILabel!
    @IBOutlet weak var locationOfTournamentk: UILabel!
    @IBOutlet weak var organizerNamek: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var descTextField: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    
    static let cellIdentifier = "GamersCell"
    static let cellNib = UINib(nibName: "GamersTableViewCell", bundle: Bundle.main)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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

