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
    }
    
    @IBAction func teamsButtonTapped(_ sender: Any) {
    }
    
    @IBAction func tournamentsButtonTapped(_ sender: Any) {
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        print("Menu Button Tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuHandler()
        self.title = "Home"
        
    }
}

extension HomeViewController {
    
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
        // Define the menus
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: MenuListViewController())
        menuLeftNavigationController.leftSide = true
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
    }
    
}

