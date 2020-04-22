//
//  MeasurementsVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 18/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit
import Eureka
import TableRow

class MeasurementsVC: FormViewController {

    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
        // Do any additional setup after loading the view.
    }
    
    func setupForm() {
        form
            +++ Section("nope")
            <<< TableInlineRow<String> { row in
            row.options = ["first", "second", "third"]
            row.value = "none"
        }
    }
    
    @IBAction func unwindToMeasurements(sender: UIStoryboardSegue) {
        if let sourceVC = sender.source as? AddMeasurementVC, let newMeasurement = sourceVC.measurement {
            
        }
    }
}
