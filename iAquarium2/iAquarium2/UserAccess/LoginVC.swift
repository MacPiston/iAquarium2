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

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var restorePasswordButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let introImages: [UIImage] = [#imageLiteral(resourceName: "aquarium"), #imageLiteral(resourceName: "aquarium")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        self.view.backgroundColor = .clear
        addBackgroundGradient(color1: #colorLiteral(red: 0.2060806416, green: 0.5065105974, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.9439892326, green: 0.9439892326, blue: 0.9439892326, alpha: 1))
        setupImagesScrollView(introImages)
        setupShadows()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        loginButton.isEnabled = validateLoginInput()
        return true
    }
    
    
    @IBAction func restorePasswordPressed(_ sender: UIButton) {
        if emailTextField.text != nil && !emailTextField.text!.isEmpty && emailTextField.text!.isValidEmail {
            // Send password reset request
            let requestSent = UIAlertController(title: "Request sent", message: "Password reset request has been sent to \(String(describing: emailTextField.text))", preferredStyle: .alert)
            requestSent.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(requestSent, animated: true, completion: nil)
        } else {
            let emailEmptyAlert = UIAlertController(title: "Error!", message: "Enter valid email address", preferredStyle: .alert)
            emailEmptyAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(emailEmptyAlert, animated: true, completion: nil)
        }
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
        } else if (identifier == "RegisterSegue") {
            return true
        }
        
        return false
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
    
    private func setupImagesScrollView(_ images: [UIImage]) {
        for i in 0..<images.count {
            let imageView = UIImageView()
            imageView.image = images[i]
            let xPos = UIScreen.main.bounds.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            imageView.contentMode = .scaleToFill
            
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i + 1)
            scrollView.addSubview(imageView)
        }
    }
    
    private func setupShadows() {
        welcomeLabel.layer.applySketchShadow()
        scrollView.layer.applySketchShadow()
        emailTextField.layer.applySketchShadow()
        passwordTextField.layer.applySketchShadow()
        loginButton.layer.applySketchShadow()
        registerButton.layer.applySketchShadow()
        restorePasswordButton.layer.applySketchShadow()
    }
}
