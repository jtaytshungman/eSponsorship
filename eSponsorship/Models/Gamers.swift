//
//  Gamers.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 08/10/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import Foundation

class Gamers {
    
    var userName : String?
    //var userProfileImageURL : String?
    var userLocationBased : String?
    var userDescription : String?
    
    var userTwitchURL : String?
    var userYoutubeURL : String?
    var userFacebookURL : String?
    var userOtherURL : String?
    
    var userGameChoice1 : String?
    var userGameChoice1Level : String?
    var userGameChoice2 : String?
    var userGameChoice2Level : String?
    var userGameChoice3 : String?
    var userGameChoice3Level : String?
    
    init() {
        
    }
    
    init (userNameInput : String,
          userLocationBasedInput : String,
          userDescriptionInput : String,
          userTwitchURLInput : String,
          userYoutubeURLInput : String,
          userFacebookURLInput : String,
          userOtherURLInput : String,
          userGameChoice1Input : String,
          userGameChoice1LevelInput : String,
          userGameChoice2Input : String,
          userGameChoice2LevelInput : String,
          userGameChoice3Input : String,
          userGameChoice3LevelInput : String) {
        
        self.userName = userNameInput
        //self.userProfileImageURL = userProfileImageURLInput
        self.userLocationBased = userLocationBasedInput
        self.userDescription = userDescriptionInput
        self.userTwitchURL = userTwitchURLInput
        self.userYoutubeURL = userYoutubeURLInput
        self.userFacebookURL = userFacebookURLInput
        self.userOtherURL = userOtherURLInput
        self.userGameChoice1 = userGameChoice1Input
        self.userGameChoice1Level = userGameChoice1LevelInput
        self.userGameChoice2 = userGameChoice2Input
        self.userGameChoice2Level = userGameChoice2LevelInput
        self.userGameChoice3 = userGameChoice3Input
        self.userGameChoice3Level = userGameChoice3LevelInput
        
        
    }
}
