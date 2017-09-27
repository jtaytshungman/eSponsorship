//
//  TournamentTableViewCell.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 28/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class TournamentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tournamentName: UILabel!
    @IBOutlet weak var numberOfParticipants: UILabel!
    @IBOutlet weak var locationOfTournament: UILabel!
    @IBOutlet weak var organizerName: UILabel!
    
    @IBOutlet weak var backgroundImageCell: UIImageView!
    
    static let cellIdentifier = "TournamentCell"
    static let cellNib = UINib(nibName: "TournamentTableViewCell", bundle: Bundle.main)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
