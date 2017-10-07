//
//  GamersPost.swift
//  eSponsorship
//
//  Created by Salem Abdulla on 9/29/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//
import Foundation

class GamerPosting {
    var userid : String = ""
    
    var imageurl : String = ""
    
    var tournamentName : String = ""
    
    var location : String = ""
    
    var gameName : String = ""
    
    var dob : String = ""
    
    var desc : String = ""
    
    var level : String = ""
    
    
    init() {}
    
    init(anID: String,theTournamentName: String, theLocation: String, imageName : String, theGame: String, dateOfBirth : String, descriptionText : String, levelcomp : String) {
        
        
        userid = anID
        imageurl = imageName
        tournamentName = theTournamentName
        location = theLocation
        gameName = theGame
        dob = dateOfBirth
        desc = descriptionText
        level = levelcomp
     
        
    }
}
