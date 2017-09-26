//
//  tournamentsViewController.swift
//  eSponsorship
//
//  Created by Salem Abdulla on 9/26/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class tournamentsViewController: UIViewController {

    @IBAction func logoutButton(_ sender: Any) {
        
        
        let mainStoryboard = UIStoryboard(name: "Auth", bundle: nil)
        guard let targetVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        //        self.dismiss(animated: true, completion: nil)
        
        
        self.present(targetVC, animated: true, completion: nil)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
   
    }

    


}
