//
//  EurekaAddTournamentsViewController.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 05/10/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import Eureka

class EurekaAddTournamentsViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orgContactInfo()
    }
    
}

extension EurekaAddTournamentsViewController {
    func orgContactInfo () {
        
        form +++
            Section (header: "Tournament Organizer", footer: "")
            
            <<< TextRow("Organizer Name").cellSetup { (cell, row) in
                cell.textField.placeholder = row.tag
            }
            <<< TextRow("Affliated Organization").cellSetup { (cell, row) in
                cell.textField.placeholder = row.tag
            }
            <<< TextRow("Organizer Email").cellSetup { (cell, row) in
                cell.textField.placeholder = row.tag
            }
            <<< TextRow("Organizer Contact").cellSetup { (cell, row) in
                cell.textField.placeholder = row.tag
            }
            <<< TextRow("Tournament Name").cellSetup { (cell, row) in
                cell.textField.placeholder = row.tag
            }
            
            +++
            SwitchRow("All-day") {
                $0.title = $0.tag
                }.onChange { [weak self] row in
                    let startDate: DateTimeInlineRow! = self?.form.rowBy(tag: "Starts")
                    let endDate: DateTimeInlineRow! = self?.form.rowBy(tag: "Ends")
                    
                    if row.value ?? false {
                        startDate.dateFormatter?.dateStyle = .medium
                        startDate.dateFormatter?.timeStyle = .none
                        endDate.dateFormatter?.dateStyle = .medium
                        endDate.dateFormatter?.timeStyle = .none
                    }
                    else {
                        startDate.dateFormatter?.dateStyle = .short
                        startDate.dateFormatter?.timeStyle = .short
                        endDate.dateFormatter?.dateStyle = .short
                        endDate.dateFormatter?.timeStyle = .short
                    }
                    startDate.updateCell()
                    endDate.updateCell()
                    startDate.inlineRow?.updateCell()
                    endDate.inlineRow?.updateCell()
            }
            
            <<< DateTimeInlineRow("Starts") {
                $0.title = $0.tag
                $0.value = Date().addingTimeInterval(60*60*24)
                }
                .onChange { [weak self] row in
                    let endRow: DateTimeInlineRow! = self?.form.rowBy(tag: "Ends")
                    if row.value?.compare(endRow.value!) == .orderedDescending {
                        endRow.value = Date(timeInterval: 60*60*24, since: row.value!)
                        endRow.cell!.backgroundColor = .white
                        endRow.updateCell()
                    }
                }
                .onExpandInlineRow { [weak self] cell, row, inlineRow in
                    inlineRow.cellUpdate() { cell, row in
                        let allRow: SwitchRow! = self?.form.rowBy(tag: "All-day")
                        if allRow.value ?? false {
                            cell.datePicker.datePickerMode = .date
                        }
                        else {
                            cell.datePicker.datePickerMode = .dateAndTime
                        }
                    }
                    let color = cell.detailTextLabel?.textColor
                    row.onCollapseInlineRow { cell, _, _ in
                        cell.detailTextLabel?.textColor = color
                    }
                    cell.detailTextLabel?.textColor = cell.tintColor
            }
            
            <<< DateTimeInlineRow("Ends"){
                $0.title = $0.tag
                $0.value = Date().addingTimeInterval(60*60*25)
                }
                .onChange { [weak self] row in
                    let startRow: DateTimeInlineRow! = self?.form.rowBy(tag: "Starts")
                    if row.value?.compare(startRow.value!) == .orderedAscending {
                        row.cell!.backgroundColor = .red
                    }
                    else{
                        row.cell!.backgroundColor = .white
                    }
                    row.updateCell()
                }
                .onExpandInlineRow { [weak self] cell, row, inlineRow in
                    inlineRow.cellUpdate { cell, dateRow in
                        let allRow: SwitchRow! = self?.form.rowBy(tag: "All-day")
                        if allRow.value ?? false {
                            cell.datePicker.datePickerMode = .date
                        }
                        else {
                            cell.datePicker.datePickerMode = .dateAndTime
                        }
                    }
                    let color = cell.detailTextLabel?.textColor
                    row.onCollapseInlineRow { cell, _, _ in
                        cell.detailTextLabel?.textColor = color
                    }
                    cell.detailTextLabel?.textColor = cell.tintColor
            }
            
            +++
            Section(header: "Tournament Location", footer: "")
            
            <<< TextRow() {
                $0.title = "Location Name"
                $0.placeholder = "NEXT Academy"
            }
            
            <<< TextRow() {
                $0.title = "Unit Number"
                $0.placeholder = "AG-7"
            }
            
            <<< TextRow() {
                $0.title = "Street Name"
                $0.placeholder = "Jalan Wan Kadir 1"
            }
            <<< TextRow() {
                $0.title = "City"
                $0.placeholder = "Taman Tun Dr Ismail"
            }
            
            <<< TextRow() {
                $0.title = "State"
                $0.placeholder = "Selangor"
            }
            
            <<< TextRow() {
                $0.title = "Country"
                $0.placeholder = "Malaysia"
            }
            
            +++
            Section (header: "Tournament Details", footer: "")
        
            <<< TextRow() {
                $0.title = "Tournament Name"
                $0.placeholder = "Battle Of NEXT Map"
        }

            <<< PushRow<String>() {
                $0.title = "Competing Game"
                $0.options = ["Dota 2", "League of Legend", "Counter Strike : GO", "HeartStrone", "StarCraft"]
                $0.value = "Dota 2"
                $0.selectorTitle = "Select a game competing"
                }.onPresent { from, to in
                    to.dismissOnSelection = true
                    to.dismissOnChange = true
        }
        
    }
    
}
