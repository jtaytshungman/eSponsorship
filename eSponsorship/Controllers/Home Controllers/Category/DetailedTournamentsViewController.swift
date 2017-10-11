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
    
    @IBOutlet weak var tournamentNameLabel: UILabel!
    @IBOutlet weak var tournamentGameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationUnit: UILabel!
    @IBOutlet weak var locationStreet: UILabel!
    @IBOutlet weak var locationCity: UILabel!
    @IBOutlet weak var locationState: UILabel!
    @IBOutlet weak var locationCountry: UILabel!
    
    @IBOutlet weak var orgNameLabel: UILabel!
    @IBOutlet weak var orgAffLabel: UILabel!
    @IBOutlet weak var orgEmailLabel: UILabel!
    @IBOutlet weak var orgContactLabel: UILabel!
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var participantLabel: UILabel!
    @IBOutlet weak var prizePoolLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    @IBOutlet weak var controller: UISegmentedControl!
    
    @IBOutlet weak var orgView: UIView!
    @IBOutlet weak var tournamentView: UIView!
    @IBOutlet weak var locationView: UIView!
    
    
    
    @IBOutlet weak var tourImage: UIImageView!
    
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
            
            let tourImageURL = selectedTournamentProfile?.tourImageURL,
            
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
        
        
        tourImage.loadImage(from: tourImageURL)
        
        tournamentNameLabel.text = tourName
        tournamentGameLabel.text = tourGame
        startTimeLabel.text = converter.convertToDate(tourStartTime)
        endTimeLabel.text = converter.convertToDate(tourEndTime)
        
        locationName.text = tourLocName
        locationUnit.text = tourLocUnit
        locationCity.text = tourLocCity
        locationStreet.text = tourLocStreet
        locationState.text = tourLocState
        locationCountry.text = tourLocCountry
        
        orgNameLabel.text = orgName
        orgEmailLabel.text = orgEmail
        orgAffLabel.text = orgAff
        orgContactLabel.text = orgContact
        
        levelLabel.text = tourLevel
        participantLabel.text = tourParticipants
        prizePoolLabel.text = tourPrize
        urlLabel.text = tourURL
        
        
        
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
