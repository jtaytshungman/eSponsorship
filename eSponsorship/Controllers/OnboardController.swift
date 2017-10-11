//
//  OnboardController.swift
//  
//
//  Created by Jeremy Tay on 26/09/2017.
//

import UIKit
import Onboard

class OnboardController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateStandardOnboardingVC()
    }
    
    func onboardingCompletionHandler() {
        
        let authStoryboard = UIStoryboard(name: "Auth", bundle: nil)
        guard let targetVC = authStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        
        self.dismiss(animated: true, completion: nil)
        present(targetVC, animated: true)
    }
    
    func generateStandardOnboardingVC() {
        
        let firstPage = OnboardingContentViewController.content(
            withTitle: "For Gamers",
            body: "You don't have to be the best to get sponsored, sponsors are looking for all types of gamers, at all levels.",
            image: UIImage(named: "icon_console_orange"),
            buttonText: "", action: {() -> Void in

        })
        
        firstPage.movesToNextViewController = true
        
//        let secondPage = OnboardingContentViewController.content(
//            withTitle: "For Teams",
//            body: "You don't have to be the best team to get sponsored, sponsors are looking for all types of teams, at all levels.",
//            image: UIImage(named: "icon_team_orange"),
//            buttonText: "", action: {() -> Void in
//
//        })
//
//        secondPage.movesToNextViewController = true
        
        let thirdPage = OnboardingContentViewController.content(
            withTitle: "For Tournaments",
            body: "Looking to grow your tournaments prize money and attract the best teams in the region to play in your tournament? Use attractive sponsors to contribute to your prize money.",
            image: UIImage(named: "icon_team_orange"),
            buttonText: "", action: {() -> Void in
                
        })
        
        let fourthPage = OnboardingContentViewController.content(
            withTitle: "For Sponsors",
            body: "Sponsorship of gaming influencers is one of the most effective means of brand building that you can participate in today.",
            image: UIImage(named: "icon_sponsor_orange"),
            buttonText: "Get Started", action: {() -> Void in
                self.onboardingCompletionHandler()
        })
        
        guard let onboardingVC = OnboardingViewController(backgroundImage: UIImage(named: "ob4"), contents: [firstPage, thirdPage, fourthPage]) else { return }
        
        onboardingVC.shouldFadeTransitions = true
        onboardingVC.fadePageControlOnLastPage = true
        onboardingVC.fadeSkipButtonOnLastPage = true
        
        // Customization
        onboardingVC.allowSkipping = true
        onboardingVC.skipHandler = {() -> Void in
            self.onboardingCompletionHandler()
            
        }
        
        present(onboardingVC, animated: true, completion: nil)
        
    }
    
}
