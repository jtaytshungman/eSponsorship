//
//  addHomeViewController.swift
//  
//
//  Created by Salem Abdulla on 9/28/17.
//

import UIKit

class addHomeViewController: UIViewController {

    @IBAction func Home(_ sender: Any) {
        
        let mainStoryboard = UIStoryboard(name: "Home", bundle: nil)
        guard let targetVC = mainStoryboard.instantiateViewController(withIdentifier: "NavigationController") as? UINavigationController else { return }
        
        present(targetVC, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
