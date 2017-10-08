//
//  Universal Functions.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 27/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

public class PromptHandler {
    
    class func showPrompt (title: String, message: String, in vc: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
        
    }
}

public class ImageDisplay {
    class func ProfileBounds (image : UIImageView) {
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        image.layer.borderWidth = CGFloat(3.0)
        image.layer.borderColor = UIColor.white.cgColor
    }
}

public class FirebaseDataHandler {
    
    // MARK : Universal Update function is here
    class func uploadTournamentHandler (uid : String, values : [String : Any]) {
        let ref = Database.database().reference()
        let userReference = ref.child("users").child(uid).child("User_Tournament_Organizing")
        let tourReference = ref.child("GameShip_Tournaments").childByAutoId()
        tourReference.child(tourReference.key).setValue("Tournaments_For_GameShip")
        userReference.updateChildValues([tourReference.key : "key"])
        tourReference.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error)
                return
            }
        }
    }
    
    class func uploadTeamsHandler (uid : String, values : [String : Any]) {
        let ref = Database.database().reference()
        let userReference = ref.child("users").child(uid).child("User_Teams")
        let tourReference = ref.child("GameShip_Teams").childByAutoId()
        tourReference.child(tourReference.key).setValue("Teams_For_GameShip")
        userReference.updateChildValues([tourReference.key : "key"])
        tourReference.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error)
                return
            }
        }
    }
    
    class func uploadToUserProfileHandler (uid : String, values : [String : Any]) {
        let ref = Database.database().reference()
        let userReference = ref.child("users").child(uid)
        userReference.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error)
                return
            }
        }
    }
    
    class func uploadUserProfileImageHandler(imageFor : String, image : UIImage) {
        guard let currentUserUID = Auth.auth().currentUser?.uid else { return }
        guard let proImage = image as? UIImage else { return }
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("\(imageFor)").child("\(imageName).jpg")

        if let uploadData = UIImageJPEGRepresentation(proImage, 0.5) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in

                if error != nil {
                    print(error)
                    return
                }

                if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                    let values = ["userImageURL" : profileImageURL]
                    FirebaseDataHandler.uploadToUserProfileHandler(uid: currentUserUID, values: values)
                }
            }
        }
    }
}
