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
import FirebaseDatabase

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
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
    
    @IBAction func tappedDoneButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadUserInfoHandler()
        
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        
    }
    
    func loadUserInfoHandler () {
        guard let currentUserUID = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(currentUserUID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                
                if let email = dictionary["email"] as? String {
                    
                    self.emailLbl.text = email
                }
               
                if let userGameChoice1 = dictionary["user_GameChoice_1"] as? String {
                    
                    self.gameChoice1Lbl.text = userGameChoice1
                    
                }
                
                if let userGameChoice1Lv = dictionary["user_GameChoice_1_level"] as? String {
                    
                    self.gameChoice1LevelLbl.text = userGameChoice1Lv
                    
                }
                
                if let userGameChoice2 = dictionary["user_GameChoice_2"] as? String {
                    
                    self.gameChoice2Lbl.text = userGameChoice2
                }
                
                if let userGameChoice2Lv = dictionary["user_GameChoice_2_level"] as? String {
                    
                    self.gameChoice2LevelLbl.text = userGameChoice2Lv
                
                }
                
                if let userGameChoice3 = dictionary["user_GameChoice_3"] as? String {
                    
                    self.gameChoice3Lbl.text = userGameChoice3
                }
                
                if let userGameChoice3Lv = dictionary["user_GameChoice_3_level"] as? String {
                    
                    self.gameChoice3LevelLbl.text = userGameChoice3Lv
                }
             
                if let desc = dictionary["user_bio_desc"] as? String {
                    
                    self.descriptionLbl.text = desc
                    
                }
                
                if let facebookURL = dictionary["user_facebook_url"] as? String {
                    
                    self.fbURLLbl.text = facebookURL
                }
                
                if let youtubeURL = dictionary["user_youtube_url"] as? String {
                    self.youtubeURLLbl.text = youtubeURL
                    
                }

                if let twitchURL = dictionary["user_twitch_url"] as? String {
                    self.twitchURLLbl.text = twitchURL
                }
                
                if let otherURL = dictionary["user_others_url"] as? String {
                    
                    self.otherURLLbl.text = otherURL
                    
                }
                
                if let location = dictionary["location"] as? String {
                    self.usernameLbl.text = location
                    
                }
                
                if let username = dictionary["user_name"] as? String {
                    
                    self.usernameLbl.text = username
                    
                }

                if let profilePicURL = dictionary["user_image_url"] as? String {
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
                
                
            }
        }, withCancel: nil)
    }
    
}

