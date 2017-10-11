//
//  DetailedGamersViewController.swift
//  eSponsorship
//
//  Created by Hoang Thu Ha on 6/10/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class DetailedGamersViewController: UIViewController {
    
    var selectedGamerProfile : Gamers?
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var gameChoice1Txt: UILabel!
    
    @IBOutlet weak var gameChoice1LevelTxt: UILabel!
    
    @IBOutlet weak var gameChoice2Txt: UILabel!
    
    @IBOutlet weak var gameChoice2LevelTxt: UILabel!
    
    @IBOutlet weak var gameChoice3Txt: UILabel!
    
    @IBOutlet weak var gameChoice3LevelTxt: UILabel!
    
    @IBOutlet weak var descriptionTxt: UITextView!
    
    @IBOutlet weak var fbURLTxt: UITextField!
    
    @IBOutlet weak var otherURLTxt: UITextField!
    
    @IBOutlet weak var twitchURLTxt: UITextField!
    
    @IBOutlet weak var youtubeURLTxt: UITextField!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userLocationLabel: UILabel!
    
    @IBOutlet weak var viewTopGame: UIView!
    @IBOutlet weak var viewContact: UIView!
    @IBOutlet weak var viewUser: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
//        viewUser.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
//        CornerRadius.CornerRadiusView(view : viewUser)
        
//        viewContact.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
//        CornerRadius.CornerRadiusView(view : viewContact)
        
//        viewTopGame.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
//        CornerRadius.CornerRadiusView(view : viewTopGame)
        
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        
        guard let profileImg = selectedGamerProfile?.userProfileImageURL,
            let gameChoice1 = selectedGamerProfile?.userGameChoice1,
            let gameChoice1Level = selectedGamerProfile?.userGameChoice1Level,
            let gameChoice2 = selectedGamerProfile?.userGameChoice2,
            let gameChoice2Level = selectedGamerProfile?.userGameChoice2Level,
            let gameChoice3 = selectedGamerProfile?.userGameChoice3,
            let gameChoice3Level = selectedGamerProfile?.userGameChoice3Level,
            let description = selectedGamerProfile?.userDescription,
            let facebookURL = selectedGamerProfile?.userFacebookURL,
            let location = selectedGamerProfile?.userLocationBased,
            let username = selectedGamerProfile?.userName,
            let otherURL = selectedGamerProfile?.userOtherURL,
            let twitchURL = selectedGamerProfile?.userTwitchURL,
            let youtubeURL = selectedGamerProfile?.userYoutubeURL
            
            else { return}
        profileImage.loadImage(from: profileImg)
        gameChoice1Txt.text = gameChoice1
        gameChoice1LevelTxt.text = gameChoice1Level
        gameChoice2Txt.text = gameChoice2
        gameChoice2LevelTxt.text = gameChoice2Level
        gameChoice3Txt.text = gameChoice3
        gameChoice3LevelTxt.text = gameChoice3Level
        descriptionTxt.text = description
        fbURLTxt.text = facebookURL
        userLocationLabel.text = location
        userNameLabel.text = username
        otherURLTxt.text = otherURL
        twitchURLTxt.text = twitchURL
        youtubeURLTxt.text = youtubeURL
        
    }
    
}













