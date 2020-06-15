//
//  AddMeasurementVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 22/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit
import Eureka
import CoreData
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
    var tank: Tank?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
        self.saveBarButton.isEnabled = true
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
                //self.measurement?.date = (row.value)!
        }
            
            +++ Section("Water parameters") {
                section in
                section.footer?.height = {12}
                section.header?.height = {12}
        }
            <<< IntRow() {
                $0.title = VariableFormats.temp
                $0.tag = "temp"
                $0.add(rule: RuleRequired())
            }
            
            <<< DecimalRow() {
                $0.title = VariableFormats.ph
                $0.tag = "ph"
                $0.useFormatterOnDidBeginEditing = true
                $0.add(rule: RuleRequired())
            }
            
            <<< IntRow() {
                $0.title = VariableFormats.gh
                $0.tag = "gh"
                $0.add(rule: RuleRequired())
            }
            
            <<< IntRow() {
                $0.title = VariableFormats.kh
                $0.tag = "kh"
                $0.add(rule: RuleRequired())
            }
            
            <<< IntRow() {
                $0.title = VariableFormats.cl2
                $0.tag = "cl2"
                $0.add(rule: RuleRequired())
            }
            
            <<< IntRow() {
                $0.title = VariableFormats.no2
                $0.tag = "no2"
                $0.add(rule: RuleRequired())
            }
            
            <<< IntRow() {
                $0.title = VariableFormats.no3
                $0.tag = "no3"
                $0.add(rule: RuleRequired())
        }
            
        +++ Section("Notes") {
            section in
            section.footer?.height = {12}
            section.header?.height = {12}
        }
            <<< TextAreaRow() {
                $0.title = "Notes"
                $0.tag = "note"
                $0.placeholder = "Type additional notes..."
        }
        
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let values = form.values()
        let parameter = WaterParameter(context: context)
        
        parameter.temp = Int16(values["temp"] as! Int)
        parameter.phValue = values["ph"] as! Double
        parameter.ghValue = Int16(values["gh"] as! Int)
        parameter.khValue = Int16(values["kh"] as! Int)
        parameter.cl2Value = Int16(values["cl2"] as! Int)
        parameter.no2Value = Int16(values["no2"] as! Int)
        parameter.no3Value = Int16(values["no3"] as! Int)
        
        let measurement = Measurement(context: context)
        measurement.parameter = parameter
        measurement.note = values["note"] as? String
        measurement.date = Date();
        
        tank?.addToMeasurements(measurement)
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Couldn't save added measurement: \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
