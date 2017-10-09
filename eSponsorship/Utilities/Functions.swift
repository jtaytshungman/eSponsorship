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
        image.layer.borderColor = UIColor.white.cgColor
    }
}

public class converter {
    class func convertToDate(_ timeInterval: Double) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd HH:mm"
        let timeString = dateFormatter.string(from: date)
        
        return timeString
    }
}


public class FirebaseDataHandler {
    
    
    class func convertImageRowToURL (imageToConvert : UIImage) -> String? {
        var urlString : String = ""
        let ref = Database.database().reference()
        let imageUID = "IMAGE_" + NSUUID().uuidString
        let storageReference = Storage.storage().reference().child("Uploaded_Images").child("\(imageUID).jpeg")
        if let image = imageToConvert as? UIImage  {
            if let imageData = UIImageJPEGRepresentation(image, 0.2) {
                storageReference.putData(imageData, metadata: nil, completion: { (metadata, error) in
                    guard let imageURLString = metadata?.downloadURL()?.absoluteString else {
                        return print("error converting image to string url")
                    }
                    urlString = imageURLString
                })
            }
        }
        return urlString
    }
    
    // MARK : Tournament Update Related to FB
    class func uploadTournamentHandler (uid : String, values : [String : Any]) {
        let ref = Database.database().reference()
        guard let currentUSER = Auth.auth().currentUser?.uid else { return }
        // creates tournament child notes name "GameShip_Tournaments"
        let tourReference = ref.child("GameShip_Tournaments").childByAutoId()
        tourReference.child("Tournament_UID").setValue(tourReference.key)
        
        tourReference.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error)
                return
            }
        }
        tourReference.updateChildValues(["UserID_sub" : currentUSER])
        
        if let image = ImageRow().value {
            let url  = convertImageRowToURL(imageToConvert: image)
            tourReference.updateChildValues(["image_url" : url])
        }
        
        // creates specifically the tournament key in users
        let userReference = ref.child("users").child(uid).child("User_Tournament_Organizing")
        userReference.updateChildValues([tourReference.key : "Tournament_UID"])
        
    }
    
    // Team upload to gameship_teams
    class func uploadTeamsHandler (uid : String, values : [String : Any]) {
        
        let ref = Database.database().reference()
        let userReference = ref.child("users").child(uid).child("User_Teams")
        
        let teamReference = ref.child("GameShip_Teams").childByAutoId()
        teamReference.child(teamReference.key).setValue("Teams_For_GameShip")
        
        userReference.updateChildValues([teamReference.key : "key"])
        teamReference.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error)
                return
            }
        }
    }
    
    // MARK : Profile Handlers Related To FB
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
    
    // handles profile image only
    
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
                    FirebaseDataHandler.uploadToUserProfileHandler(uid: currentUserUID, values: ["user_image_url" : profileImageURL])
                }
            }
        }
    }
}
