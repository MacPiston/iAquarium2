//
//  WaterParametersModel.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 12/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//
/*
 Water Parameters:
 - minimum temperature °C
 - maximum temperature °C
 - Cl2 value mg/l
 - pH value
 - KH value °d
 - GH value °d
 - NO2 value mg/l
 - NO3 value mg/l
 
 Loggable parameters:
    - temperature
    - Cl2 value mg/l
    - pH value
    - GH value °d
    - KH value °d
    - NO2 value mg/l
    - NO3 value mg/l
    - Date of measurements
 */

import Foundation

class WaterParameter {
    // loggable
    var temp : Int
    var phValue : Double
    var ghValue : Int
    var khValue : Int
    var cl2Value : Int
    var no2Value : Int
    var no3Value : Int
    
    //init for logging parameters
    init(temp : Int?, cl2Value: Int?, phValue: Double?, khValue: Int?, ghValue: Int?, no2Value: Int?, no3Value: Int?) {
        self.temp = temp ?? -1
        self.cl2Value = cl2Value ?? -1
        self.phValue = phValue ?? -1
        self.khValue = khValue ?? -1
        self.ghValue = ghValue ?? -1
        self.no2Value = no2Value ?? -1
        self.no3Value = no3Value ?? -1
    }
    
    init() {
        self.temp = -1
        self.cl2Value = -1
        self.phValue = -1
        self.khValue = -1
        self.ghValue = -1
        self.no2Value = -1
        self.no3Value = -1
    }
}

class WaterParameterInitial {
    // user definable
    let minTemp : Int
    let maxTemp : Int
    let phValue : Double
    let ghValue : Int
    
    init(minTemp : Int, maxTemp : Int, phValue : Double, ghValue : Int) {
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.phValue = phValue
        self.ghValue = ghValue
    }
    
    init() {
        self.minTemp = -1
        self.maxTemp = -1
        self.phValue = -1
        self.ghValue = -1
    }
    
    func tempComp() -> String {
        return (String(minTemp) + " - " + String(maxTemp))
    }
}
