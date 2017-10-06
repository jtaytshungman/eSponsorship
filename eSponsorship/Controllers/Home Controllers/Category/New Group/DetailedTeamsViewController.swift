//
//  DetailedTeamsViewController.swift
//  eSponsorship
//
//  Created by Hoang Thu Ha on 6/10/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class DetailedTeamsViewController: UIViewController {
    
    var selectedTeamProfile : TeamPosting?
    
    @IBOutlet weak var gameTeamTextField: UITextField!
    
    @IBOutlet weak var profileTeamImage: UIImageView!
    
    @IBOutlet weak var locationTeamTextField: UITextField!
    
    @IBOutlet weak var nameTeamTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let game = selectedTeamProfile?.gameName,
            let image = selectedTeamProfile?.imageurl,
            let location = selectedTeamProfile?.location,
            let name = selectedTeamProfile?.tournamentName
            else { return}
        gameTeamTextField.text = game
        //        profileImage. = UIImage
        locationTeamTextField.text = location
        nameTeamTextField.text = name
        
        
    }
    
}
