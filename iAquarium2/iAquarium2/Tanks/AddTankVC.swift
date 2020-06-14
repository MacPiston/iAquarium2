//
//  AddTankVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 10/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit
import Eureka
import ImageRow
import os.log
import CoreData

class AddTankVC: FormViewController {

    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationOptions = RowNavigationOptions.Disabled
        let manualCondition = Condition.function(["calculation"], { form in
            if (((form.rowBy(tag: "calculation") as? SegmentedRow<String>)?.value) == "Manual") {
                return false
            } else {
                return true
            }
        })
        
    // MARK: - Form
        // Basic Information
        form +++ Section("Tank information")
            <<< TextRow() {
                $0.title = "Tank Name"
                $0.placeholder = "Name..."
                $0.tag = "name"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
            }.cellUpdate {
                cell, row in
                self.checkValidity()
            }
            <<< TextRow() {
                $0.title = "Tank Brand"
                $0.placeholder = "Brand..."
                $0.tag = "brand"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
        }.cellUpdate {
                cell, row in
                self.checkValidity()
        }
        
            <<< ImageRow() {
                $0.title = "Tank Image"
                $0.tag = "image"
                $0.sourceTypes = [.PhotoLibrary, .SavedPhotosAlbum]
                $0.clearAction = .yes(style: .default)
                $0.allowEditor = false
        }
            
            <<< IntRow() {
                    $0.title = "Tank Capacity"
                    $0.placeholder = "Capacity..."
                    $0.add(rule: RuleGreaterThan(min: 0))
                    $0.add(rule: RuleRequired())
                    $0.validationOptions = .validatesOnChange
                    $0.tag = "capacity"
        }
                .cellUpdate {
                    cell, row in
                    self.checkValidity()
        }

            <<< SegmentedRow<String>() {
                $0.title = "Water Type"
                $0.options = ["Normal", "Salty"]
                $0.value = "Normal"
                $0.tag = "watertype"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
        }
            <<< IntRow() {
                $0.title = "Salt g/L"
                $0.tag = "salt"
                $0.hidden = Condition.function(["watertype"], {
                    form in
                    return !((form.rowBy(tag: "watertype") as? SegmentedRow)?.value == "Salty")
                })
        }

        //PARAMETERS
        +++ Section("Parameters")
            <<< SegmentedRow<String>() {
                    $0.title = "Parameters calculation"
                    $0.options = ["Auto", "Manual"]
                    $0.value = "Auto"
                    $0.tag = "calculation"
            }.onChange {
                row in
                if let paramSection = self.form.sectionBy(tag: "Parameters") {
                    if (self.form.rowBy(tag: "calculation") as? SegmentedRow<String>)?.value == "Manual" {
                        paramSection.hidden = false
                        paramSection.evaluateHidden()
                    } else {
                        paramSection.hidden = true
                        paramSection.evaluateHidden()
                    }
                }
            }
            
            <<< IntRow() {
                $0.title = "Maximum temp. [°C]"
                $0.tag = "maxtemp"
                $0.hidden = manualCondition
                $0.add(rule: RuleGreaterThan(min: 0))
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
        }.cellUpdate {
            cell, row in
            self.checkValidity()
        }
            
            <<< IntRow() {
                $0.title = "Minimum temp. [°C]"
                $0.tag = "mintemp"
                $0.hidden = manualCondition
                $0.add(rule: RuleGreaterThan(min: 0))
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
        }.cellUpdate {
            cell, row in
            self.checkValidity()
        }
            
            <<< DecimalRow() {
                $0.title = "pH"
                $0.tag = "ph"
                $0.hidden = manualCondition
                $0.useFormatterOnDidBeginEditing = true
                $0.add(rule: RuleGreaterOrEqualThan(min: 1))
                $0.add(rule: RuleSmallerOrEqualThan(max: 14))
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
        }.cellUpdate {
            cell, row in
            self.checkValidity()
        }
            
            <<< IntRow() {
                $0.title = "GH (General Hardness) [°d]"
                $0.tag = "gh"
                $0.hidden = manualCondition
                $0.add(rule: RuleGreaterOrEqualThan(min: 1))
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
        }
    }
    
    func checkValidity() {
        let name = (self.form.rowBy(tag: "name") as? TextRow)?.isValid
        let brand = (self.form.rowBy(tag: "brand") as? TextRow)?.isValid
        let capacity = (self.form.rowBy(tag: "capacity") as? IntRow)?.isValid
        let watertype = (self.form.rowBy(tag: "watertype") as? SegmentedRow<String>)?.isValid
        let maxtemp = (self.form.rowBy(tag: "maxtemp") as? IntRow)?.isValid
        let mintemp = (self.form.rowBy(tag: "mintemp") as? IntRow)?.isValid
        let ph = (self.form.rowBy(tag: "ph") as? DecimalRow)?.isValid
        let gh = (self.form.rowBy(tag: "gh") as? IntRow)?.isValid
        
        if (name == true && brand == true && capacity == true && watertype == true && maxtemp == true && mintemp == true && ph == true && gh == true) {
            self.saveBarButton.isEnabled = true
        } else {
            self.saveBarButton.isEnabled = false
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveBarButton else {
            os_log("Not the Done button; cancelling...", log: OSLog.default, type: .debug)
            return
        }
        
        let values = form.values()
        
        let tankObject = Tank(context: context)
        let tankWaterParameter = WaterParameter(context: context)
        
        tankObject.name = values["name"] as? String
        tankObject.brand = values["brand"] as? String
        tankObject.capacity = Int32(values["capacity"] as! Int)
        tankObject.waterType = values["watertype"] as? String
        tankObject.salt = Int32(values["salt"] as? Int ?? -1)
        tankObject.image = values["image"] as? Data
        
        if (self.form.rowBy(tag: "calculation") as? SegmentedRow<String>)?.value == "Manual" {
            tankWaterParameter.tempMax = Int16(values["maxtemp"] as! Int)
            tankWaterParameter.tempMin = Int16(values["mintemp"] as! Int)
            tankWaterParameter.phValue = values["ph"] as! Double
            tankWaterParameter.ghValue = Int16(values["gh"] as! Int)

        } else {
            tankWaterParameter.tempMax = -1
            tankWaterParameter.tempMin = -1
            tankWaterParameter.phValue = -1
            tankWaterParameter.ghValue = -1
        }
        tankWaterParameter.no2Value = -1
        tankWaterParameter.no3Value = -1
        tankObject.parameters = tankWaterParameter
        tankObject.measurements = Set<Measurement>.init()
        do {
            try context.save()
        } catch let error as NSError {
            print("Couldn't save new tank: \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
