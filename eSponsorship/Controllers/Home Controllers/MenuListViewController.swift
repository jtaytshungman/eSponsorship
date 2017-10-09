//
//  MenuListViewController.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 29/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import FirebaseAuth

class MenuListViewController: UIViewController {
    
    @IBOutlet weak var viewProfileIcon: UIImageView!
    @IBOutlet weak var editProfileIcon: UIImageView!
//    @IBOutlet weak var addTeamIcon: UIImageView!
    @IBOutlet weak var addTournamentIcon: UIImageView!
    @IBOutlet weak var aboutIcon: UIImageView!
   
    @IBOutlet weak var sideMenuProfileImage: UIImageView!
    
    @IBOutlet weak var viewMyTournamentsImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageDisplay.ProfileBounds(image: viewProfileIcon)
        ImageDisplay.ProfileBounds(image: editProfileIcon)
//        ImageDisplay.ProfileBounds(image: addTeamIcon)
        ImageDisplay.ProfileBounds(image: addTournamentIcon)
        ImageDisplay.ProfileBounds(image: aboutIcon)
        ImageDisplay.ProfileBounds(image: sideMenuProfileImage)
        
    }
    
    @IBAction func viewProfileButtonTapped(_ sender: Any) {
        let storyboardNew = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = storyboardNew.instantiateViewController(withIdentifier: "UserProfileViewController") as? UserProfileViewController else {
            return
        }
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func editProfileButtonTapped(_ sender: Any) {
        let eurekaStoryBoard = UIStoryboard(name: "AddEureka", bundle: nil)
        guard let vc = eurekaStoryBoard.instantiateViewController(withIdentifier: "ProfileFormNavigation") as? UINavigationController else { return }
        present(vc, animated: true, completion: nil)
    }
    
//    @IBAction func addTeams(_ sender: Any) {
//        let eurekaStoryBoard = UIStoryboard(name: "AddEureka", bundle: nil)
//        guard let vc = eurekaStoryBoard.instantiateViewController(withIdentifier: "TeamsFormNavigation") as? UINavigationController else { return }
//        present(vc, animated: true, completion: nil)
//    }
    
    @IBAction func addTournaments(_ sender: Any) {
        let eurekaStoryboard = UIStoryboard(name: "AddEureka", bundle: Bundle.main)
        guard let vc = eurekaStoryboard.instantiateViewController(withIdentifier: "TournamentsFormNavigation") as? UINavigationController else { return }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func aboutButtonTapped(_ sender: Any) {
        let staticStoryBoard = UIStoryboard(name: "StaticVCs", bundle: nil)
        guard let vc = staticStoryBoard.instantiateViewController(withIdentifier: "AboutNavigation") as? UINavigationController else { return }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func sponsorsButtonTapped(_ sender: Any) {
        
    }
    
    
    @IBAction func Profile(_ sender: Any) {
        let storyboardNew = UIStoryboard(name: "Adding", bundle: nil)
        guard let vc = storyboardNew.instantiateViewController(withIdentifier: "profileViewController") as? profileViewController else {
            return
        }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func viewMyTournaments(_ sender: Any) {
        let storyboardNew = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = storyboardNew.instantiateViewController(withIdentifier: "ViewMyTournamentViewController") as? ViewMyTournamentViewController else {
            return
        }
        present(vc, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }

        let signInSB = UIStoryboard(name: "Auth", bundle: nil)
        guard let vc = signInSB.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        present(vc, animated: true, completion: nil)
        
    }
    
}


