//
//  MeasurementsVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 18/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit
import Eureka
import TableRow

/*
Loggable parameters:
   - temperature
   - pH value
   - GH value °d
   - KH value °d
   - Cl2 value mg/l
   - NO2 value mg/l
   - NO3 value mg/l
   - Date of measurements
*/

class MeasurementsVC: FormViewController {
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
        // Do any additional setup after loading the view.
    }
    
    func setupForm() {
        let lastMeasurement = DataManager.selectedTank?.lastMeasurement()
        form
        +++ Section("Select measurement")
            <<< TableInlineRow<String> { row in
                row.options = ["1", "2", "3"]
                row.value = "none"
        }
        +++ Section("Measured values:") {
                    section in
                    section.footer?.height = {12}
                    section.header?.height = {12}
               }
            <<< LabelRow() {
                $0.title = VariableFormats.temp
                $0.value = String(lastMeasurement!.waterParams.temp)
        }
            <<< LabelRow() {
                $0.title = VariableFormats.ph
                $0.value = String(lastMeasurement!.waterParams.phValue)
        }
            <<< LabelRow() {
                $0.title = VariableFormats.gh
                $0.value = String(lastMeasurement!.waterParams.ghValue)
        }
            <<< LabelRow() {
                $0.title = VariableFormats.kh
                $0.value = String(lastMeasurement!.waterParams.khValue)
        }
            <<< LabelRow() {
                $0.title = VariableFormats.cl2
                $0.value = String(lastMeasurement!.waterParams.cl2Value)
        }
            <<< LabelRow() {
                $0.title = VariableFormats.no2
                $0.value = String(lastMeasurement!.waterParams.no2Value)
        }
            <<< LabelRow() {
                $0.title = VariableFormats.no3
                $0.value = String(lastMeasurement!.waterParams.no3Value)
        }
        +++ Section("Notes") {
                    section in
                    section.footer?.height = {12}
                    section.header?.height = {12}
            }
            <<< TextAreaRow() {
                $0.title = VariableFormats.notes
                $0.textAreaMode = .readOnly
                $0.value = lastMeasurement?.note
        }
    }
    
    @IBAction func unwindToMeasurements(sender: UIStoryboardSegue) {
        if let sourceVC = sender.source as? AddMeasurementVC, let newMeasurement = sourceVC.measurement {
            
        }
    }
}
