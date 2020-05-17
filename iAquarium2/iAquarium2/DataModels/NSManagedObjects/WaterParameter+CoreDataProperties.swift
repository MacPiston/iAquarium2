//
//  WaterParameter+CoreDataProperties.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 17/05/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//
//

import Foundation
import CoreData


extension WaterParameter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WaterParameter> {
        return NSFetchRequest<WaterParameter>(entityName: "WaterParameter")
    }

    @NSManaged public var cl2Value: Int16
    @NSManaged public var ghValue: Int16
    @NSManaged public var khValue: Int16
    @NSManaged public var no2Value: Int16
    @NSManaged public var no3Value: Int16
    @NSManaged public var phValue: Double
    @NSManaged public var temp: Int16
    @NSManaged public var tempMax: Int16
    @NSManaged public var tempMin: Int16
    @NSManaged public var ofMeasurement: Measurement?
    @NSManaged public var ofTank: Tank?

}
