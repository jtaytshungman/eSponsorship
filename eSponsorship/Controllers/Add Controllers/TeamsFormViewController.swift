//
//  TeamsFormViewController.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 05/10/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import Eureka
import ImageRow

class TeamsFormViewController: FormViewController {
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamInfoForms()
    }
    
    func teamInfoForms () {
        form
            
            +++ Section(header: "Team Information", footer: "")
            
            <<< ImageRow () { row in
                row.title = "Team Image"
                row.sourceTypes = [ .PhotoLibrary, .SavedPhotosAlbum ]
                row.clearAction = .yes(style: UIAlertActionStyle.destructive)
                
                } .cellUpdate { cell, row in
                    cell.accessoryView?.layer.cornerRadius = 17
                    cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
            }
            
            <<< TextRow() {
                $0.title = "Team Name"
                $0.tag = "team_name"
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
            
            <<< PushRow <String> () {
                $0.title = "Competing Game"
                $0.options = ["Dota 2", "League of Legend", "Counter Strike : GO", "HeartStrone", "StarCraft"]
                $0.value = "Dota 2"
                $0.tag = "competing_game_team"
                $0.selectorTitle = "Select a game competing"
                }
                .onPresent { from, to in
                    
            }
            
            <<< PushRow <String> () {
                $0.title = "Competitive Level"
                $0.tag = "competitive_level_team"
                $0.options = ["Professional", "Amateur", "Open"]
                $0.value = "Open"
                $0.selectorTitle = "Select Competing Level"
                $0.tag = $0.title
                }.onPresent { from, to in
                    
            }
            
            // MARK : Location of Tournament
            +++ Section ("Where is your team based in?")
            
            <<< TextRow() {
                $0.title = "City"
                $0.tag = "location_city_team"
                $0.value = ""
                $0.placeholder = "Taman Tun Dr Ismail"
            }
            
            <<< TextRow() {
                $0.title = "State"
                $0.tag = "location_state_team"
                $0.value = ""
                $0.placeholder = "Selangor"
            }
            
            <<< TextRow() {
                $0.title = "Country"
                $0.tag = "location_country_team"
                $0.value = ""
                $0.placeholder = "Malaysia"
            }
            
            +++ Section(header: "Team mate information", footer: "A full team receives sponsorship more easily than one that is not.")
            
            <<< TextRow () {
                $0.title = "Number of Team members"
                $0.tag = "number_members"
                $0.value = ""
                }.cellSetup { cell, _  in
                    cell.textField.keyboardType = .numberPad
            }
        
            +++ MultivaluedSection( multivaluedOptions: [.Reorder, .Insert, .Delete],
                               header: "Add Team Members here",
                               footer: "") {
                                
                                $0.tag = "team_members"
                                
                                $0.addButtonProvider = { section in
                                    return ButtonRow(){
                                        $0.title = "Add Team Member"
                                        }.cellUpdate { cell, row in
                                            cell.textLabel?.textAlignment = .left
                                    }
                                }
                                
                                $0.multivaluedRowToInsertAt = { index in
                                    return TextRow() {
                                        $0.placeholder = "Member Name"
                                        $0.tag = "Member \(index)"
                                    }
                                }
                                
                                $0 <<< TextRow() {
                                    $0.placeholder = "Member Name"
                                }
                }
            
            +++ Section()
            <<< ButtonRow() { (row: ButtonRow) -> Void in
                row.title = "Submit Team To GameShip"
                }
                .onCellSelection { [weak self] (cell, row) in
                    let alert = UIAlertController(title: "Saving Details", message: "Your details will be saved safely at GameShip", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Cancel", style: .cancel , handler: nil)
                    let save = UIAlertAction(title: "Save", style: .default) { (action) in
                        
                        guard let teamEurekaData = self?.form.valuesForFirebase() else { return }
                        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
                        FirebaseDataHandler.uploadTeamsHandler(uid: currentUserID, values: teamEurekaData)
                        
                        self?.dismiss(animated: true, completion: nil)
                        
                    }
                    alert.addAction(cancel)
                    alert.addAction(save)
                    self?.present(alert, animated: true, completion: nil)
                    
        }
    }
    
    
}


