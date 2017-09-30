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

    
    var posts: [TournamentPost] = []
    
    
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
        
        //tournamentsTableView.reloadData()
        
    }
    
    
    func fetchpost(){
        
        databaseRef = Database.database().reference()
        
        databaseRef.child("posts").observe(.childAdded, with: { (snapshot) in
            
            guard let mypost = snapshot.value as? [String: Any]
                else {return}
            
            
            
            if let imageurl = mypost["imagePost"] as? String,
                let tournamentName = mypost["name"] as? String,
                let location = mypost["location"] as? String,
                let gameName = mypost["game"] as? String,
                let dateName = mypost["date"] as? String,
                let prizeName = mypost["prize"] as? String,
                let userid = mypost["userID"] as? String {
                
                
                //            let newPost = mypost(imageName: post)
                
                
            DispatchQueue.main.async {
                let newPost = TournamentPost(anID: userid,theTournamentName: tournamentName, theLocation: location, imageName : imageurl, theDate : dateName, theGame: gameName, prize: prizeName)
                
                
                self.posts.append(newPost)
                self.tournamentsTableView.reloadData()
            }
            
        }
        
    })
    
}
}

extension TournamentsViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tournamentsTableView.dequeueReusableCell(withIdentifier: TournamentTableViewCell.cellIdentifier) as? TournamentTableViewCell else {
            return UITableViewCell()
        }
                let post = posts[indexPath.row]
        
//        cell.tournamentName.text = tournamentName
//        cell.locationOfTournament.text = location
//        cell.organizerName.text = organizerName
//        cell.numberOfParticipants.text = participation

        cell.tournamentName.text = post.tournamentName
        cell.locationOfTournament.text = post.location
        cell.organizerName.text = post.gameName
        cell.numberOfParticipants.text = post.prizeName
        
        print(post.imageurl)
        cell.backgroundImageCell.loadImage(from: post.imageurl)
        
        
        return cell
    }
    
    }

