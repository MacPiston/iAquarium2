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

    @NSManaged public var cl2Value: Float
    @NSManaged public var ghValue: Float
    @NSManaged public var khValue: Float
    @NSManaged public var no2Value: Float
    @NSManaged public var no3Value: Float
    @NSManaged public var phValue: Float
    @NSManaged public var temp: Float
    @NSManaged public var ofMeasurement: Measurement?

}
