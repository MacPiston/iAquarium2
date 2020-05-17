//
//  SummaryVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 10/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//
import UIKit
import Eureka
import SplitRow

class SummaryVC: FormViewController {
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }
    
    func setupForm() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM, HH:mm"

        form
            +++ Section("Summary")
            <<< LabelRow() {
                $0.title = "Selected tank"
                //$0.value = selectedTank?.name
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
                //$0.value = dateFormatter.string(from: lastMeasurement!.date)
            }
            
            +++ Section("Temperature") {
                section in
                section.footer?.height = {15}
                section.header?.height = {15}
            }
            <<< SplitRow<LabelRow, LabelRow>() {
                $0.rowLeftPercentage = 0.5
                $0.rowLeft = LabelRow() {
                    $0.title = "Expected"
                    $0.tag = "temp_expected"
                    //$0.value = expectedParams!.tempComp() + " °C"
                }
                $0.rowRight = LabelRow() {
                    $0.title = "Last"
                    $0.tag = "temp_last"
                    //$0.value = String(lastMeasurement!.waterParams.temp)
                }
            }
            +++ Section("PH") {
                section in
                section.footer?.height = {15}
                section.header?.height = {15}
        }
            <<< SplitRow<LabelRow, LabelRow>() {
                $0.rowLeftPercentage = 0.5
                $0.rowLeft = LabelRow() {
                    $0.title = "Expected"
                    $0.tag = "ph_expected"
                    //$0.value = String(expectedParams!.phValue)
                }
                $0.rowRight = LabelRow() {
                    $0.title = "Last"
                    $0.tag = "ph_last"
                    //$0.value = String(lastMeasurement!.waterParams.phValue)
                }
            }
            +++ Section("GH") {
                section in
                section.footer?.height = {15}
                section.header?.height = {15}
        }
            <<< SplitRow<LabelRow, LabelRow>() {
                $0.rowLeftPercentage = 0.5
                $0.rowLeft = LabelRow() {
                    $0.title = "Expected"
                    $0.tag = "gh_expected"
                    //$0.value = String(expectedParams!.ghValue)
                }
                $0.rowRight = LabelRow() {
                    $0.title = "Last"
                    $0.tag = "gh_last"
                    //$0.value = String(lastMeasurement!.waterParams.ghValue)
                }
            }        
            +++ Section("NO#") {
                section in
                section.footer?.height = {15}
                section.header?.height = {15}
        }
            <<< SplitRow<LabelRow, LabelRow>() {
                $0.rowLeftPercentage = 0.5
                $0.rowLeft = LabelRow() {
                    $0.title = "NO2 Last"
                    $0.tag = "no2_last"
                    //$0.value = String(lastMeasurement!.waterParams.no2Value)
                }
                $0.rowRight = LabelRow() {
                    $0.title = "NO3 Last"
                    $0.tag = "no3_last"
                    //$0.value = String(lastMeasurement!.waterParams.no3Value)
                }
            }
    }
    
}
