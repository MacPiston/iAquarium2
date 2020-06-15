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

class MeasurementsVC: FormViewController, passTank {
    var tank: Tank?
    var measurements: Set<Measurement>?
    var selectedMeasurement: Measurement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }
    
    func finishPassing(selectedTank: Tank) {
        self.tank = selectedTank
        self.measurements = self.tank?.measurements
        self.selectedMeasurement = self.measurements?.first
    }
    
    func setupForm() {
        form
        +++ Section("Select measurement")
            <<< PushRow<Measurement> {
                $0.title = "Mesaurement"
                $0.tag = "measurement_picker"
                $0.selectorTitle = "Pick a measurement"
                
        }
        +++ Section("Measured values:") {
                    section in
                    section.footer?.height = {12}
                    section.header?.height = {12}
               }
            <<< LabelRow() {
                $0.title = VariableFormats.temp
                $0.tag = "temp"
        }
            <<< LabelRow() {
                $0.title = VariableFormats.ph
                $0.tag = "ph"
        }
            <<< LabelRow() {
                $0.title = VariableFormats.gh
                $0.tag = "gh"
        }
            <<< LabelRow() {
                $0.title = VariableFormats.kh
                $0.tag = "kh"
        }
            <<< LabelRow() {
                $0.title = VariableFormats.cl2
                $0.tag = "cl2"
        }
            <<< LabelRow() {
                $0.title = VariableFormats.no2
                $0.tag = "no2"
        }
            <<< LabelRow() {
                $0.title = VariableFormats.no3
                $0.tag = "no3"
        }
        +++ Section("Notes") {
                    section in
                    section.footer?.height = {12}
                    section.header?.height = {12}
            }
            <<< TextAreaRow() {
                $0.title = VariableFormats.notes
                $0.tag = "note"
                $0.textAreaMode = .readOnly
        }
    }
    
    func updateFormValues() {
        (form.rowBy(tag: "temp") as! LabelRow).value = selectedMeasurement?.parameter?.temp.description
        (form.rowBy(tag: "ph") as! LabelRow).value = selectedMeasurement?.parameter?.phValue.description
        (form.rowBy(tag: "note") as! TextAreaRow).value = selectedMeasurement?.note
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "showAddMeasurement"  {
            if let destinationNC = segue.destination as? UINavigationController {
                if let destinationVC = destinationNC.viewControllers[0] as? AddMeasurementVC {
                    print("Measurements - passing: \(self.tank?.name)")
                    destinationVC.tank = self.tank
                }
            }
        }
    }
    
    @IBAction func unwindToMeasurements(sender: UIStoryboardSegue) {

    }
}
