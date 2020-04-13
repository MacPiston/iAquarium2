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
 */

import Foundation

class WaterParameter {
    // user definable
    let minTemp : Int?
    let maxTemp : Int?
    let phValue : Int
    let ghValue : Int

    // loggable
    let temp : Int?
    let khValue : Int
    let cl2Value : Int
    let no2Value : Int
    let no3Value : Int
    let date : NSDate?
    
    init(temp : Int? ,minTemp: Int?, maxTemp: Int?, cl2Value: Int?, phValue: Int?, khValue: Int?, ghValue: Int?, no2Value: Int?, no3Value: Int?) {
        self.temp = temp ?? -1
        self.minTemp = minTemp ?? -1
        self.maxTemp = maxTemp ?? -1
        self.cl2Value = cl2Value ?? -1
        self.phValue = phValue ?? -1
        self.khValue = khValue ?? -1
        self.ghValue = ghValue ?? -1
        self.no2Value = no2Value ?? -1
        self.no3Value = no3Value ?? -1
        date = NSDate()
    }
    
    init() {
        self.temp = -1
        self.minTemp = -1
        self.maxTemp = -1
        self.cl2Value = -1
        self.phValue = -1
        self.khValue = -1
        self.ghValue = -1
        self.no2Value = -1
        self.no3Value = -1
        date = nil
    }
    
    func returnTempComp() -> String {
        return (String(minTemp!) + " - " + String(maxTemp!))
    }
}
