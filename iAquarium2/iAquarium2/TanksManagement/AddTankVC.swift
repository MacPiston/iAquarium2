//
//  AddTankVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 10/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit
import Eureka
import os.log

class AddTankVC: FormViewController {

    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    var newTank : Tank?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationOptions = RowNavigationOptions.Disabled
        var rulesRequired = RuleSet<String>()
        rulesRequired.add(rule: RuleRequired())
        
    // MARK: - Form
        // Basic Information
        form +++ Section("Basic Information")
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

        // Additional Information
        form +++ Section("Parameters")
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
                    self.doneBarButton.isEnabled = false
                } else {
                    self.doneBarButton.isEnabled = true
                }
        }
        
        form +++ Section("Additional information like water temperature, pH etc. will be calculated for you later.")
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === doneBarButton else {
            os_log("Not the Done button; cancelling...", log: OSLog.default, type: .debug)
            return
        }
        
        let valuesDictionary = form.values()
        newTank = Tank(newName: valuesDictionary["name"] as! String, newBrand: valuesDictionary["brand"] as! String, newCapacity: valuesDictionary["capacity"] as! Int, newWaterType: valuesDictionary["watertype"] as! String, newSaltAmount: valuesDictionary["salt"] as? Int)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
