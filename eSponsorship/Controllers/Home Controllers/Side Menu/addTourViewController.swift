//
//  addTourViewController.swift
//  eSponsorship
//
//  Created by Salem Abdulla on 9/27/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class addTourViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBAction func logout(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
        guard let targetVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController else { return }
                self.dismiss(animated: true, completion: nil)
        
        
        self.present(targetVC, animated: true, completion: nil)
        
        
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var gameTextField: UITextField!
    @IBOutlet weak var prizeTextField: UITextField!
    @IBOutlet weak var imagePicked: UIImageView!
    
    @IBAction func saveTappButtonPressed(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    //open gallery
    @IBAction func GalleryViewTapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //save
    @IBAction func SaveBtnTapped(_ sender: Any) {
        RegisterUser()
        saveToLibrary()
        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true )
    }
    
    func saveToLibrary() {
        
        if imagePicked.image == nil {
            PromptHandler.showPrompt(title: "Missing Input Field", message: "Important Fields must be filled out", in: self)
            return
        }
        
        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        PromptHandler.showPrompt(title: "Photo Saved", message: "Your information is saved", in: self)
    }
    
    func uploadMedia(completion: @escaping (_ url: String?) -> Void) {
        let storageRef = Storage.storage().reference().child("myImage.jpeg")
        if let uploadData = UIImageJPEGRepresentation(self.imagePicked.image!, 0.5) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("error")
                    completion(nil)
                } else {
                    completion((metadata?.downloadURL()?.absoluteString)!)
                    // your uploaded photo url.
                }
            }
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePicked.image = image
        
        dismiss(animated:true, completion: nil)
    }
    
    func RegisterUser() {
        
        guard
            let name = nameTextField.text,
            let tourName = nameTextField.text,
            let location = locationTextField.text,
            let date = dateTextField.text,
            let game = gameTextField.text,
            let prize = prizeTextField.text else {
                return
        }
        
        if tourName == "" || location == "" || date == "" || game == "" || prize == "" {
            PromptHandler.showPrompt(title: "Missing Field", message: "Important Field Must Be Filled", in: self)
            return
        }
        
        if imagePicked == nil{
            PromptHandler.showPrompt(title: "Missing Field", message: "Important Field Must Be Filled", in: self)
        }
        
        uploadMedia { (downloadURL) in
            if let url = downloadURL {
                
                let ref = Database.database().reference()
                let imagePost : String = url
                let postRef = Database.database().reference()
                
                guard let id = Auth.auth().currentUser?.uid else { return }
                
                let post : [String:Any] = ["name" : name, "userID": id, "location" : location, "date" : date, "game" : game, "prize" : prize, "imagePost" : imagePost]
                
                postRef.child("posts").childByAutoId().setValue(post)
            }
        }
    }
}


