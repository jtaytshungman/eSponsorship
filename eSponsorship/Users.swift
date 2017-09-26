import Foundation
import UIKit

class Users {
    var userName : String = ""
    var description : String = ""
    var imageAccount : UIImage = UIImage(named: "") ?? UIImage()
    
    init() {
        
    }
    init(userName : String, description : String, imageAccount : String){
        self.userName = userName
        self.description = description
        if let imageAccount = UIImage(named: imageAccount) {
            self.imageAccount = imageAccount
        }
    }
    
}

