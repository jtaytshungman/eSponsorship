//
//  ViewMyTeamsViewController.swift
//  eSponsorship
//
//  Created by Salem Abdulla on 10/7/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewMyTeamsViewController: UIViewController {
    
    var posts: [TeamPosting] = []
    
    
    var databaseRef: DatabaseReference!
    var storageRef: StorageReference!
    
    
    @IBOutlet weak var viewTeamzTableView: UITableView!{
        didSet{
            viewTeamzTableView.register(TeamsTableViewCell.cellNib, forCellReuseIdentifier: TeamsTableViewCell.cellIdentifier)
            viewTeamzTableView.delegate = self
            viewTeamzTableView.dataSource = self
            viewTeamzTableView.estimatedRowHeight = 80
            viewTeamzTableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Teams"
        if Auth.auth().currentUser != nil {
            fetchpost()
            
        }
        
        
        
    }
    
    
    func fetchpost(){
        
        
        
        
        
        
        databaseRef = Database.database().reference()
        
        databaseRef.child("TeamsPosts").observe(.childAdded, with: { (snapshot) in
            
            guard let mypost = snapshot.value as? [String: Any]
                else {return}
            
            
            
            if let imageurl = mypost["imagePost"] as? String,
                let tournamentName = mypost["name"] as? String,
                let location = mypost["location"] as? String,
                let gameName = mypost["game"] as? String,
                
                let userid = mypost["userID"] as? String {
                
                DispatchQueue.main.async {
                    let teamPost = TeamPosting(anID: userid,theTournamentName: tournamentName, theLocation: location, imageName : imageurl, theGame: gameName)
                    
                    
                    self.posts.append(teamPost)
                    self.viewTeamzTableView.reloadData()
                }
                
            }
            
        })
        
    }
}

extension ViewMyTeamsViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = viewTeamzTableView.dequeueReusableCell(withIdentifier: TeamsTableViewCell.cellIdentifier) as? TeamsTableViewCell else {
            return UITableViewCell()
        }
        let post = posts[indexPath.row]
        
        
        
        cell.tournamentNameq.text = post.tournamentName
        cell.locationOfTournamentq.text = post.location
        cell.organizerNameq.text = post.gameName
        print(post.imageurl)
        cell.backgroundImageCellq.loadImage(from: post.imageurl)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "DetailedTeamsViewController") as? DetailedTeamsViewController else {return}
        
        let selectedTeam = posts[indexPath.row]
        
        destination.selectedTeamProfile = selectedTeam
        navigationController?.pushViewController(destination, animated: true)
    }
    
    
    
    
    
    
}



