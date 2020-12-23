//
//  RegisterVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 22/12/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class RegisterVC: FormViewController {
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var headLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .clear
        addBackgroundGradient(color1: #colorLiteral(red: 0.2060806416, green: 0.5065105974, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.9439892326, green: 0.9439892326, blue: 0.9439892326, alpha: 1))
        
        formSetup()

        setupShadows()
    }
    
    private func formSetup() {
        tableView.backgroundColor = .clear

        form +++ Section("") {
            $0.header?.height = { 55 }
            
        }
        <<< LabelRow() {
            $0.title = "Email address"
            $0.cell.textLabel?.textColor = .white
        }
        <<< EmailRow() {
            $0.tag = "email"
            $0.placeholder = "Enter valid email address"
            $0.add(rule: RuleEmail())
            $0.validationOptions = .validatesOnChangeAfterBlurred
        }.onChange({ [self] row in
            if (form.validate().isEmpty) {
                submitButton.isEnabled = true
            } else {
                submitButton.isEnabled = false
            }
        })
        
        +++ Section("") {
            $0.header?.height = { 10 }
        }
        <<< LabelRow() {
            $0.title = "Password"
        }
        <<< PasswordRow() {
            $0.tag = "pwd1"
            $0.placeholder = "Strong-enough password"
            $0.add(rule: RuleRequired())
            $0.validationOptions = .validatesOnChangeAfterBlurred
        }.onChange({ [self] row in
            if (form.validate().isEmpty) {
                submitButton.isEnabled = true
            } else {
                submitButton.isEnabled = false
            }
        })
        <<< PasswordRow() {
            $0.tag = "pwd2"
            $0.placeholder = "Repeat password"
            $0.add(rule: RuleRequired())
            $0.validationOptions = .validatesOnChangeAfterBlurred
        }.onChange({ [self] row in
            if (form.validate().isEmpty) {
                submitButton.isEnabled = true
            } else {
                submitButton.isEnabled = false
            }
        })
        
    }
    
    private func setupShadows() {
        headLabel.layer.applySketchShadow()
        tableView.layer.applySketchShadow()
        submitButton.layer.applySketchShadow()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
    }
}
