//
//  EditProfileFormViewController.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 07/10/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import Eureka
import ImageRow
import Firebase
import FirebaseAuth
import FirebaseDatabase

class EditProfileFormViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editProfileFormHandler()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func editProfileFormHandler () {
        form
            +++ Section(header: "Edit Profile", footer: "")
            
            <<< ImageRow () { row in
                row.title = "Select A Profile Image"
                row.tag = "user_image_url"
                row.value = nil
                row.sourceTypes = [ .PhotoLibrary, .SavedPhotosAlbum ]
                row.clearAction = .yes(style: UIAlertActionStyle.destructive)
                
                } .cellUpdate { cell, row in
                    cell.accessoryView?.layer.cornerRadius = 17
                    cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
                    
            }
            
            <<< NameRow() {
                $0.title = "User Name"
                $0.tag = "user_name"
                $0.placeholder = "Example"
                $0.value = ""
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
                .onRowValidationChanged { cell, row in
                    let rowIndex = row.indexPath!.row
                    while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
                        row.section?.remove(at: rowIndex + 1)
                    }
                    if !row.isValid {
                        for (index, validationMsg) in row.validationErrors.map({ $0.msg }).enumerated() {
                            let labelRow = LabelRow() {
                                $0.title = validationMsg
                                $0.cell.height = { 30 }
                            }
                            row.section?.insert(labelRow, at: row.indexPath!.row + index + 1)
                        }
                    }
            }
            
            <<< PickerInlineRow <String> () { (row : PickerInlineRow<String>) -> Void in
                row.title = "Based Location"
                row.tag = "user_location_based"
                row.options = Constant.Data.states
                row.value = ""
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                
            }
            
            
            +++ Section ()
            <<< TextAreaRow () {
                $0.title = "Player Biography"
                $0.placeholder = "Show something about yourself."
                $0.tag = "user_bio_desc"
            }
            
            
            +++ Section (header: "Social Media Presence", footer: "Link your relevant streaming accounts to attact sponsorships. The more media you stream, the higher chance of getting sponsored.")
            
            <<< TextRow(){
                $0.title = "Twitch"
                $0.tag = "user_twitch_url"
                $0.value = "https://www.twitch.com/"
                }.cellSetup({ (cell, _) in
                    cell.textField.keyboardType = .URL
                })
            
            <<< TextRow(){
                $0.title = "Youtube"
                $0.tag = "user_youtube_url"
                $0.value = "https://www.youtube.com/"
                }.cellSetup({ (cell, _) in
                    cell.textField.keyboardType = .URL
                })
            
            <<< TextRow(){
                $0.title = "Facebook"
                $0.tag = "user_facebook_url"
                $0.value = "https://www.facebook.com/"
                }.cellSetup({ (cell, _) in
                    cell.textField.keyboardType = .URL
                })
            
            <<< TextRow(){
                $0.title = "Others"
                $0.tag = "user_others_url"
                $0.value = "https://"
                }.cellSetup({ (cell, _) in
                    cell.textField.keyboardType = .URL
                })
            
            // MARK : Selecting Games and Competing Level
            
            +++ Section (
                header: "Competing Game & Levels",
                footer: "Choose your three most played games.\nProfessional Level - Played in professional team in professionally recognized tournaments.\nAmatuer Level - Played in amatuer / casual tournaments.\nCasual Level - Plays casually for fun.\nStreamer - Plays the game while streaming live, not neccessarily professionally.")
            
            +++ Section ("Game 1")
            <<< PickerInlineRow <String> () { (row : PickerInlineRow<String>) -> Void in
                row.title = "Game 1"
                row.tag = "user_GameChoice_1"
                row.options = Constant.Data.gamesCompeting
                row.value = ""
                
            }
            
            <<< PickerInlineRow <String> () { (row : PickerInlineRow<String>) -> Void in
                row.title = "Competing Level"
                row.tag = "user_GameChoice_1_level"
                row.options = Constant.Data.competingLevel
                row.value = ""
                
            }
            
            +++ Section ("Game 2")
            <<< PickerInlineRow <String> () { (row : PickerInlineRow<String>) -> Void in
                row.title = "Game 2"
                row.tag = "user_GameChoice_2"
                row.options = Constant.Data.gamesCompeting
                row.value = ""
                
            }
            
            <<< PickerInlineRow <String> () { (row : PickerInlineRow<String>) -> Void in
                row.title = "Competing Level"
                row.tag = "user_GameChoice_2_level"
                row.options = Constant.Data.competingLevel
                row.value = ""
                
            }
            
            +++ Section ("Game 3")
            <<< PickerInlineRow <String> ("Game 3") { (row : PickerInlineRow<String>) -> Void in
                row.title = "Game 3"
                row.tag = "user_GameChoice_3"
                row.options = Constant.Data.gamesCompeting
                row.value = ""
                
            }
            <<< PickerInlineRow <String> () { (row : PickerInlineRow<String>) -> Void in
                row.title = "Competing Level"
                row.tag = "user_GameChoice_3_level"
                row.options = Constant.Data.competingLevel
                row.value = ""
                
            }
            
            +++ Section ()
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "Save Profile"
                }
                .onCellSelection { [weak self] (cell, row) in
                    let alert = UIAlertController(title: "Saving Details", message: "Your details will be saved safely at GameShip", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Cancel", style: .cancel , handler: nil)
                    let save = UIAlertAction(title: "Save", style: .default) { (action) in
                        
                        guard let editProfileEurekaData = self?.form.valuesForFirebase() else { return }
                        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
                        let ref = Database.database().reference()
                        let userReference = ref.child("users").child(currentUserID)
                        
                        FirebaseDataHandler.uploadToUserProfileHandler(uid: currentUserID, values: editProfileEurekaData)
                        
                        
                        
                        self?.dismiss(animated: true, completion: nil)
                        
                    }
                    alert.addAction(cancel)
                    alert.addAction(save)
                    self?.present(alert, animated: true, completion: nil)
        }
    }
    
}



