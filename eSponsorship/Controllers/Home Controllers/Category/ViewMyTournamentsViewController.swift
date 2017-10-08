
//
//  Created by Salem Abdulla on 10/7/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewMyTournamentViewController: UIViewController {
    
    var posts: [TourPosting] = []
    
    
    var databaseRef: DatabaseReference!
    var storageRef: StorageReference!
    
    
    @IBAction func backButton(_ sender: Any) {
        
        
        let storyboardNew = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = storyboardNew.instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController else {
            return
        }
        present(vc, animated: true, completion: nil)
        
        
        
    }
    

    
    
    
    @IBOutlet weak var viewMyTournamentsTableView: UITableView!{
        didSet{
            viewMyTournamentsTableView.register(TournamentTableViewCell.cellNib, forCellReuseIdentifier: TournamentTableViewCell.cellIdentifier)
            viewMyTournamentsTableView.delegate = self
            viewMyTournamentsTableView.dataSource = self
            viewMyTournamentsTableView.estimatedRowHeight = 80
            viewMyTournamentsTableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "view My Tournaments TableView"
        
        fetchpost()
        
        //tournamentsTableView.reloadData()
        
    }
    
    
    func fetchpost(){
        
        databaseRef = Database.database().reference()
        
        databaseRef.child("GameShip_Tournaments").observe(.childAdded, with: { (snapshot) in
            
            guard let mypost = snapshot.value as? [String: Any]
                else {return}
            
            
            
            if let imageurl = mypost["image_url"] as? String,
                let tournamentName = mypost["tournament_name"] as? String,
                let location = mypost["location_name"] as? String,
                let gameName = mypost["competing_game"] as? String,
                let dateName = mypost["start_time"] as? String,
                let prizeName = mypost["prize_pool"] as? String,
                let userid = mypost["userID"] as? String {
                
                
                //            let newPost = mypost(imageName: post)
                
                
                DispatchQueue.main.async {
                    let newPost = TourPosting(anID: userid,theTournamentName: tournamentName, theLocation: location, imageName : imageurl, theDate : dateName, theGame: gameName, prize: prizeName)
                    
                    
                    self.posts.append(newPost)
                    self.viewMyTournamentsTableView.reloadData()
                }
                
            }
            
        })
        
    }
}

extension ViewMyTournamentViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = viewMyTournamentsTableView.dequeueReusableCell(withIdentifier: TournamentTableViewCell.cellIdentifier) as? TournamentTableViewCell else {
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "DetailedTournamentsViewController") as? DetailedTournamentsViewController else {return}
        
        let selectedTourmanent = posts[indexPath.row]
        
        destination.selectedTournamentProfile = selectedTourmanent
        navigationController?.pushViewController(destination, animated: true)
    }
    
    
    
    
    
    
}



