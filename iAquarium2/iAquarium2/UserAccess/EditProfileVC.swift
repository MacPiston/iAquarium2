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
                $0.title = "Password"
            }
            <<< PasswordRow() {
                $0.tag = "pwd2"
                $0.title = "Repeat password"
            }
        
            +++ Section()
            <<< ButtonRow() {
                $0.title = "Save changes"
            }.onCellSelection({ cell, row in
                let user = Auth.auth().currentUser
                let errorAC = UIAlertController(title: "Error", message: "There was an error while updating values.", preferredStyle: .alert)
                errorAC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                
                if let user = user {
                    let changeRq = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRq?.displayName = self.form.values()["displayname"] as? String
                    changeRq?.commitChanges(completion: { error in
                        if let error = error {
                            self.present(errorAC, animated: true)
                        }
                    })
                    Auth.auth().currentUser?.updateEmail(to: self.form.values()["email"] as! String, completion: { error in
                        if let error = error {
                            self.present(errorAC, animated: true)
                        }
                    })
                    Auth.auth().currentUser?.updatePassword(to: self.form.values()["pwd2"] as! String, completion: { error in
                        if let error = error {
                            self.present(errorAC, animated: true)
                        }
                    })
                }
                self.navigationController?.popViewController(animated: true)
            })
    }
}
