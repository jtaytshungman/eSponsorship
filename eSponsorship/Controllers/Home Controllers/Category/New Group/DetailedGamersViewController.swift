//
//  DetailedGamersViewController.swift
//  eSponsorship
//
//  Created by Hoang Thu Ha on 6/10/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class DetailedGamersViewController: UIViewController {
    
    var selectedGamerProfile : GamersPost?
    
    @IBOutlet weak var gameTextField: UITextField!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let game = selectedGamerProfile?.gameName,
            let image = selectedGamerProfile?.imageurl,
            let location = selectedGamerProfile?.location,
            let name = selectedGamerProfile?.tournamentName
            else { return}
        gameTextField.text = game
        locationTextField.text = location
        nameTextField.text = name
       
        
        
    }
    
}













