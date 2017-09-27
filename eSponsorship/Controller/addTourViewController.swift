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
  
        saveToLibrary()
        RegisterUser()

        
        
    }
    
    //        uploadMedia(completion: imagePicked)
    
    func saveToLibrary(){
        var imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        var compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        var alert = UIAlertController(title: "Picture", message: "saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
//        var alert = UIAlertView(title: "Wow",
//                                message: "Image saved to Library",
//                                delegate: nil,
//                                cancelButtonTitle: "Ok")
//        alert.show(addTourViewController, sender: self)
//        alert.addAction(done)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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
        
        
        guard let name = nameTextField.text,
            let tourName = nameTextField.text,
            let location = locationTextField.text,
            let date = dateTextField.text,
            let game = gameTextField.text,
          
            let prize = prizeTextField.text else {return}
           if tourName == "" || location == "" || date == "" || game == "" || prize == "" {
//            createErrorAlert("Missing input field", "Input field must be filled")
            return
        }
        uploadMedia { (downloadURL) in
            
            if let url = downloadURL {
                let ref = Database.database().reference()
                let imagePost : String = url

        let postRef = Database.database().reference()
        guard let id = Auth.auth().currentUser?.uid else {return}
        let post : [String:Any] = ["name" : name, "userID": id, "location" : location, "date" : date, "game" : game, "prize" : prize, "imagePost" : imagePost]
        
        postRef.child("posts").childByAutoId().setValue(post)

        }
    }
func createErrorAlert(_ title: String, _ message: String, vc: addTourViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
//        vc(alert, animated: true, completion: nil)
        vc.present(alert, animated: true, completion: nil)

    
}

}

}


