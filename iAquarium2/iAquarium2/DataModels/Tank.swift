//
//  Tank.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 10/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import Foundation

class Tank {

    var name : String
    var brand : String
    var capacity : Int
    var waterType : String
    var saltAmount : Int
    var waterExpectedParams : WaterParameterInitial
    var measurements : [Measurement] = [Measurement]()
    
    init(newName : String, newBrand : String, newCapacity: Int, newWaterType : String, newSaltAmount : Int) {
        self.name = newName
        self.brand = newBrand
        self.capacity = newCapacity
        self.waterType = newWaterType
        self.saltAmount = newSaltAmount
        self.waterExpectedParams = WaterParameterInitial()
    }
    
    init(newName : String, newBrand : String, newCapacity: Int, newWaterType : String, newSaltAmount : Int, newWaterParams : WaterParameterInitial) {
        self.name = newName
        self.brand = newBrand
        self.capacity = newCapacity
        self.waterType = newWaterType
        self.saltAmount = newSaltAmount
        self.waterExpectedParams = newWaterParams
    }
    
    func lastMeasurement() -> Measurement {
        if !measurements.isEmpty {
            return measurements.last!
        } else {
            return Measurement()
        }
    }
}
