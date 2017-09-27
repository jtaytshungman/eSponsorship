//
//  GamersViewController.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 27/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class GamersViewController: UIViewController {

    @IBOutlet weak var gamersTableView: UITableView! {
        didSet {
            gamersTableView.delegate = self
            gamersTableView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Gamers"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension GamersViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
