//
//  ExpectedWaterParameters+CoreDataProperties.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 25/06/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//
//

import Foundation
import CoreData


extension ExpectedWaterParameters {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpectedWaterParameters> {
        return NSFetchRequest<ExpectedWaterParameters>(entityName: "ExpectedWaterParameters")
    }

    @NSManaged public var cl2ValueMax: Float
    @NSManaged public var cl2ValueMin: Float
    @NSManaged public var ghValueMax: Float
    @NSManaged public var ghValueMin: Float
    @NSManaged public var khValueMax: Float
    @NSManaged public var khValueMin: Float
    @NSManaged public var no2ValueMax: Float
    @NSManaged public var no2ValueMin: Float
    @NSManaged public var no3ValueMax: Float
    @NSManaged public var no3ValueMin: Float
    @NSManaged public var phValueMax: Float
    @NSManaged public var phValueMin: Float
    @NSManaged public var tempValueMax: Float
    @NSManaged public var tempValueMin: Float
    @NSManaged public var ofTank: Tank?
    
    func getTempComp() -> String {
        return tempValueMin.description + " - " + tempValueMax.description
    }

    func getPhComp() -> String {
        return phValueMin.description + " - " + phValueMax.description
    }
    
    func getGHComp() -> String {
        return ghValueMin.description + " - " + ghValueMax.description
    }
    
    func getKHComp() -> String {
        return khValueMin.description + " - " + khValueMax.description
    }
    
    func getCl2Comp() -> String {
        return cl2ValueMin.description + " - " + cl2ValueMax.description
    }
    
    func getNO2Comp() -> String {
        return no2ValueMin.description + " - " + no2ValueMax.description
    }
    
    func getNO3Comp() -> String {
        return no3ValueMin.description + " - " + no3ValueMax.description
    }
}
