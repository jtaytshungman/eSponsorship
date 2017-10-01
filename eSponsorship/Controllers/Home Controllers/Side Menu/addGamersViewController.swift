//
//  addGamersViewController.swift
//  eSponsorship
//
//  Created by Salem Abdulla on 9/29/17.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class addGamersViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
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
        let vc = HomeViewController(
            nibName: "HomeViewController",
            bundle: nil)
        navigationController?.pushViewController(vc,
                                                 animated: true )
        
        
        
    }
    
    //        uploadMedia(completion: imagePicked)
    
    func saveToLibrary(){
        
        if imagePicked.image == nil {
            createErrorAlert("Missing input field", "Input field must be filled")
            return
        }
        
        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        let alert = UIAlertController(title: "Thank you", message: "your information is saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    //    func saveToLibrary() {
    //
    //        if let error = error {
    //            // we got back an error!
    //            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
    //            ac.addAction(UIAlertAction(title: "OK", style: .default))
    //            present(ac, animated: true)
    //        } else {
    //            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
    //            ac.addAction(UIAlertAction(title: "OK", style: .default))
    //            present(ac, animated: true)
    //        }
    //    }
    
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
    
    func createErrorAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        //        vc(alert, animated: true, completion: nil)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePicked.image = image
        
        dismiss(animated:true, completion: nil)
    }
    
    
    
    func RegisterUser() {
        
        
        guard let name = nameTextField.text,
            let tourName = nameTextField.text,
            let location = locationTextField.text,
            
            let game = gameTextField.text
            else {return}
        if tourName == "" || location == "" || game == "" {
            createErrorAlert("Missing input field", "Input field must be filled")
            return
        }
        if imagePicked == nil{
            createErrorAlert("Missing input field", "Input field must be filled")
        }
        uploadMedia { (downloadURL) in
            
            if let url = downloadURL {
                let ref = Database.database().reference()
                let imagePost : String = url
                
                let postRef = Database.database().reference()
                guard let id = Auth.auth().currentUser?.uid else {return}
                let post : [String:Any] = ["name" : name, "userID": id, "location" : location, "game" : game, "imagePost" : imagePost]
                
                postRef.child("GamersPosts").childByAutoId().setValue(post)
                
            }
        }
        
        
    }
    //    func BackToBack(){
    //        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    //        guard let targetVC = mainStoryboard.instantiateViewController(withIdentifier: "addTourViewController") as? addTourViewController else { return }
    //                self.dismiss(animated: true, completion: nil)
    //
    //
    //        self.present(targetVC, animated: true, completion: nil)
    //    }

    
}




