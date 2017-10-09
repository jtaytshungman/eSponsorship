//
//  GamersViewController.swift
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

class GamersViewController: UIViewController {
    
    var posts: [Gamers] = []
    
    
    var databaseRef: DatabaseReference!
    var storageRef: StorageReference!
    
    //    let tournamentName = "Monash Dota Competition"
    //    let organizerName = "Monash University"
    //    let participation = "12 Teams"
    //    let location = "Cyberjaya Launchpad"
    
    @IBOutlet weak var gamersTableView: UITableView!{
        didSet{
            gamersTableView.register(GamersTableViewCell.cellNib, forCellReuseIdentifier: GamersTableViewCell.cellIdentifier)
            gamersTableView.delegate = self
            gamersTableView.dataSource = self
            gamersTableView.estimatedRowHeight = 80
            gamersTableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        
        fetchpost()
        
        //tournamentsTableView.reloadData()
        
    }
    
    
    func fetchpost(){
        
        databaseRef = Database.database().reference()
        
        databaseRef.child("users").observe(.childAdded, with: { (snapshot) in
            
            guard let mypost = snapshot.value as? [String: Any]
                else {return}
            
            
            
            if let userName = mypost["name"] as? String,
                //let userProfileImageURL = mypost["userImageURL"] as? String,
                let userLocationBased = mypost["user_location_based"] as? String,
                let userDescription = mypost["user_bio_desc"] as? String,
                
                let userTwitchURL = mypost["user_twitch_url"] as? String,
                let userYoutubeURL = mypost["user_youtube_url"] as? String,
                let userFacebookURL = mypost["user_facebook_url"] as? String,
                let userOtherURL = mypost["user_others_url"] as? String,
                
                let userGameChoice1 = mypost["user_GameChoice_1"] as? String,
                let userGameChoice1Level = mypost["user_GameChoice_1_level"] as? String,
                let userGameChoice2 = mypost["user_GameChoice_2"] as? String,
                let userGameChoice2Level = mypost["user_GameChoice_2_level"] as? String,
                let userGameChoice3 = mypost["user_GameChoice_3"] as? String,
                let userGameChoice3Level = mypost["user_GameChoice_3_level"] as? String
            {
                
                
                DispatchQueue.main.async {
                    let teamPost = Gamers(userNameInput: userName, userLocationBasedInput: userLocationBased, userDescriptionInput: userDescription, userTwitchURLInput: userTwitchURL, userYoutubeURLInput: userYoutubeURL, userFacebookURLInput: userFacebookURL, userOtherURLInput: userOtherURL, userGameChoice1Input: userGameChoice1, userGameChoice1LevelInput: userGameChoice1Level, userGameChoice2Input: userGameChoice2, userGameChoice2LevelInput: userGameChoice2Level, userGameChoice3Input: userGameChoice3, userGameChoice3LevelInput: userGameChoice3Level)
                    
                    
                    self.posts.append(teamPost)
                    self.gamersTableView.reloadData()
                }
                
            }
            
        })
        
    }
}

extension GamersViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = gamersTableView.dequeueReusableCell(withIdentifier: GamersTableViewCell.cellIdentifier) as? GamersTableViewCell else {
            return UITableViewCell()
        }
        
        let post = posts[indexPath.row]
        
        //        cell.tournamentName.text = tournamentName
        //        cell.locationOfTournament.text = location
        //        cell.organizerName.text = organizerName
        //        cell.numberOfParticipants.text = participation
        
        cell.tournamentNamek.text = post.userName
        cell.locationOfTournamentk.text = post.userLocationBased
        cell.organizerNamek.text = post.userDescription
        //        cell.numberOfParticipantsq.text = post.prizeName
        
//        print(post.userProfileImageURL)
//        cell.backgroundImageCellk.loadImage(from: post.userProfileImageURL!)

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "DetailedGamersViewController") as? DetailedGamersViewController else {return}
        
        let selectedGamer = posts[indexPath.row]
        
        destination.selectedGamerProfile = selectedGamer
        navigationController?.pushViewController(destination, animated: true)
        
    }
}




















