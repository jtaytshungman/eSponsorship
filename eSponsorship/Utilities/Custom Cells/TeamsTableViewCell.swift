//
//  File.swift
//  eSponsorship
//
//  Created by Salem Abdulla on 9/29/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import Foundation
import UIKit

class TeamsTableViewCell: UITableViewCell {

@IBOutlet weak var tournamentNameq: UILabel!
@IBOutlet weak var numberOfParticipantsq: UILabel!
@IBOutlet weak var locationOfTournamentq: UILabel!
@IBOutlet weak var organizerNameq: UILabel!

@IBOutlet weak var backgroundImageCellq: UIImageView!

static let cellIdentifier = "TeamsCell"
static let cellNib = UINib(nibName: "TeamsTableViewCell", bundle: Bundle.main)

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

    contentView.layer.borderWidth = 5
    contentView.layer.borderColor = UIColor.black.cgColor
    contentView.layer.cornerRadius = 0
}

}

