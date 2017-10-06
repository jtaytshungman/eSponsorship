//
//  DetailedTournamentsViewController.swift
//  eSponsorship
//
//  Created by Hoang Thu Ha on 6/10/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class DetailedTournamentsViewController: UIViewController {

    var selectedTournamentProfile : Post?
    
    @IBOutlet weak var gameTourmanent: UITextField!
    
    @IBOutlet weak var profileTourmanent: UIImageView!
    
    @IBOutlet weak var locationTourmanent: UITextField!
    
    @IBOutlet weak var nameTourmanent: UITextField!
    
    @IBOutlet weak var dateTourmanent: UITextField!
    
    @IBOutlet weak var prizeTourmanent: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let game = selectedTournamentProfile?.gameName,
            let image = selectedTournamentProfile?.imageurl,
            let location = selectedTournamentProfile?.location,
            let name = selectedTournamentProfile?.tournamentName,
            let date = selectedTournamentProfile?.dateName,
            let prize = selectedTournamentProfile?.prizeName
            else { return}
        gameTourmanent.text = game
        //        profileImage. = UIImage
        locationTourmanent.text = location
        nameTourmanent.text = name
        dateTourmanent.text = date
        prizeTourmanent.text = prize
        
        
        
        
    }
    
}
