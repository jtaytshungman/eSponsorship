//
//  DetailedTournamentsViewController.swift
//  eSponsorship
//
//  Created by Hoang Thu Ha on 6/10/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class DetailedTournamentsViewController: UIViewController {
    
    var selectedTournamentProfile : Tournaments?
    
    @IBOutlet weak var controller: UISegmentedControl!
    
    @IBOutlet weak var orgView: UIView!
    @IBOutlet weak var tournamentView: UIView!
    @IBOutlet weak var locationView: UIView!
    
    @IBOutlet weak var orgNameTxt: UITextField!
    @IBOutlet weak var orgEmailTxt: UITextField!
    @IBOutlet weak var orgAffTxt: UITextField!
    @IBOutlet weak var orgContactTxt: UITextField!
    @IBOutlet weak var tourImage: UIImageView!
    @IBOutlet weak var tourNameTxt: UITextField!
    @IBOutlet weak var tourGameTxt: UITextField!
    @IBOutlet weak var tourLevelTxt: UITextField!
    @IBOutlet weak var tourParticipantsTxt: UITextField!
    @IBOutlet weak var tourPrizeTxt: UITextField!
    @IBOutlet weak var tourURLTxt: UITextField!
    @IBOutlet weak var tourStartTimeTxt: UITextField!
    @IBOutlet weak var tourEndTimeTxt: UITextField!
    @IBOutlet weak var tourLocNameTxt: UITextField!
    @IBOutlet weak var tourLocUnitTxt: UITextField!
    @IBOutlet weak var tourLocStreetTxt: UITextField!
    @IBOutlet weak var tourLocCityTxt: UITextField!
    @IBOutlet weak var tourLocStateTxt: UITextField!
    @IBOutlet weak var tourLocCountryTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControllerHandler()
        orgView.layer.cornerRadius = 20
        tournamentView.layer.cornerRadius = 20
        locationView.layer.cornerRadius = 20
        
        guard let orgName = selectedTournamentProfile?.orgName,
            let orgEmail = selectedTournamentProfile?.orgEmail,
            let orgAff = selectedTournamentProfile?.orgAff,
            let orgContact = selectedTournamentProfile?.orgContact,
            
            //let tourImage = selectedTournamentProfile?.tourImageURL,
            
            let tourName = selectedTournamentProfile?.tourName,
            let tourGame = selectedTournamentProfile?.tourGame,
            let tourLevel = selectedTournamentProfile?.tourLevel,
            let tourParticipants = selectedTournamentProfile?.tourParticipants,
            let tourPrize = selectedTournamentProfile?.tourPrize,
            let tourURL = selectedTournamentProfile?.tourURL,
            let tourStartTime = selectedTournamentProfile?.tourStartTime,
            let tourEndTime = selectedTournamentProfile?.tourEndTime,
            
            let tourLocName = selectedTournamentProfile?.tourLocName,
            let tourLocUnit = selectedTournamentProfile?.tourLocUnit,
            let tourLocStreet = selectedTournamentProfile?.tourLocStreet,
            let tourLocCity = selectedTournamentProfile?.tourLocCity,
            let tourLocState = selectedTournamentProfile?.tourLocState,
            let tourLocCountry = selectedTournamentProfile?.tourLocCountry
            else { return }
        
        orgNameTxt.text =  orgName
        orgEmailTxt.text = orgEmail
        orgAffTxt.text = orgAff
        orgContactTxt.text = orgContact
        //tourImage.image
        tourNameTxt.text = tourName
        tourGameTxt.text = tourGame
        tourLevelTxt.text = tourLevel
        tourParticipantsTxt.text = tourParticipants
        tourPrizeTxt.text = tourPrize
        tourURLTxt.text = tourURL
        tourStartTimeTxt.text = converter.convertToDate(tourStartTime)
        tourEndTimeTxt.text = converter.convertToDate(tourEndTime)
        tourLocNameTxt.text = tourLocName
        tourLocUnitTxt.text = tourLocUnit
        tourLocStreetTxt.text = tourLocStreet
        tourLocCityTxt.text = tourLocCity
        tourLocStateTxt.text = tourLocState
        tourLocCountryTxt.text = tourLocCountry
        
    }
    
    @IBAction func segmentedController(_ sender: Any) {
        segmentedControllerHandler()
        
    }
    
    func segmentedControllerHandler () {
        if controller.selectedSegmentIndex == 0{
            orgView.isHidden = false
            tournamentView.isHidden = true
            locationView.isHidden = true
        }
        
        if controller.selectedSegmentIndex == 1{
            orgView.isHidden = true
            tournamentView.isHidden = false
            locationView.isHidden = true
        }
        
        if controller.selectedSegmentIndex == 2{
            orgView.isHidden = true
            tournamentView.isHidden = true
            locationView.isHidden = false
        }
        
    }
    
}
