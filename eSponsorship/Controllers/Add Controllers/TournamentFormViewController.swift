//
//  TournamentFormViewController.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 05/10/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit
import Eureka

class TournamentFormViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        orgDetails()
        tournamentDate()
        tournamentDetails()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func orgDetails () {
        form +++ Section (header: "Organizer Details", footer: "")
            
            <<< TextRow("Organizer Name").cellSetup { (cell, row) in
                cell.textField.placeholder = row.tag
            }
            
            <<< TextRow("Affliated Organization").cellSetup { (cell, row) in
                cell.textField.placeholder = row.tag
            }
            
            <<< TextRow("Organizer Email").cellSetup { (cell, row) in
                cell.textField.placeholder = row.tag
            }
            
            <<< IntRow() {
                $0.title = "Organizer Contact"
                $0.placeholder = "6012345678"
            }
    }
    
    func tournamentDate () {
        form +++ Section(header: "Location of Tournament", footer: "")
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
    }
    
    func tournamentDetails () {
        form
            +++ Section()
            
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
                    
            }
            
            <<< PushRow<String>() {
                $0.title = "Competitive Level"
                $0.options = ["Professional", "Amateur", "Open"]
                $0.value = "Open"
                $0.selectorTitle = "Select Competing Level"
                }.onPresent { from, to in
                    
            }
            
            <<< IntRow () {
                $0.title = "Prize Pool"
                $0.placeholder = "999"
            }
            
            <<< URLRow () {
                $0.title = "Tournament URL"
                $0.placeholder = "www.tournamentname.com"
            }
            
            +++ Section(header: "Date of Tournament", footer: "")
            
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
            
            +++ Section ("Location of Tournament")
            
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
            
        
        
    }

}
