//
//  Universal Functions.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 27/09/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import ImageRow
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
        image.layer.borderColor = UIColor.black.cgColor
    }
}

public class converter {
    class func convertToDate(_ timeInterval: Double) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-dd HH:mm"
        let timeString = dateFormatter.string(from: date)
        
        return timeString
    }
}


public class FirebaseDataHandler {
    
    
    class func convertImageRowToURL (imageToConvert : UIImage, completion : @escaping ((String?) -> ())) {
//        var urlString : String = ""
        let ref = Database.database().reference()
        let imageUID = "IMAGE_" + NSUUID().uuidString
        let storageReference = Storage.storage().reference().child("Uploaded_Images").child("\(imageUID).jpeg")
        if let image = imageToConvert as? UIImage  {
            if let imageData = UIImageJPEGRepresentation(image, 0.2) {
                storageReference.putData(imageData, metadata: nil, completion: { (metadata, error) in
                    guard let imageURLString = metadata?.downloadURL()?.absoluteString else {
                        completion(nil)
                        return print("error converting image to string url")
                    }
                    completion(imageURLString)
                })
            }
        }
    }
    
    // MARK : Tournament Update Related to FB
    class func uploadTournamentHandler (uid : String, values : [String : Any]) {
        
        let tournamentImage = values["tournament_image_url"] as? UIImage
        var firebaseValues = values
        firebaseValues["tournament_image_url"] = nil
        
        let ref = Database.database().reference()
        guard let currentUSER = Auth.auth().currentUser?.uid else { return }
        let tourReference = ref.child("GameShip_Tournaments").childByAutoId()
        tourReference.child("Tournament_UID").setValue(tourReference.key)
        
        tourReference.updateChildValues(firebaseValues) { (error, ref) in
            
            if error != nil {
                print(error as Any)
                return
            }
        }
        
        tourReference.updateChildValues(["UserID_sub" : currentUSER])
        
        if let image = tournamentImage {
            convertImageRowToURL(imageToConvert: image, completion: { (imageUrl) in
                if let url = imageUrl {
                        tourReference.updateChildValues(["image_url" : url])
                }
                let userReference = ref.child("users").child(uid).child("User_Tournament_Organizing")
                userReference.updateChildValues([tourReference.key : "Tournament_UID"])
            })
        } else {
            // creates specifically the tournament key in users
            let userReference = ref.child("users").child(uid).child("User_Tournament_Organizing")
            userReference.updateChildValues([tourReference.key : "Tournament_UID"])
        }
        
    }
    
    // Team upload to gameship_teams
//    class func uploadTeamsHandler (uid : String, values : [String : Any]) {
//
//        let ref = Database.database().reference()
//        let userReference = ref.child("users").child(uid).child("User_Teams")
//
//        let teamReference = ref.child("GameShip_Teams").childByAutoId()
//        teamReference.child(teamReference.key).setValue("Teams_For_GameShip")
//
//        userReference.updateChildValues([teamReference.key : "key"])
//        teamReference.updateChildValues(values) { (error, ref) in
//            if error != nil {
//                print(error)
//                return
//            }
//        }
//    }
    
    // MARK : Profile Handlers Related To FB
    class func uploadToUserProfileHandler (uid : String, values : [String : Any]) {
        
        let profileImage = values ["user_image_url"] as? UIImage
        var firebaseValues = values
        firebaseValues ["user_image_url"] = nil
        
        let ref = Database.database().reference()
        let currentUserID = ref.child("users").child(uid)
        
        if let image = profileImage {
            convertImageRowToURL(imageToConvert: image, completion: { (imageUrl) in
                if let url = imageUrl {
                    currentUserID.updateChildValues(["user_image_url" : url])
                    
                }
                
            })
            
        }
        
        currentUserID.updateChildValues (firebaseValues) { (error, ref) in
            if error != nil {
                print(error as Any)
                return
            }
            
        }
        
    }
    
    class func deleteTournamentFromFirebase (tournamentUID : String, userUID : String) {
        let ref = Database.database().reference()
        ref.child("GameShip_Tournaments").child(tournamentUID).removeValue { (error, ref) in
            if error != nil {
                print(error as Any)
            }
        }
        ref.child("users").child(userUID).child("User_Tournament_Organizing").child(tournamentUID).removeValue { (error, ref) in
            if error != nil {
                print(error as Any)
            }
        }
    }
    
}
