//
//  AddMeasurementVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 22/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit
import Eureka
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
class AddMeasurementVC: FormViewController {
    //MARK: - Setup
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    var measurement : Measurement?
    var cellsValidity : [Bool] = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
        self.saveBarButton.isEnabled = false
    }
    //MARK: - Form
    func setupForm() {
        form.inlineRowHideOptions = InlineRowHideOptions.AnotherInlineRowIsShown.union(.FirstResponderChanges)
        form
            +++ Section() {
                section in
                section.footer?.height = {12}
                section.header?.height = {12}
        }
            <<< DateTimeInlineRow() {
                $0.title = "Date of Measurement"
                $0.value = Date()
                $0.tag = "date"
                $0.add(rule: RuleRequired())
        }.onChange { row in
                self.measurement?.date = (row.value)!
        }
            
            +++ Section("Water parameters") {
                section in
                section.footer?.height = {12}
                section.header?.height = {12}
        }
            <<< IntRow() {
                $0.title = VariableFormats.temp
                $0.tag = "temperature"
                $0.add(rule: RuleRequired())
            }.onChange { row in
                if ((row.value)! > 0 && row.isValid) {
                    self.measurement?.waterParams.temp = (row.value)!
                    self.cellsValidity[0] = true
                    self.checkCellsValidity()
                } else {
                    self.cellsValidity[0] = false
                    self.checkCellsValidity()
                }
            }
            <<< DecimalRow() {
                $0.title = VariableFormats.ph
                $0.tag = "ph"
                $0.useFormatterOnDidBeginEditing = true
                $0.add(rule: RuleRequired())
            }.onChange { row in
                if ((row.value)! > 0 && row.isValid){
                    self.measurement?.waterParams.phValue = (row.value)!
                    self.cellsValidity[1] = true
                    self.checkCellsValidity()
                } else {
                    self.cellsValidity[1] = false
                    self.checkCellsValidity()
                }
            }
            <<< IntRow() {
                $0.title = VariableFormats.gh
                $0.tag = "gh"
                $0.add(rule: RuleRequired())
            }.onChange { row in
                if ((row.value)! > 0 && row.isValid) {
                    self.measurement?.waterParams.ghValue = (row.value)!
                    self.cellsValidity[2] = true
                    self.checkCellsValidity()
                } else {
                    self.cellsValidity[2] = false
                    self.checkCellsValidity()
                }
            }
            <<< IntRow() {
                $0.title = VariableFormats.kh
                $0.tag = "kh"
                $0.add(rule: RuleRequired())
            }.onChange { row in
                if ((row.value)! > 0 && row.isValid) {
                    self.measurement?.waterParams.khValue = (row.value)!
                    self.cellsValidity[3] = true
                    self.checkCellsValidity()
                } else {
                    self.cellsValidity[3] = false
                    self.checkCellsValidity()
                }
            }
            <<< IntRow() {
                $0.title = VariableFormats.cl2
                $0.tag = "cl2"
                $0.add(rule: RuleRequired())
            }.onChange { row in
                if ((row.value)! > 0 && row.isValid) {
                    self.measurement?.waterParams.khValue = (row.value)!
                    self.cellsValidity[4] = true
                    self.checkCellsValidity()
                } else {
                    self.cellsValidity[4] = false
                    self.checkCellsValidity()
                }
            }
            <<< IntRow() {
                $0.title = VariableFormats.no2
                $0.tag = "no2"
                $0.add(rule: RuleRequired())
            }.onChange { row in
                if ((row.value)! > 0 && row.isValid) {
                    self.measurement?.waterParams.no2Value = (row.value)!
                    self.cellsValidity[5] = true
                    self.checkCellsValidity()
                } else {
                    self.cellsValidity[5] = false
                    self.checkCellsValidity()
                }
            }
            <<< IntRow() {
                $0.title = VariableFormats.no3
                $0.tag = "no3"
                $0.add(rule: RuleRequired())
        }.onChange { row in
            if ((row.value)! > 0 && row.isValid) {
                self.measurement?.waterParams.no3Value = (row.value)!
                self.cellsValidity[6] = true
                self.checkCellsValidity()
            } else {
                self.cellsValidity[6] = false
                self.checkCellsValidity()
            }
        }
        +++ Section("Notes") {
            section in
            section.footer?.height = {12}
            section.header?.height = {12}
        }
            <<< TextAreaRow() {
                $0.title = "Notes"
                $0.tag = "notes"
                $0.placeholder = "Type additional notes..."
        }
        
    }
    
    func checkCellsValidity() {
        if cellsValidity[0...6] == [true] {
            self.saveBarButton.isEnabled = true
        } else {
            self.saveBarButton.isEnabled = false
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
