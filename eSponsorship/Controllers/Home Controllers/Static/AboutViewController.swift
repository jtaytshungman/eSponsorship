//
//  AboutViewController.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 09/10/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var orgView: UIView!
    
    @IBOutlet weak var gamerView: UIView!
    
    @IBOutlet weak var spoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orgView.layer.cornerRadius = 20
        gamerView.layer.cornerRadius = 20
        spoView.layer.cornerRadius = 20
        
        orgView.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        gamerView.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        spoView.backgroundColor = UIColor.orange.withAlphaComponent(0.5)

        
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
