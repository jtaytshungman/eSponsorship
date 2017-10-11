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
    
    var refreshControl : UIRefreshControl?
    
    var gamersProfiles: [Gamers] = []
    
    var delegate : TitleDelegate?
    
    var databaseRef: DatabaseReference!
    var storageRef: StorageReference!

    @IBOutlet weak var gamersTableView: UITableView!{
        didSet{
            gamersTableView.register(GamersTableViewCell.cellNib, forCellReuseIdentifier: GamersTableViewCell.cellIdentifier)
            gamersTableView.delegate = self
            gamersTableView.dataSource = self
            gamersTableView.estimatedRowHeight = 130
            gamersTableView.rowHeight = 130
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.changeTitle(to: "Gamers")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchpost()

    }
    
    func fetchpost () {
        
        databaseRef = Database.database().reference()
        
        databaseRef.child("users").observe(.childAdded, with: { (snapshot) in
            guard let myGamers = snapshot.value as? [String: Any]
                else {return}
            
            if
                let userName = myGamers["user_name"] as? String,
                let userEmail = myGamers["email"] as? String,
                let userProfileImageURL = myGamers["user_image_url"] as? String,
                let userLocationBased = myGamers["user_location_based"] as? String,
                let userDescription = myGamers["user_bio_desc"] as? String,
                
                let userTwitchURL = myGamers["user_twitch_url"] as? String,
                let userYoutubeURL = myGamers["user_youtube_url"] as? String,
                let userFacebookURL = myGamers["user_facebook_url"] as? String,
                let userOtherURL = myGamers["user_others_url"] as? String,
                
                let userGameChoice1 = myGamers["user_GameChoice_1"] as? String,
                let userGameChoice1Level = myGamers["user_GameChoice_1_level"] as? String,
                let userGameChoice2 = myGamers["user_GameChoice_2"] as? String,
                let userGameChoice2Level = myGamers["user_GameChoice_2_level"] as? String,
                let userGameChoice3 = myGamers["user_GameChoice_3"] as? String,
                let userGameChoice3Level = myGamers["user_GameChoice_3_level"] as? String
            {
                
                
                DispatchQueue.main.async {
                    
                    let gamersPost = Gamers(userNameInput: userName, userEmailInput: userEmail, userProfileImageURLInput: userProfileImageURL, userLocationBasedInput: userLocationBased, userDescriptionInput: userDescription, userTwitchURLInput: userTwitchURL, userYoutubeURLInput: userYoutubeURL, userFacebookURLInput: userFacebookURL, userOtherURLInput: userOtherURL, userGameChoice1Input: userGameChoice1, userGameChoice1LevelInput: userGameChoice1Level, userGameChoice2Input: userGameChoice2, userGameChoice2LevelInput: userGameChoice2Level, userGameChoice3Input: userGameChoice3, userGameChoice3LevelInput: userGameChoice3Level)
                    
                    self.gamersProfiles.append(gamersPost)
                    self.gamersTableView.reloadData()
                }
            }
        }, withCancel: nil)
        
    }
    
}

extension GamersViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "DetailedGamersViewController") as? DetailedGamersViewController else {return}
        
        let selectedGamer = gamersProfiles[indexPath.row]
        
        destination.selectedGamerProfile = selectedGamer
        navigationController?.pushViewController(destination, animated: true)
        
    }

}

extension GamersViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamersProfiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = gamersTableView.dequeueReusableCell(withIdentifier: GamersTableViewCell.cellIdentifier, for: indexPath) as? GamersTableViewCell else {
            return UITableViewCell()
        }
        
        let gamerSelected = gamersProfiles[indexPath.row]
        
        cell.mainLabel.text = gamerSelected.userName
        cell.subMainLabel.text = gamerSelected.userGameChoice1
        cell.locationLabel.text = gamerSelected.userLocationBased
        
        if let profile_image_url = gamerSelected.userProfileImageURL {
            cell.profileImage.loadImage(from: profile_image_url)
        }
        return cell
    }
    
}






















