//
//  viewMyTour.swift
//  eSponsorship
//
//  Created by Salem Abdulla on 10/8/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import Foundation
class viewMyTour {
    
    var tournament_name: String = ""
    var  competing_game: String = ""
    
    init() { }
    
    init(theTournament_name :String, theCompeting_game: String) {
        tournament_name = theTournament_name
        competing_game = theCompeting_game
    }
}


