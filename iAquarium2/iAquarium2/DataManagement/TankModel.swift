//
//  TankModel.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 10/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import Foundation

class Tank {

    init(newName : String, newBrand : String, newCapacity: Int, newWaterType : String, newSaltAmount : Int? = nil) {
        self.name = newName
        self.brand = newBrand
        self.capacity = newCapacity
        self.waterType = newWaterType
        self.saltAmount = newSaltAmount
    }
    var name : String
    var brand : String
    var capacity : Int
    var waterType : String
    var saltAmount: Int?
    
}
