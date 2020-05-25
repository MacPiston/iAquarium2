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
    var tank: Tank?
    
    override func viewWillAppear(_ animated: Bool) {
        
        updateFormValues()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
        // Do any additional setup after loading the view.
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
                //$0.value = String(lastMeasurement!.waterParams.temp)
        }
            <<< LabelRow() {
                $0.title = VariableFormats.ph
                $0.tag = "ph"
                //$0.value = String(lastMeasurement!.waterParams.phValue)
        }
            <<< LabelRow() {
                $0.title = VariableFormats.gh
                $0.tag = "gh"
                //$0.value = String(lastMeasurement!.waterParams.ghValue)
        }
            <<< LabelRow() {
                $0.title = VariableFormats.kh
                $0.tag = "kh"
                //$0.value = String(lastMeasurement!.waterParams.khValue)
        }
            <<< LabelRow() {
                $0.title = VariableFormats.cl2
                $0.tag = "cl2"
                //$0.value = String(lastMeasurement!.waterParams.cl2Value)
        }
            <<< LabelRow() {
                $0.title = VariableFormats.no2
                $0.tag = "no2"
                //$0.value = String(lastMeasurement!.waterParams.no2Value)
        }
            <<< LabelRow() {
                $0.title = VariableFormats.no3
                $0.tag = "no3"
                //$0.value = String(lastMeasurement!.waterParams.no3Value)
        }
        +++ Section("Notes") {
                    section in
                    section.footer?.height = {12}
                    section.header?.height = {12}
            }
            <<< TextAreaRow() {
                $0.title = VariableFormats.notes
                $0.tag = "notes"
                $0.textAreaMode = .readOnly
                //$0.value = lastMeasurement?.note
        }
    }
    
    func updateFormValues() {
        
    }
    
    @IBAction func unwindToMeasurements(sender: UIStoryboardSegue) {

    }
}
