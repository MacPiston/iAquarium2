//
//  Measurement.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 22/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import Foundation

class Measurement {
    var waterParams : WaterParameter = WaterParameter()
    var date : Date = Date()
    var note : String?
    
    init(waterParams : WaterParameter, date : Date) {
        self.waterParams = waterParams
        self.date = date
    }
    
    init () {
        
    }
    
}
