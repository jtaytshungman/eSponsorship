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
    
    var posts: [GamerPosting] = []
    
    
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
        
        databaseRef.child("usersProfiles").observe(.childAdded, with: { (snapshot) in
            
            guard let mypost = snapshot.value as? [String: Any]
                else {return}
            
            
            
            if let imageurl = mypost["imagePost"] as? String,
                let tournamentName = mypost["name"] as? String,
                let location = mypost["location"] as? String,
                let gameName = mypost["game"] as? String,
                let dob = mypost["date of birth"] as? String,
                let level = mypost["competitive level"] as? String,
                let desc = mypost["description"] as? String,
                
                let userid = mypost["userID"] as? String {
                
                
                DispatchQueue.main.async {
                    let teamPost = GamerPosting(anID: userid,theTournamentName: tournamentName, theLocation: location, imageName : imageurl, theGame: gameName,dateOfBirth: dob, descriptionText: desc, levelcomp: level)
                    
                    
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
        
        cell.tournamentNamek.text = post.tournamentName
        cell.locationOfTournamentk.text = post.location
        cell.organizerNamek.text = post.gameName
        //        cell.numberOfParticipantsq.text = post.prizeName
        
        print(post.imageurl)
        cell.backgroundImageCellk.loadImage(from: post.imageurl)

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "DetailedGamersViewController") as? DetailedGamersViewController else {return}
        
        let selectedGamer = posts[indexPath.row]
        
        destination.selectedGamerProfile = selectedGamer
        navigationController?.pushViewController(destination, animated: true)
        
    }
}




















