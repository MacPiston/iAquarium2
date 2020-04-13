//
//  SecondViewController.swift
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
    override func viewWillAppear(_ animated: Bool) {
        //MARK: - Form - Summary Information
        //ADD RELOADING FORM DATA HERE!!!!!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupForm()
    }
    
    func setupForm() {
        selectedTank = DataManager.selectedTank
        let waterParams = selectedTank?.waterParams
        form
            +++ Section("Parameters expected/last: ")
            <<< LabelRow() {
                $0.title = "Temperature"
                $0.tag = "par_temp"
                $0.value = (waterParams?.returnTempComp())! + separator + String((selectedTank?.lastParams().temp)!) + " °C"
        }
            <<< LabelRow() {
                $0.title = "Cl2"
                $0.tag = "par_cl2"
                $0.value = String((waterParams?.cl2Value)!) + separator + String((selectedTank?.lastParams().cl2Value)!) + "mg/l"
        }
            <<< LabelRow() {
                $0.title = "pH"
                $0.tag = "par_ph"
                $0.value = String((waterParams?.phValue)!) + separator + String((selectedTank?.lastParams().phValue)!)
        }
            <<< LabelRow() {
                $0.title = "KH"
                $0.tag = "par_kh"
                $0.value = String((waterParams?.khValue)!) + separator + String((selectedTank?.lastParams().khValue)!) + " °d"
        }
            <<< LabelRow() {
                $0.title = "GH"
                $0.tag = "par_gh"
                $0.value = String((waterParams?.ghValue)!) + separator + String((selectedTank?.lastParams().ghValue)!) + " °d"
        }
            <<< LabelRow() {
                $0.title = "NO2"
                $0.tag = "par_no2"
                $0.value = String((waterParams?.no2Value)!) + separator + String((selectedTank?.lastParams().no2Value)!) + " mg/l"
        }
            <<< LabelRow() {
                $0.title = "NO3"
                $0.tag = "par_no3"
                $0.value = String((waterParams?.no3Value)!) + separator + String((selectedTank?.lastParams().no3Value)!) + " mg/l"
        }
        
        +++ Section("Creatures info:")
            <<< LabelRow() {
                $0.title = "Conflicts: "
                $0.tag = "cr_conflicts"
                $0.value = "conflicts_val"
            }.cellUpdate {
                cell, row in
                if row.value != "0" {
                    cell.textLabel?.textColor = .red
                }
            }
            <<< LabelRow() {
                $0.title = "Current amount: "
                $0.tag = "cr_amount"
                $0.value = "0"
        }
    }
    
}
