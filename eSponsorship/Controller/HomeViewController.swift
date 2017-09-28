//
//  HomeViewController.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 27/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import SideMenu
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController {
    
    @IBAction func signOut(_ sender: Any) {
        signOutHandler()
    }
    
    // MARK: Category Selected
    @IBAction func gamersButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func teamsButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tournamentsButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        sideMenuHandler()
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
    
    func signOutHandler(){
        let mainStoryboard = UIStoryboard(name: "Auth", bundle: Bundle.main)
        guard let targetVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        dismiss(animated: true, completion: nil)
        self.present(targetVC, animated: true, completion: nil)
    }
    
    func sideMenuHandler(){
        // Define the menus
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: HomeViewController())
        menuLeftNavigationController.leftSide = true
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        
        let menuRightNavigationController = UISideMenuNavigationController(rootViewController: HomeViewController())
        SideMenuManager.menuRightNavigationController = menuRightNavigationController
        
        guard let navigation = UIViewController().navigationController?.navigationBar else {
            return
        }
        SideMenuManager.menuAddPanGestureToPresent(toView: navigation)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: navigation)
        
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
        
        dismiss(animated: true, completion: nil)
    }
    
}


