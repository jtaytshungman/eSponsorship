//
//  Post.swift
//  eSponsorship
//
//  Created by Salem Abdulla on 9/27/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import Foundation
class TourPosting {
    
//    var userid : String = ""
    var imageurl : String = ""
    var tournamentName : String = ""
    var location : String = ""
    var dateName : String = ""
    var gameName : String = ""
    var prizeName : String = ""
    
    init() {}
    
    init(theTournamentName: String, theLocation: String, imageName : String, theDate : String, theGame: String, prize: String) {
        
//        userid = anID
        imageurl = imageName
        tournamentName = theTournamentName
        location = theLocation
        dateName = theDate
        gameName = theGame
        prizeName = prize
    }
}
