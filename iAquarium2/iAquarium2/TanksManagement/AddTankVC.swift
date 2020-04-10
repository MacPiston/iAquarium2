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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationOptions = RowNavigationOptions.Disabled
    // MARK: - Form
        // Basic Information
        form +++ Section("Basic Information")
            <<< TextRow() {
                $0.title = "Tank Name"
                $0.placeholder = "Name..."
        }
            <<< TextRow() {
                $0.title = "Tank Brand"
                $0.placeholder = "Brand..."
        }

        // Additional Information
        form +++ Section("Additional Information")
            <<< SegmentedRow<String>() {
                $0.title = "Water Type"
                $0.options = ["Normal", "Salty"]
                $0.value = "Normal"
        }
            <<< IntRow() {
                $0.title = "Tank Capacity"
                $0.placeholder = "Capacity..."
                $0.add(rule: RuleGreaterThan(min: 0))
                $0.validationOptions = .validatesOnChange
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
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
