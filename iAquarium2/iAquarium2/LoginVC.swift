//
//  LoginVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 20/12/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        loginButton.isEnabled = validateLoginInput()
        
        return true
    }
    
    @IBAction func restoreButtonPressed(_ sender: UIButton) {
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "LogInSegue") {
            let inputValid = validateLoginInput()
            
            if inputValid {
                let email = emailTextField.text!
                let pwd = passwordTextField.text!
                Auth.auth().signIn(withEmail: email, password: pwd, completion: { [weak self] authResult, error in
                    guard let strongSelf = self else { return }
                    if (error != nil) {
                        strongSelf.presentAuthErrorAlert(err: error!)
                    }
                })
                if Auth.auth().currentUser != nil {
                    return true
                }
            }
        }
        return true
    }
    
    private func validateLoginInput() -> Bool {
        var validation: [Bool] = [false, false]
        
        if emailTextField.text != nil && emailTextField.text!.isValidEmail {
            validation[0] = true
        } else {
            validation[0] = false
        }
        
        if passwordTextField.text != nil && passwordTextField.text!.count > 1 {
            validation[1] = true
        } else {
            validation[1] = false
        }
        
        if validation.allSatisfy({ $0 == true }) {
            return true
        } else {
            return false
        }
    }

}
