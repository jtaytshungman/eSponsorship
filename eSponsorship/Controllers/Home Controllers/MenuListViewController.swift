//
//  MenuListViewController.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 29/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class MenuListViewController: UIViewController {
    
    @IBOutlet weak var viewProfileIcon: UIImageView!
    @IBOutlet weak var editProfileIcon: UIImageView!
    @IBOutlet weak var addTeamIcon: UIImageView!
    @IBOutlet weak var addTournamentIcon: UIImageView!
    @IBOutlet weak var aboutIcon: UIImageView!
    @IBOutlet weak var sponsorIcon: UIImageView!
    
    @IBOutlet weak var sideMenuProfileImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageDisplay.ProfileBounds(image: viewProfileIcon)
        ImageDisplay.ProfileBounds(image: editProfileIcon)
        ImageDisplay.ProfileBounds(image: addTeamIcon)
        ImageDisplay.ProfileBounds(image: addTournamentIcon)
        ImageDisplay.ProfileBounds(image: aboutIcon)
        ImageDisplay.ProfileBounds(image: sponsorIcon)
        ImageDisplay.ProfileBounds(image: sideMenuProfileImage)
        
        viewProfileIcon.image = UIImage(named: "icon_profile")
        viewProfileIcon.contentMode = .scaleAspectFit
        
    }
    
    @IBAction func viewProfileButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func editProfileButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func addTeams(_ sender: Any) {
        let eurekaStoryBoard = UIStoryboard(name: "AddEureka", bundle: nil)
        guard let vc = eurekaStoryBoard.instantiateViewController(withIdentifier: "TeamsFormViewController") as? TeamsFormViewController else { return }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func addTournaments(_ sender: Any) {
        let eurekaStoryboard = UIStoryboard(name: "AddEureka", bundle: Bundle.main)
        guard let vc = eurekaStoryboard.instantiateViewController(withIdentifier: "TournamentFormViewController") as? TournamentFormViewController else { return }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func aboutButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func sponsorsButtonTapped(_ sender: Any) {
        
    }
    
 }
