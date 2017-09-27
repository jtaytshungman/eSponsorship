//
//  LoginViewController.swift
//  
//
//  Created by Salem Abdulla on 9/26/17.
//

import UIKit
import FirebaseAuth
import Firebase


class LoginViewController: UIViewController {
    
    var dict : [String : AnyObject]!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    

    @IBOutlet weak var loginButton: UIButton!{
    
    didSet {
    loginButton.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
    }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      correctSignInHandler()
        
        
    }
//    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
//        if ((error) != nil) {
//            // Process error
//        }
//        else if result.isCancelled {
//            // Handle cancellations
//        }
//        else {
//            // Navigate to other view
//        }
//    }
    func loginUser() {
        guard let email = usernameTextField.text else {return}
        
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if self.usernameTextField.text == "" {
                self.createErrorAlert("Empty email field", "Please input valid Email")
                return
            } else if self.passwordTextField.text == "" {
                self.createErrorAlert("Empty password field", "Please input valid password")
                return
            }
            
            if let validError = error {
                print(validError.localizedDescription)
                self.createErrorAlert("Error", validError.localizedDescription)
            }
            
            if let validUser = user {
                print(validUser)
                self.correctSignInHandler()
                
            } //valid user
            
        } //auth
        
    } //login user
    
    func createErrorAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    func correctSignInHandler(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let targetVC = mainStoryboard.instantiateViewController(withIdentifier: "addTourViewController") as? addTourViewController else { return }
//        self.dismiss(animated: true, completion: nil)
        
    
        self.present(targetVC, animated: true, completion: nil)
    }

}
