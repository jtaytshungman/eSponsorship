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

protocol TitleDelegate {
    func changeTitle(to str : String)
}

class TournamentsViewController: UIViewController {

    var tournaments : [Tournaments] = []
    var delegate : TitleDelegate?
    var databaseRef: DatabaseReference!
    var storageRef: StorageReference!
    
    @IBOutlet weak var tournamentsTableView: UITableView!{
        didSet{
            tournamentsTableView.register(TournamentTableViewCell.cellNib, forCellReuseIdentifier: TournamentTableViewCell.cellIdentifier)
            tournamentsTableView.delegate = self
            tournamentsTableView.dataSource = self
            tournamentsTableView.estimatedRowHeight = 225
            tournamentsTableView.rowHeight = 225
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchpost()
        reloadTableWhenAddChild()
        self.tournamentsTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.changeTitle(to: "Tournaments")
    }
    

    func fetchpost(){
        
        databaseRef = Database.database().reference()
        databaseRef.child("GameShip_Tournaments").observe(.childAdded, with: { (snapshot) in
            
            guard let mypost = snapshot.value as? [String: Any]
                else {return}
            
            if
                let userId_sub = mypost["UserID_sub"] as? String,
                let orgName = mypost["org_name"] as? String,
                let orgEmail = mypost["org_email"] as? String,
                let orgAff = mypost["org_aff"] as? String,
                let orgContact = mypost["org_contact"] as? String,
                
                let tourImageURL = mypost["image_url"] as? String,
                let tourName = mypost["tournament_name"] as? String,
                let tourGame = mypost["competing_game"] as? String,
                let tourLevel = mypost["competitive_level"] as? String,
                let tourParticipants = mypost["number_participants"] as? String,
                let tourPrize = mypost["prize_pool"] as? String,
                let tourURL = mypost["tournament_url"] as? String,
                let tourStartTime = mypost["start_time"] as? Double,
                let tourEndTime = mypost["end_time"] as? Double,
                
                let tourLocName = mypost["location_name"] as? String,
                let tourLocUnit = mypost["location_unit"] as? String,
                let tourLocStreet = mypost["location_street"] as? String,
                let tourLocCity = mypost["location_city"] as? String,
                let tourLocState = mypost["location_state"] as? String,
                let tourLocCountry = mypost["location_country"] as? String
                
                
            {
                DispatchQueue.main.async {
                    let newTournament = Tournaments(
                                                    userID_sub_Input : userId_sub,
                                                    orgNameInput: orgName,
                                                    orgEmailInput: orgEmail,
                                                    orgAffInput: orgAff,
                                                    orgContactInput: orgContact,
                                                    tourImageURLInput : tourImageURL,
                                                    tourNameInput: tourName,
                                                    tourGameInput: tourGame,
                                                    tourLevelInput: tourLevel,
                                                    tourParticipantsInput: tourParticipants,
                                                    tourPrizeInput: tourPrize,
                                                    tourURLInput: tourURL,
                                                    tourStartTimeInput: tourStartTime,
                                                    tourEndTimeInput: tourEndTime,
                                                    tourLocNameInput: tourLocName,
                                                    tourLocUnitInput: tourLocUnit,
                                                    tourLocStreetInput: tourLocStreet,
                                                    tourLocCityInput: tourLocCity,
                                                    tourLocStateInput: tourLocState,
                                                    tourLocCountryInput: tourLocCountry)
                
                    
                    
                    self.tournaments.append(newTournament)
                    self.tournamentsTableView.reloadData()
                }
                
            }
            
        })
        
    }
    
    func reloadTableWhenAddChild () {
        databaseRef.database.reference().child("GameShip_Tournaments").observe(.childAdded, with: { (snapshot) in
            self.tournamentsTableView.reloadData()
        }, withCancel: nil)
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
    
        cell.topRightLabel.text = tournament.tourLevel
        cell.mainHeaderLabel.text = tournament.tourName
        cell.subHeaderLabel.text = tournament.tourGame
        cell.dateLabel.text = converter.convertToDate(tournament.tourStartTime!)
        cell.locationLabel.text = tournament.tourLocName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "DetailedTournamentsViewController") as? DetailedTournamentsViewController else { return }
        let selectedTourmanent = tournaments[indexPath.row]
        destination.selectedTournamentProfile = selectedTourmanent
        navigationController?.pushViewController(destination, animated: true)
    }
    
    
}


