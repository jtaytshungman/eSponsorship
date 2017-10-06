//
//  UploadToFirebase.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 06/10/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

public class FirebaseDataHandler {
    
    // MARK : Universal Update function is here
    class func uploadDataToDatabaseWithUID (uid : String, values : [String : Any]) {
        let ref = Database.database().reference()
        
        let userReference = ref.child("users").child(uid).child("tournamentOrganizing")
        
        
        let tourReference = ref.child("tournaments").childByAutoId()
        tourReference.child(tourReference.key).setValue("TournamentsForGameShip")
        
        userReference.updateChildValues([tourReference.key : "key"])
        
        tourReference.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error)
                return
            }
        }
    }
}

