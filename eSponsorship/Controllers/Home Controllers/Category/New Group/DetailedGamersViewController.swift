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
    
    @IBOutlet weak var gameChoice1Txt: UITextField!
    
    @IBOutlet weak var gameChoice1LevelTxt: UITextField!
    
    @IBOutlet weak var gameChoice2Txt: UITextField!
    
    @IBOutlet weak var gameChoice2LevelTxt: UITextField!
    
    @IBOutlet weak var gameChoice3Txt: UITextField!
    
    @IBOutlet weak var gameChoice3LevelTxt: UITextField!
    
    @IBOutlet weak var descriptionTxt: UITextField!
    
    @IBOutlet weak var fbURLTxt: UITextField!
    
    @IBOutlet weak var locationTxt: UITextField!
    
    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var otherURLTxt: UITextField!
    
    @IBOutlet weak var twitchURLTxt: UITextField!
    
    @IBOutlet weak var youtubeURLTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let gameChoice1 = selectedGamerProfile?.userGameChoice1,
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
        //profileImage.loadImage(from: imageView)
        gameChoice1Txt.text = gameChoice1
        gameChoice1LevelTxt.text = gameChoice1Level
        gameChoice2Txt.text = gameChoice2
        gameChoice2LevelTxt.text = gameChoice2Level
        gameChoice3Txt.text = gameChoice3
        gameChoice3LevelTxt.text = gameChoice3Level
        descriptionTxt.text = description
        fbURLTxt.text = facebookURL
        locationTxt.text = location
        usernameTxt.text = username
        otherURLTxt.text = otherURL
        twitchURLTxt.text = twitchURL
        youtubeURLTxt.text = youtubeURL
        
        
        
        
    }
    
}













