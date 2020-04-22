//
//  AddMeasurementVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 22/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit
import Eureka

class AddMeasurementVC: FormViewController {
    //MARK: - Setup
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    var measurement : Measurement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }
    //MARK: - Form
    func setupForm() {
        form
            +++ Section("Date of measurement")
            <<< DateTimeRow() {
                $0.title = "Date"
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
