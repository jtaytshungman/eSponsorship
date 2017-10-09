//
//  TournamentsViewController.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 27/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class TournamentsViewController: UIViewController {
    
    
    var posts: [TourPosting] = []
    var tournaments : [Tournaments] = []
    
    
    var databaseRef: DatabaseReference!
    var storageRef: StorageReference!
    
    //    let tournamentName = "Monash Dota Competition"
    //    let organizerName = "Monash University"
    //    let participation = "12 Teams"
    //    let location = "Cyberjaya Launchpad"
    
    @IBOutlet weak var tournamentsTableView: UITableView!{
        didSet{
            tournamentsTableView.register(TournamentTableViewCell.cellNib, forCellReuseIdentifier: TournamentTableViewCell.cellIdentifier)
            tournamentsTableView.delegate = self
            tournamentsTableView.dataSource = self
            tournamentsTableView.estimatedRowHeight = 80
            tournamentsTableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tournaments"
        
        fetchpost()
        
    }
    
    
    func fetchpost(){
        
        databaseRef = Database.database().reference()
        
        databaseRef.child("GameShip_Tournaments").observe(.childAdded, with: { (snapshot) in
            
            guard let mypost = snapshot.value as? [String: Any]
                else {return}
            
            
            
            if let orgName = mypost["org_name"] as? String,
                let orgEmail = mypost["org_email"] as? String,
                let orgAff = mypost["org_aff"] as? String,
                let orgContact = mypost["org_contact"] as? String,
                
                //let tourImageURL = mypost["image_url"] as? String,
                let tourName = mypost["tournament_name"] as? String,
                let tourGame = mypost["competing_game"] as? String,
                let tourLevel = mypost["competitive_level"] as? String,
                let tourParticipants = mypost["number_participants"] as? String,
                let tourPrize = mypost["prize_pool"] as? String,
                let tourURL = mypost["tournament_url"] as? String,
                //let tourStartTime = mypost["start_time"] as? String,
                //let tourEndTime = mypost["end_time"] as? String,
                
                let tourLocName = mypost["location_name"] as? String,
                let tourLocUnit = mypost["location_unit"] as? String,
                let tourLocStreet = mypost["location_street"] as? String,
                let tourLocCity = mypost["location_city"] as? String,
                let tourLocState = mypost["location_state"] as? String,
                let tourLocCountry = mypost["location_country"] as? String
                
                
            {
                
                
                //            let newPost = mypost(imageName: post)
                
                
                DispatchQueue.main.async {
                    //                    let newTournament = Tournaments(orgNameInput: orgName, orgEmailInput: orgEmail, orgAffInput: orgAff, orgContactInput: orgContact,tourImageURLInput: tourImageURL, tourNameInput: tourName, tourGameInput: tourGame, tourLevelInput: tourLevel, tourParticipantsInput: tourParticipants, tourPrizeInput: tourPrize, tourURLInput: tourURL, tourLocNameInput: tourLocName, tourLocUnitInput: tourLocUnit, tourLocStreetInput: tourLocStreet, tourLocCityInput: tourLocCity, tourLocStateInput: tourLocState, tourLocCountryInput: tourLocCountry)
                    
//                    let newTournament = Tournaments(userID_subInput : userID_sub, orgNameInput: orgName, orgEmailInput: orgEmail, orgAffInput: orgAff, orgContactInput: orgContact, tourNameInput: tourName, tourGameInput: tourGame, tourLevelInput: tourLevel, tourParticipantsInput: tourParticipants, tourPrizeInput: tourPrize, tourURLInput: tourURL, tourLocNameInput: tourLocName, tourLocUnitInput: tourLocUnit, tourLocStreetInput: tourLocStreet, tourLocCityInput: tourLocCity, tourLocStateInput: tourLocState, tourLocCountryInput: tourLocCountry)

                    
//                    self.tournaments.append()
                    self.tournamentsTableView.reloadData()
                }
                
            }
            
        })
        
    }
    
}


extension TournamentsViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tournaments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tournamentsTableView.dequeueReusableCell(withIdentifier: TournamentTableViewCell.cellIdentifier) as? TournamentTableViewCell else {
            return UITableViewCell()
        }
        let tournament = tournaments[indexPath.row]
        
        //        cell.tournamentName.text = tournamentName
        //        cell.locationOfTournament.text = location
        //        cell.organizerName.text = organizerName
        //        cell.numberOfParticipants.text = participation
        
        cell.tournamentName.text = tournament.tourName
        cell.locationOfTournament.text = tournament.tourLocName
        cell.organizerName.text = tournament.tourGame
        cell.numberOfParticipants.text = tournament.tourParticipants
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "DetailedTournamentsViewController") as? DetailedTournamentsViewController else {return}
        
        let selectedTourmanent = tournaments[indexPath.row]
        
        destination.selectedTournamentProfile = selectedTourmanent
        navigationController?.pushViewController(destination, animated: true)
    }
    
    
    
    
    
    
}


