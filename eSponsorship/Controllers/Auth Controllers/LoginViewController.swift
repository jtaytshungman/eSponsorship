//
//  LoginViewController.swift
//  
//
//  Created by Salem Abdulla on 9/26/17.
//
import Foundation
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
        //check if the user already signed in
        loginButton.layer.cornerRadius = 10
        usernameTextField.layer.cornerRadius = 10
        passwordTextField.layer.cornerRadius = 10
        if Auth.auth().currentUser != nil {
            correctSignInHandler()
        }
        
    }
    @IBAction func toSignUpPageButtonTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")
        present(vc!, animated: true, completion: nil)
    }
}

extension LoginViewController {
    
    func loginUser() {
        guard let email = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if self.usernameTextField.text == "" {
                PromptHandler.showPrompt(title: "Empty Email Field", message: "Please input valid Email", in: self)
                return
            } else if self.passwordTextField.text == "" {
                PromptHandler.showPrompt(title: "Empty Password Field", message: "Please input valid password", in: self)
                return
            }
            
            if let validError = error {
                print(validError.localizedDescription)
                //self.createErrorAlert("Error", validError.localizedDescription)
                PromptHandler.showPrompt(title: "Error", message: "\(validError.localizedDescription)", in: self)
            }
            
            if let validUser = user {
                print(validUser)
                self.correctSignInHandler()
            }
        }
    }
    
    func correctSignInHandler(){
        let mainStoryboard = UIStoryboard(name: "Home", bundle: nil)
        guard let targetVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController else {
            return print("Error Alert")
        }
        present(targetVC, animated: true, completion: nil)
    }
    
    
    
}
