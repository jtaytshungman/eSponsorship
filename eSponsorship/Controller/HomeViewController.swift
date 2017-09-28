//
//  HomeViewController.swift
//  eSponsorship
//
//  Created by Salem Abdulla on 9/27/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import FirebaseStorage

class HomeViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var posts: [Post] = []
    
    var databaseRef: DatabaseReference!
    var storageRef: StorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        //        tableView.delegate = self
        
        
        fetchpost()
        
        tableView.reloadData()
        
        
        
    }
    func fetchpost(){
        
        databaseRef = Database.database().reference()
        
        databaseRef.child("posts").observe(.childAdded, with: { (snapshot) in
            
            guard let mypost = snapshot.value as? [String: Any]
                else {return}
            
            
            
            if let imageurl = mypost["imageurl"] as? String,
                let userid = mypost["userid"] as? String {
                
                
                //            let newPost = mypost(imageName: post)
                
                
                
                let newPost = Post(anID: userid, imageName: imageurl)
                
                self.posts.append(newPost)
                self.tableView.reloadData()
                
            }
            
        })
        
    }
}

extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1 get the cell
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PostTableViewCell
            else{ return UITableViewCell() }
        
        
        //2 Setup
        let post = posts[indexPath.row]
        
        
        cell.postImagevIEW.loadImage(from: post.imageurl)
        
        
        //return cell
        return cell
    }
}


