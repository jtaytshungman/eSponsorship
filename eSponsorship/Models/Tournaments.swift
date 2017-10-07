//
//  Tournaments.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 06/10/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import Foundation

class Tournaments {
    var orgName : String?
    var orgEmail : String?
    var orgAff : String?
    var orgContact : String?
    
    var tourImageURL : String?
    
    var tourName : String?
    var tourGame : String?
    var tourLevel : String?
    var tourParticipants : String?
    var tourPrize : String?
    var tourURL : String?
    var tourStartTime : Date?
    var tourEndTime : Date?
    
    var tourLocName : String?
    var tourLocUnit : String?
    var tourLocStreet : String?
    var tourLocCity : String?
    var tourLocState : String?
    var tourLocCountry : String?

    init() {
        
    }
    
    init(
        orgNameInput : String,
        orgEmailInput : String,
        orgAffInput : String ,
        orgContactInput : String,
        tourImageURLInput : String,
        tourNameInput : String,
        tourGameInput : String,
        tourLevelInput : String,
        tourParticipantsInput : String,
        tourPrizeInput : String,
        tourURLInput : String,
        tourStartTimeInput : Date,
        tourEndTimeInput : Date,
        tourLocNameInput : String,
        tourLocUnitInput : String,
        tourLocStreetInput : String,
        tourLocCityInput : String,
        tourLocStateInput : String,
        tourLocCountryInput : String) {
        
        orgName = orgNameInput
        orgEmail = orgEmailInput
        orgAff = orgAffInput
        orgContact = orgContactInput
        
        tourImageURL = tourImageURLInput
        
        tourName = tourNameInput
        tourGame = tourGameInput
        tourLevel = tourLevelInput
        tourParticipants = tourParticipantsInput
        tourPrize = tourPrizeInput
        tourURL = tourURLInput
        tourStartTime = tourStartTimeInput
        tourEndTime = tourEndTimeInput
        
        tourLocName = tourLocNameInput
        tourLocUnit = tourLocUnitInput
        tourLocStreet = tourLocStreetInput
        tourLocCity = tourLocCityInput
        tourLocState = tourLocStateInput
        tourLocCountry = tourLocCountryInput
    }
}
