//
//  HomeViewController.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 27/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBAction func gamersButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func teamsButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func tournamentsButtonTapped(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
    }
}

extension HomeViewController {
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.20
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.20
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
}


