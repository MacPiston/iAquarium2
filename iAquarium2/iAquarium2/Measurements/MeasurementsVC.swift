//
//  MeasurementsVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 18/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit
import Eureka

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
    }
}
