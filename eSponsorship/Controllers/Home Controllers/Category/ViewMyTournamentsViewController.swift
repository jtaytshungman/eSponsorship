//  Created by Salem Abdulla on 10/7/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewMyTournamentViewController: UIViewController {
    
    var posts: [Tournaments] = []
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
            viewMyTournamentsTableView.estimatedRowHeight = 225
            viewMyTournamentsTableView.rowHeight = 225
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "view My Tournaments TableView"
        
        fetchpost()
        
        
        
    }
    
    
//    func fetchpost(){
//        databaseRef = Database.database().reference()
//
//        databaseRef.child("GameShip_Tournaments").observe(.childAdded, with: { (snapshot) in
//            guard let mypost = snapshot.value as? [String: Any]
//                else {return}
//
//            if
//                let tournament_name = mypost["tournament_name"] as? String,
//                let competing_game = mypost["competing_game"] as? String,
//                let creatorID = mypost["UserID_sub"] as? String {
//                if creatorID == Auth.auth().currentUser?.uid {
//                    DispatchQueue.main.async {
//                        let newPost = viewMyTour(theTournament_name: tournament_name, theCompeting_game: competing_game)
//                        self.posts.append(newPost)
//                        self.viewMyTournamentsTableView.reloadData()
//                    }
//                }
//            }
//        })
//    }
    
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
                
                //let tourImageURL = mypost["image_url"] as? String,
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
                let tourLocCountry = mypost["location_country"] as? String {
                
                if userId_sub == Auth.auth().currentUser?.uid {
                    DispatchQueue.main.async {
                        let newTournament = Tournaments(userID_sub_Input : userId_sub, orgNameInput: orgName, orgEmailInput: orgEmail, orgAffInput: orgAff, orgContactInput: orgContact, tourNameInput: tourName, tourGameInput: tourGame, tourLevelInput: tourLevel, tourParticipantsInput: tourParticipants, tourPrizeInput: tourPrize, tourURLInput: tourURL,tourStartTimeInput: tourStartTime, tourEndTimeInput: tourEndTime, tourLocNameInput: tourLocName, tourLocUnitInput: tourLocUnit, tourLocStreetInput: tourLocStreet, tourLocCityInput: tourLocCity, tourLocStateInput: tourLocState, tourLocCountryInput: tourLocCountry)
                        
                        self.posts.append(newTournament)
                        self.viewMyTournamentsTableView.reloadData()
                    }
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
        cell.mainHeaderLabel.text = post.tourName
        cell.subHeaderLabel.text = post.tourGame
        cell.topRightLabel.text = post.tourLevel
        cell.locationLabel.text = post.tourLocName
        cell.dateLabel.text = converter.convertToDate(post.tourStartTime!)
        return cell
    }
    
    
    
    
    
}



