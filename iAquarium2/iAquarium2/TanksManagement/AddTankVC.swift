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

class AddTankVC: FormViewController {

    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    var newTank : Tank?

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
        var rulesRequired = RuleSet<String>()
        rulesRequired.add(rule: RuleRequired())
        
    // MARK: - TODO SECTION
         /*
         - passing parameters to new tank object
         - values verification
         - cells validation
         */
        
    // MARK: - Form
        // Basic Information
        form +++ Section("Tank information")
            <<< TextRow() {
                $0.title = "Tank Name"
                $0.placeholder = "Name..."
                $0.tag = "name"
                $0.add(ruleSet: rulesRequired)
                $0.validationOptions = .validatesOnChange
        }
            <<< TextRow() {
                $0.title = "Tank Brand"
                $0.placeholder = "Brand..."
                $0.tag = "brand"
                $0.add(ruleSet: rulesRequired)
                $0.validationOptions = .validatesOnChange
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
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                        self.saveBarButton.isEnabled = false
                    } else {
                        self.saveBarButton.isEnabled = true
                    }
            }

            <<< SegmentedRow<String>() {
                $0.title = "Water Type"
                $0.options = ["Normal", "Salty"]
                $0.value = "Normal"
                $0.tag = "watertype"
                $0.add(ruleSet: rulesRequired)
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
                $0.validationOptions = .validatesOnChange
        }.cellUpdate {
            cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
                self.saveBarButton.isEnabled = false
            } else {
                self.saveBarButton.isEnabled = true
            }
        }
            
            <<< IntRow() {
                $0.title = "Minimum temp. [°C]"
                $0.tag = "mintemp"
                $0.hidden = manualCondition
                $0.add(rule: RuleGreaterThan(min: 0))
                $0.validationOptions = .validatesOnChange
        }.cellUpdate {
            cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
                self.saveBarButton.isEnabled = false
            } else {
                self.saveBarButton.isEnabled = true
            }
        }
            
            <<< IntRow() {
                $0.title = "pH"
                $0.tag = "ph"
                $0.hidden = manualCondition
                $0.add(rule: RuleGreaterOrEqualThan(min: 1))
                $0.add(rule: RuleSmallerOrEqualThan(max: 14))
                $0.validationOptions = .validatesOnChange
        }.cellUpdate {
            cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
                self.saveBarButton.isEnabled = false
            } else {
                self.saveBarButton.isEnabled = true
            }
        }
            
            <<< IntRow() {
                $0.title = "GH (General Hardness) [°d]"
                $0.tag = "gh"
                $0.hidden = manualCondition
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
        newTank = Tank(newName: values["name"] as! String, newBrand: values["brand"] as! String, newCapacity: values["capacity"] as! Int, newWaterType: values["watertype"] as! String, newSaltAmount: values["salt"] as? Int ?? 0)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
