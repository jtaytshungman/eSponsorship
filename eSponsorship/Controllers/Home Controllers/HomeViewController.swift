//
//  HomeViewController.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 27/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import Firebase
import SideMenu

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
        self.title = "Game Ship"
        
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
    /*
    func pageMenuHandler(){
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
        
        // Create variables for all view controllers you want to put in the
        // page menu, initialize them, and add each to the controller array.
        // (Can be any UIViewController subclass)
        // Make sure the title property of all view controllers is set
        var gamersFeed : UIViewController = UIViewController(nibName: "GamersViewController", bundle: Bundle.main)
        gamersFeed.title = "Gamers"
        controllerArray.append(gamersFeed)
        
        var tournamentsFeed : UIViewController = UIViewController(nibName: "TournamentsViewController", bundle: Bundle.main)
        tournamentsFeed.title = "Tournament"
        controllerArray.append(tournamentsFeed)
        
        var teamsFeed : UIViewController = UIViewController(nibName: "TeamsViewController", bundle: Bundle.main)
        teamsFeed.title = "Teams"
        controllerArray.append(teamsFeed)
        
        // Customize page menu to your liking (optional) or use default settings by sending nil for 'options' in the init
        // Example:
        var parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.1)
        ]
        
        // Initialize page menu with controller array, frame, and optional parameters
       // pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect (0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        let cgrectfigures = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: cgrectfigures , pageMenuOptions: parameters)
        
        
        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        self.view.addSubview(pageMenu!.view)
    }
 */
}

