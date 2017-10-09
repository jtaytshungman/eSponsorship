//  Created by Salem Abdulla on 10/7/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewMyTournamentViewController: UIViewController {
    var posts: [viewMyTour] = []
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
        
//        self.viewMyTournamentsTableView.reloadData()
        
    }
    
    
    func fetchpost(){
        databaseRef = Database.database().reference()
        
        databaseRef.child("GameShip_Tournaments").observe(.childAdded, with: { (snapshot) in
            guard let mypost = snapshot.value as? [String: Any]
                else {return}
            if let tournament_name = mypost["tournament_name"] as? String,
                let competing_game = mypost["competing_game"] as? String,
                let creatorID = mypost["UserID_sub"] as? String {
                if creatorID == Auth.auth().currentUser?.uid {
                    DispatchQueue.main.async {
                        let newPost = viewMyTour(theTournament_name: tournament_name, theCompeting_game: competing_game)
                        self.posts.append(newPost)
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
        cell.tournamentName.text = post.tournament_name
        cell.locationOfTournament.text = post.competing_game
        return cell
    }

    
    
    
    
}



