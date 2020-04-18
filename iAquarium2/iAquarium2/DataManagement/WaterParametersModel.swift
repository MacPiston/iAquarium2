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
    let temp : Int
    let phValue : Double
    let ghValue : Int
    let khValue : Int
    let cl2Value : Int
    let no2Value : Int
    let no3Value : Int
    let date : Date?
    
    //init for logging parameters
    init(temp : Int?, cl2Value: Int?, phValue: Double?, khValue: Int?, ghValue: Int?, no2Value: Int?, no3Value: Int?, date: Date) {
        self.temp = temp ?? -1
        self.cl2Value = cl2Value ?? -1
        self.phValue = phValue ?? -1
        self.khValue = khValue ?? -1
        self.ghValue = ghValue ?? -1
        self.no2Value = no2Value ?? -1
        self.no3Value = no3Value ?? -1
        self.date = date
    }
    
    init() {
        self.temp = -1
        self.cl2Value = -1
        self.phValue = -1
        self.khValue = -1
        self.ghValue = -1
        self.no2Value = -1
        self.no3Value = -1
        date = Date()
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
