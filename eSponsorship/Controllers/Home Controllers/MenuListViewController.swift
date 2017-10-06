//
//  MenuListViewController.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 29/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class MenuListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTeams(_ sender: Any) {
     
        let storyboardNew = UIStoryboard(name: "EurekaAdd", bundle: nil)
        guard let vc = storyboardNew.instantiateViewController(withIdentifier: "EurekaAddTournamentsViewController") as? EurekaAddTournamentsViewController else {
            return
        }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func addTournaments(_ sender: Any) {
        
        let storyboardNew = UIStoryboard(name: "Adding", bundle: nil)
        
        guard let vc = storyboardNew.instantiateViewController(withIdentifier: "addTourViewController") as? addTourViewController else {
            return
        }
        
        present(vc, animated: true, completion: nil)
        
    }
    
     @IBAction func addGamers(_ sender: Any) {
     let storyboardNew = UIStoryboard(name: "Adding", bundle: nil)
     guard let vc = storyboardNew.instantiateViewController(withIdentifier: "profileViewController") as? profileViewController else {
     return
     }
     present(vc, animated: true, completion: nil)
     
     }
}

