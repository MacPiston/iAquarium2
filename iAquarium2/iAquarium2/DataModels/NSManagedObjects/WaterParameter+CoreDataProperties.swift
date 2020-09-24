//
//  WaterParameter+CoreDataProperties.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 25/06/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//
//

import Foundation
import CoreData


extension WaterParameter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WaterParameter> {
        return NSFetchRequest<WaterParameter>(entityName: "WaterParameter")
    }

    @NSManaged public var cl2Value: Double
    @NSManaged public var ghValue: Double
    @NSManaged public var khValue: Double
    @NSManaged public var no2Value: Double
    @NSManaged public var no3Value: Double
    @NSManaged public var phValue: Double
    @NSManaged public var temp: Double
    @NSManaged public var ofMeasurement: Measurement?
    
    func getParameter(forKey: String) -> Double {
        switch forKey {
        case "cl2":
            return cl2Value
        case "gh":
            return ghValue
        case "kh":
            return khValue
        case "no2":
            return no2Value
        case "no3":
            return no3Value
        case "ph":
            return phValue
        case "temp":
            return temp
        default:
            return -1
        }
    }

}
