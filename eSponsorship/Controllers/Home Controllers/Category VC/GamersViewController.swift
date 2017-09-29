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

    var posts: [GamersPost] = []
    
    
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
        self.title = "Gamers"
        
        fetchpost()
        
        //tournamentsTableView.reloadData()
        
    }
    
    
    func fetchpost(){
        
        databaseRef = Database.database().reference()
        
        databaseRef.child("GamersPosts").observe(.childAdded, with: { (snapshot) in
            
            guard let mypost = snapshot.value as? [String: Any]
                else {return}
            
            
            
            if let imageurl = mypost["imagePost"] as? String,
                let tournamentName = mypost["name"] as? String,
                let location = mypost["location"] as? String,
                let gameName = mypost["game"] as? String,
                //                let dateName = mypost["date"] as? String,
                //                let prizeName = mypost["prize"] as? String,
                let userid = mypost["userID"] as? String {
                
                
                //            let teamPost = mypost(imageName: post)
                
                
                DispatchQueue.main.async {
                    let teamPost = GamersPost(anID: userid,theTournamentName: tournamentName, theLocation: location, imageName : imageurl, theGame: gameName)
                    
                    
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
        guard let cell = gamersTableView.dequeueReusableCell(withIdentifier: TeamsTableViewCell.cellIdentifier) as? TeamsTableViewCell else {
            return UITableViewCell()
        }
        let post = posts[indexPath.row]
        
        //        cell.tournamentName.text = tournamentName
        //        cell.locationOfTournament.text = location
        //        cell.organizerName.text = organizerName
        //        cell.numberOfParticipants.text = participation
        
        cell.tournamentNameq.text = post.tournamentName
        cell.locationOfTournamentq.text = post.location
        cell.organizerNameq.text = post.gameName
        //        cell.numberOfParticipantsq.text = post.prizeName
        
        print(post.imageurl)
        cell.backgroundImageCellq.loadImage(from: post.imageurl)
        
        
        return cell
    }
    
}



