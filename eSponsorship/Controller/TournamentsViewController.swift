//
//  TournamentsViewController.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 27/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class TournamentsViewController: UIViewController {

    @IBOutlet weak var tournamentsTableView: UITableView!{
        didSet{
            tournamentsTableView.delegate = self
            tournamentsTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tournaments"
    }

}

extension TournamentsViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    
}
