//
//  GamersPost.swift
//  eSponsorship
//
//  Created by Salem Abdulla on 9/29/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//
import Foundation
class GamerPost {
    
    
    
    var userid : String = ""
    
    var imageurl : String = ""
    
    var tournamentName : String = ""
    
    var location : String = ""
    
    //    var dateName : String = ""
    
    var gameName : String = ""
    
    //    var prizeName : String = ""
    
    
    //        : UIImage = UIImage(named: "unknown") ?? UIImage()
    
    
    init() {}
    
    init(anID: String,theTournamentName: String, theLocation: String, imageName : String, theGame: String) {
        
        
        userid = anID
        imageurl = imageName
        tournamentName = theTournamentName
        location = theLocation
        //        dateName = theDate
        gameName = theGame
        //        prizeName = prize
        
        
        //        if let userImage = UIImage(named: imageName){
        //            self.imageurl = userImage
        //
        //        }else{
        //            self.imageurl = UIImage()
        //        }
        
    }
}
