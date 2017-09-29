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


class HomeViewController: UIViewController {
    
    @IBAction func signOut(_ sender: Any) {
        confirmSignOutHandler()
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
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        guard let sideMenuNC = SideMenuManager.menuLeftNavigationController else {
            return
        }
        present(sideMenuNC, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuHandler()
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
    
    func confirmSignOutHandler () {
        let alert = UIAlertController(title: "Confirm Sign Out", message: "You are signing out from the application", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Sign Out", style: .default) { (action) in
            self.signOutHandler()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        present(alert,animated: true,completion: nil)
    }
    
    func signOutHandler(){
        let mainStoryboard = UIStoryboard(name: "Auth", bundle: nil)
        guard let targetVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        dismiss(animated: true, completion: nil)
        self.present(targetVC, animated: true, completion: nil)
    }
    
    func sideMenuHandler () {
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: SideMenuTableViewController())
        
        menuLeftNavigationController.leftSide = true
        
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        
        let menuRightNavigationController = UISideMenuNavigationController(rootViewController: SideMenuTableViewController())
        
        SideMenuManager.menuRightNavigationController = menuRightNavigationController

        guard let navigation = UIViewController().navigationController?.navigationBar else {
            return print("Error in Navigation in Side Menu")
        }
        
        SideMenuManager.menuAddPanGestureToPresent(toView: navigation)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: navigation)
        
    }
}


