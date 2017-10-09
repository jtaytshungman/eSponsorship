//
//  Tournaments.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 06/10/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import Foundation

class Tournaments {
    var userID_sub : String?
    var orgName : String?
    var orgEmail : String?
    var orgAff : String?
    var orgContact : String?
    
    //var tourImageURL : String?
    var tourName : String?
    var tourGame : String?
    var tourLevel : String?
    var tourParticipants : String?
    var tourPrize : String?
    var tourURL : String?
//    var tourStartTime : String?
//    var tourEndTime : String?
    
    var tourLocName : String?
    var tourLocUnit : String?
    var tourLocStreet : String?
    var tourLocCity : String?
    var tourLocState : String?
    var tourLocCountry : String?

    init() {}
    
    init(
        userID_sub_Input : String,
        orgNameInput : String,
        orgEmailInput : String,
        orgAffInput : String ,
        orgContactInput : String,
        //tourImageURLInput : String,
        tourNameInput : String,
        tourGameInput : String,
        tourLevelInput : String,
        tourParticipantsInput : String,
        tourPrizeInput : String,
        tourURLInput : String,
//        tourStartTimeInput : String,
//        tourEndTimeInput : String,

        tourLocNameInput : String,
        tourLocUnitInput : String,
        tourLocStreetInput : String,
        tourLocCityInput : String,
        tourLocStateInput : String,
        tourLocCountryInput : String) {
        
        self.userID_sub = userID_sub_Input
        self.orgName = orgNameInput
        self.orgEmail = orgEmailInput
        self.orgAff = orgAffInput
        self.orgContact = orgContactInput
        
        //self.tourImageURL = tourImageURLInput
        
        self.tourName = tourNameInput
        self.tourGame = tourGameInput
        self.tourLevel = tourLevelInput
        self.tourParticipants = tourParticipantsInput
        self.tourPrize = tourPrizeInput
        self.tourURL = tourURLInput
//        tourStartTime = tourStartTimeInput
//        tourEndTime = tourEndTimeInput
        
        self.tourLocName = tourLocNameInput
        self.tourLocUnit = tourLocUnitInput
        self.tourLocStreet = tourLocStreetInput
        self.tourLocCity = tourLocCityInput
        self.tourLocState = tourLocStateInput
        self.tourLocCountry = tourLocCountryInput
    }
}
