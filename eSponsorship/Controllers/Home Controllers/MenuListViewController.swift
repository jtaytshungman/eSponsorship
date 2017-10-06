//
//  MenuListViewController.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 29/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class MenuListViewController: UIViewController {
    
    @IBOutlet weak var sideMenuProfileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
