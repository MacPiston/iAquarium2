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
        let expectedParams = selectedTank?.waterParams
        let lastParams = selectedTank?.lastParams()
        form
            +++ Section("Parameters expected/last: ")
            <<< LabelRow() {
                $0.title = "Temperature"
                $0.tag = "par_temp"
                $0.value = (expectedParams?.tempComp())! + separator + String((lastParams?.temp)!) + " °C"
        }
            <<< LabelRow() {
                $0.title = "Cl2"
                $0.tag = "par_cl2"
                $0.value = String((lastParams?.cl2Value)!) + "mg/l"
        }
            <<< LabelRow() {
                $0.title = "pH"
                $0.tag = "par_ph"
                $0.value = String((expectedParams?.phValue)!) + separator + String((lastParams?.phValue)!)
        }
            <<< LabelRow() {
                $0.title = "KH"
                $0.tag = "par_kh"
                $0.value = String((lastParams?.khValue)!) + " °d"
        }
            <<< LabelRow() {
                $0.title = "GH"
                $0.tag = "par_gh"
                $0.value = String((expectedParams?.ghValue)!) + separator + String((lastParams?.ghValue)!) + " °d"
        }
            <<< LabelRow() {
                $0.title = "NO2"
                $0.tag = "par_no2"
                $0.value = String((lastParams?.no2Value)!) + " mg/l"
        }
            <<< LabelRow() {
                $0.title = "NO3"
                $0.tag = "par_no3"
                $0.value = String((lastParams?.no3Value)!) + " mg/l"
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
