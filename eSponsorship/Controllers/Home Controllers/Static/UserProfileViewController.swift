//
//  UserProfileViewController.swift
//  eSponsorship
//
//  Created by Hoang Thu Ha on 9/10/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var gameChoice1Lbl: UILabel!
    
    @IBOutlet weak var gameChoice1LevelLbl: UILabel!
    
    @IBOutlet weak var gameChoice2Lbl: UILabel!
    
    @IBOutlet weak var gameChoice2LevelLbl: UILabel!
    
    @IBOutlet weak var gameChoice3Lbl: UILabel!
    
    @IBOutlet weak var gameChoice3LevelLbl: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var fbURLLbl: UILabel!
    
    @IBOutlet weak var locationLbl: UILabel!
    
    @IBOutlet weak var usernameLbl: UILabel!
    
    @IBOutlet weak var otherURLLbl: UILabel!
    
    @IBOutlet weak var twitchURLLbl: UILabel!
    
    @IBOutlet weak var youtubeURLLbl: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadUserInfoHandler()
        
    }
    
    func loadUserInfoHandler () {
        guard let currentUserUID = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(currentUserUID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                
                if let profilePicURL = dictionary["user_profile_image_url"] as? String {
                    guard let url = URL(string : profilePicURL) else {
                        return
                    }

                    let session = URLSession.shared
                    let task = session.dataTask(with: url) { (data, response, error) in
                        if let error = error {
                            print ("Error : \(error.localizedDescription)")
                            return
                        }
                        if let data = data {
                            //self.pokemonImageView.image = UIImage(data: data)
                            DispatchQueue.main.async {
                                self.profileImage.image = UIImage(data: data)
                            }
                        }
                    }
                    task.resume()
                }
                
                if
                    let email = dictionary["email"] as? String,
                    let name = dictionary["name"] as? String,
                    let userGameChoice1 = dictionary["user_GameChoice_1"] as? String,
                    let userGameChoice1Lv = dictionary["user_GameChoice_1_level"] as? String,
                    let userGameChoice2 = dictionary["user_GameChoice_2"] as? String,
                    let userGameChoice2Lv = dictionary["user_GameChoice_2_level"] as? String,
                    let userGameChoice3 = dictionary["user_GameChoice_3"] as? String,
                    let userGameChoice3Lv = dictionary["user_GameChoice_3_level"] as? String,
                    let desc = dictionary["user_bio_desc"] as? String,
                    let facebookURL = dictionary["user_facebook_url"] as? String,
                    let youtubeURL = dictionary["user_youtube_url"] as? String,
                    let twitchURL = dictionary["user_twitch_url"] as? String,
                    let otherURL = dictionary["user_others_url"] as? String,
                    let location = dictionary["location"] as? String,
                    let username = dictionary["user_name"] as? String
                {
                    
                    self.gameChoice1Lbl.text = userGameChoice1
                    self.gameChoice1LevelLbl.text = userGameChoice1Lv
                    self.gameChoice2Lbl.text = userGameChoice2
                    self.gameChoice2LevelLbl.text = userGameChoice2Lv
                    self.gameChoice3Lbl.text = userGameChoice3
                    self.gameChoice3LevelLbl.text = userGameChoice3Lv
                    self.descriptionLbl.text = desc
                    self.fbURLLbl.text = facebookURL
                    self.locationLbl.text = location
                    self.usernameLbl.text = username
                    self.otherURLLbl.text = otherURL
                    self.twitchURLLbl.text = twitchURL
                    self.youtubeURLLbl.text = youtubeURL
                    self.emailLbl.text = email
                    self.nameLbl.text = name
                    
                }
            }
        }, withCancel: nil)
    }
    
}

