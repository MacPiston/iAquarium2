//
//  EditProfileVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 31/12/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class EditProfileVC: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser
        if (user == nil) {
            UIView.setAnimationsEnabled(false)
            performSegue(withIdentifier: "LoginSegue", sender: self)
            UIView.setAnimationsEnabled(true)
        }
        
        setupForm()
        loadFormData()
    }

    private func loadFormData() {
        let user = Auth.auth().currentUser
        if let user = user {
            form.setValues([
                "displayname": user.displayName,
                "email": user.email
            ])
        }
        tableView.reloadData()
    }
    
    private func setupForm() {
        form
            +++ Section("Edit profile information")
            <<< TextRow() {
                $0.tag = "displayname"
                $0.title = "Display name"
            }
            
            +++ Section()
            <<< EmailRow() {
                $0.tag = "email"
                $0.title = "Email address"
            }
        
            +++ Section()
            <<< PasswordRow() {
                $0.tag = "pwd1"
                $0.title = "New password"
            }.onChange({ [self] row in
                let pwd2row = form.rowBy(tag: "pwd2") as! PasswordRow
                let buttonRow = form.rowBy(tag: "saveButton")
                if (pwd2row.value != row.value) {
                    buttonRow?.disabled = true
                } else {
                    buttonRow?.disabled = false
                }
                buttonRow?.evaluateDisabled()
            })
            <<< PasswordRow() {
                $0.tag = "pwd2"
                $0.title = "Repeat password"
            }.onChange({ [self] row in
                let pwd1row = form.rowBy(tag: "pwd1") as! PasswordRow
                let buttonRow = form.rowBy(tag: "saveButton")
                if (pwd1row.value != row.value) {
                    buttonRow?.disabled = true
                } else {
                    buttonRow?.disabled = false
                }
                buttonRow?.evaluateDisabled()
            })
        
            +++ Section()
            <<< ButtonRow() {
                $0.tag = "saveButton"
                $0.title = "Save changes"
                $0.disabled = true
            }.onCellSelection({ cell, row in
                let user = Auth.auth().currentUser
                let errorAC = UIAlertController(title: "Error", message: "There was an error while updating values.", preferredStyle: .alert)
                errorAC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                
                if let user = user {
                    let changeRq = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRq?.displayName = self.form.values()["displayname"] as? String
                    changeRq?.commitChanges(completion: { error in
                        if let error = error {
                            self.present(errorAC, animated: true)
                            print(error.localizedDescription)
                        }
                    })
                    Auth.auth().currentUser?.updateEmail(to: self.form.values()["email"] as! String, completion: { error in
                        if let error = error {
                            self.present(errorAC, animated: true)
                            print(error.localizedDescription)
                        }
                    })
                    
                    let relogAlert = UIAlertController(title: "Password required", message: "Re-type password in order to change password and/or email address", preferredStyle: .alert)
                    relogAlert.addTextField(configurationHandler: { field in
                        field.placeholder = "Current password"
                        field.isSecureTextEntry = true
                    })
                    relogAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { alertAction in
                        let credential: AuthCredential = EmailAuthProvider.credential(withEmail: user.email!, password: (relogAlert.textFields![0] as UITextField).text ?? "")
                        
                        user.reauthenticate(with: credential, completion: { result, error in
                            if let error = error {
                                print("Error: \(error.localizedDescription)")
                            } else {
                                Auth.auth().currentUser?.updatePassword(to: self.form.values()["pwd2"] as! String, completion: { error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                    }
                                })
                                self.navigationController?.popViewController(animated: true)
                            }
                        })
                    }))
                    self.present(relogAlert, animated: true)
                }
            })
        
            <<< ButtonRow() {
                $0.tag = "logoutButton"
                $0.title = "Logout"
            }.onCellSelection({ cell, row in
                do {
                try Auth.auth().signOut()
                } catch {
                    
                }
                self.performSegue(withIdentifier: "userLoggedOutSegue", sender: self)
            })
            .cellUpdate({ cell, row in
                cell.textLabel?.textColor = .systemRed
            })
    }
}
