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
        
        self.view.bringSubviewToFront(submitButton)
        self.view.bringSubviewToFront(headLabel)
    }
    
    private func formSetup() {
        tableView.backgroundColor = .clear

        form +++ Section("") {
            $0.header?.height = { 55 }
            
        }
        <<< LabelRow() {
            $0.title = "Display name"
        }
        <<< TextRow() {
            $0.tag = "displayName"
            $0.placeholder = "Enter your nickname"
        }
        <<< LabelRow() {
            $0.title = "Email address"
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
            let pwd2row = form.rowBy(tag: "pwd2") as! PasswordRow
            if (form.validate().isEmpty && pwd2row.value == row.value) {
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
            let pwd1row = form.rowBy(tag: "pwd1") as! PasswordRow
            if (form.validate().isEmpty && pwd1row.value == row.value) {
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
        if (form.validate().isEmpty) {
            let email = form.values()["email"] as! String
            let pwd = form.values()["pwd2"] as! String
            let displayName = form.values()["displayName"] as? String ?? email
            
            Auth.auth().createUser(withEmail: email, password: pwd, completion: { authResult, error in
                Auth.auth().signIn(withEmail: email, password: pwd, completion: { [weak self] authResult, error in
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = displayName
                    changeRequest?.commitChanges(completion: { error in
                        let user = Auth.auth().currentUser
                        if let user = user {
                            // Create and update User Document
                            let userDoc = UserDocument(uid: user.uid)
                            userDoc.setUserDocument(displayName: displayName, email: email)
                        }
                        self!.performSegue(withIdentifier: "RegistrationCompleteSegue", sender: self!.submitButton)
                    })
                })
            })
            
        }
    }
}
