//
//  SummaryVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 10/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit
import Eureka

class SummaryVC: FormViewController {
    var selectedTank : Tank?
    let separator : String = " : "
    let dateFormatter = DateFormatter()
    override func viewWillAppear(_ animated: Bool) {
        //MARK: - Form - Summary Information
        //ADD RELOADING FORM DATA HERE!!!!!
        dateFormatter.dateFormat = "dd-MM, HH:mm"
        setupForm()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setupForm() {
        selectedTank = DataManager.selectedTank
        let expectedParams = selectedTank?.waterParams
        let lastParams = selectedTank?.lastParams()
        form
            +++ Section("Summary")
            <<< LabelRow() {
                $0.title = "Selected tank"
                $0.value = selectedTank?.name
            }
            <<< LabelRow() {
                $0.title = "Status"
                $0.value = "currentstatus"
                $0.tag = "status"
            }.cellUpdate {
                cell, row in
                if row.value != "OK" {
                    cell.textLabel?.textColor = .systemRed
                } else {
                    cell.textLabel?.textColor = .systemGreen
                }
            }
            <<< LabelRow() {
                $0.title = "Last measurement"
                $0.tag = "date_last"
                $0.value = dateFormatter.string(from: lastParams!.date!)
            }
            
            +++ Section("Temperature") {
                section in
                section.footer?.height = {12}
                section.header?.height = {12}
            }
            <<< LabelRow() {
                $0.title = "Expected"
                $0.tag = "temp_expected"
                $0.value = expectedParams!.tempComp() + " °C"
        }
            <<< LabelRow() {
                $0.title = "Last"
                $0.tag = "temp_last"
                $0.value = String(lastParams!.temp)
        }
        
            +++ Section("PH") {
                section in
                section.footer?.height = {12}
                section.header?.height = {12}
            }
            <<< LabelRow() {
                $0.title = "Expected"
                $0.tag = "ph_expected"
                $0.value = String(expectedParams!.phValue)
        }
            <<< LabelRow() {
                $0.title = "Last"
                $0.tag = "ph_last"
                $0.value = String(lastParams!.phValue)
        }
        
            +++ Section("GH") {
                section in
                section.footer?.height = {12}
                section.header?.height = {12}
        }
            <<< LabelRow() {
                $0.title = "Expected"
                $0.tag = "gh_expected"
                $0.value = String(expectedParams!.ghValue)
        }
            <<< LabelRow() {
                $0.title = "Last"
                $0.tag = "gh_last"
                $0.value = String(lastParams!.ghValue)
        }
        
            +++ Section("NO#") {
                section in
                section.footer?.height = {12}
                section.header?.height = {12}
        }
            <<< LabelRow() {
                $0.title = "NO2 Last"
                $0.tag = "no2_last"
                $0.value = String(lastParams!.no2Value)
        }
            <<< LabelRow() {
                $0.title = "NO3 Last"
                $0.tag = "no3_last"
                $0.value = String(lastParams!.no3Value)
        }
    }
    
}
