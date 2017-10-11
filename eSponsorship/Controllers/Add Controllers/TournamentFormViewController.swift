//
//  TournamentFormViewController.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 05/10/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import Eureka
import ImageRow

class TournamentFormViewController: FormViewController{
    
    var tournaments : [Tournaments] = []
    var tournamentImage = ""
    
    
    let gameList = ["Street Fighter"]
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orgDetails()
        tournamentDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func orgDetails () {
        form +++ Section (header: "Organizer Details", footer: "")
            
            <<< NameRow () {
                $0.title = "Organizer Name"
                $0.tag = "org_name"
                $0.value = ""
                $0.placeholder = "Input Here"
            }
            
            <<< EmailRow () {
                $0.title = "Organizer Email"
                $0.tag = "org_email"
                $0.value = ""
                $0.placeholder = "Input Here"
                }.cellSetup({ (cell, _) in
                    cell.textField.keyboardType = .emailAddress
                })
            
            <<< NameRow () {
                $0.title = "Organizer Affliation"
                $0.tag = "org_aff"
                $0.value = ""
                $0.placeholder = "Input Here"
            }
            
            <<< TextRow() {
                $0.title = "Organizer Contact"
                $0.tag = "org_contact"
                $0.value = ""
                $0.placeholder = "6012345678"
                } .cellSetup({ (cell, _) in
                    cell.textField.keyboardType = .phonePad
                })
    }
    
    func tournamentDetails () {
        
        form +++ Section("Tournament Details")
            
            // MARK : IMAGE ROW
            <<< ImageRow () { row in
                row.tag = "tournament_image_url"
                row.title = "Tournament Image"
                row.value = nil
                row.sourceTypes = [ .PhotoLibrary, .SavedPhotosAlbum ]
                row.clearAction = .yes(style: UIAlertActionStyle.destructive)
                } .cellUpdate { cell, row in
                    cell.accessoryView?.layer.cornerRadius = 17
                    cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
                    
                }
                .onChange({ (row) in
                    
                })
            
            <<< TextRow() {
                $0.title = "Tournament Name"
                $0.tag = "tournament_name"
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
            
            <<< PushRow<String>() {
                $0.title = "Competing Game"
                $0.options = Constant.Data.gamesCompeting
                $0.value = Constant.Data.gamesCompeting[1]
                $0.tag = "competing_game"
                $0.selectorTitle = "Select a game competing"
                }.onPresent { from, to in
                    
            }
            
            <<< PushRow<String>() {
                $0.title = "Competitive Level"
                $0.tag = "competitive_level"
                $0.options = Constant.Data.competingLevel
                $0.value = Constant.Data.competingLevel[0]
                $0.selectorTitle = "Select Competing Level"
                }.onPresent { from, to in
                    
            }
            
            <<< TextRow () {
                $0.title = "Number of Participants"
                $0.tag = "number_participants"
                $0.value = ""
                $0.placeholder = "0"
                
            }
            
            <<< TextRow () {
                $0.title = "Prize Pool"
                $0.placeholder = "0"
                $0.tag = "prize_pool"
                $0.value = ""
            }
            
            <<< TextRow () {
                $0.title = "Tournament URL"
                $0.placeholder = "www.tournamentname.com"
                $0.tag = "tournament_url"
                $0.value = ""
                }.cellSetup({ (cell, _) in
                    cell.textField.keyboardType = .emailAddress
                })
        
        // MARK : Time of Tournament
        form +++ Section(header: "Time of Tournament", footer: "")
            
            <<< DateTimeInlineRow(){
                $0.title = "Start Time"
                $0.value = Date()
                $0.tag = "start_time"
            }
            
            <<< DateTimeInlineRow(){
                $0.title = "End Time"
                $0.value = Date()
                $0.tag = "end_time"
                
        }
        
        // MARK : Location of Tournament
        form +++ Section ("Location of Tournament")
            
            <<< TextRow() {
                $0.title = "Location Name"
                $0.tag = "location_name"
                $0.placeholder = "NEXT Academy"
                $0.value = ""
                
            }
            
            <<< TextRow() {
                $0.title = "Unit Number"
                $0.tag = "location_unit"
                $0.placeholder = "AG-7"
                $0.value = ""
            }
            
            <<< TextRow() {
                $0.title = "Street Name"
                $0.tag = "location_street"
                $0.placeholder = "Jalan Wan Kadir 1"
                $0.value = ""
            }
            <<< TextRow() {
                $0.title = "City"
                $0.tag = "location_city"
                $0.placeholder = "Taman Tun Dr Ismail"
                $0.value = ""
            }
            
            <<< PickerInlineRow <String> () { (row : PickerInlineRow<String>) -> Void in
                row.title = "State"
                row.tag = "location_state"
                row.options = Constant.Data.states
                row.value = Constant.Data.states[0]
                
            }
            
            <<< TextRow() {
                $0.title = "Country"
                $0.tag = "location_country"
                $0.placeholder = "Malaysia"
                $0.value = ""
            }
            
            +++ Section()
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "Save Tournament"
                }
                
                .onCellSelection { [weak self] (cell, row) in
                    
                    let alert = UIAlertController(title: "Saving Details", message: "Your details will be saved safely at GameShip", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Cancel", style: .cancel , handler: nil)
                    
                    let save = UIAlertAction(title: "Save", style: .default) { (action) in
                        
                        guard let currentUID = Auth.auth().currentUser?.uid else { return }
                        guard let tournamentData = self?.form.valuesForFirebase() else { return }
                        
                        FirebaseDataHandler.uploadTournamentHandler(uid: currentUID, values: tournamentData)
                        //                        let storyboardNew = UIStoryboard(name: "Home", bundle: nil)
                        //                        guard let vc = storyboardNew.instantiateViewController(withIdentifier: "TournamentsViewController") as? TournamentsViewController else {
                        //                            return
                        //                        }
                        //                        self?.present(vc, animated: true, completion: nil)
                        
                        
                        self?.dismiss(animated: true, completion: nil)
                    }
                    
                    alert.addAction(cancel)
                    alert.addAction(save)
                    self?.present(alert, animated: true, completion: nil)
        }
    }
}
