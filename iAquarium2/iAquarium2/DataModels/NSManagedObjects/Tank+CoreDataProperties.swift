//
//  Tank+CoreDataProperties.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 17/05/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//
//

import Foundation
import CoreData


extension Tank {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tank> {
        return NSFetchRequest<Tank>(entityName: "Tank")
    }

    @NSManaged public var brand: String?
    @NSManaged public var capacity: Int16
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var waterType: String?
    @NSManaged public var measurements: NSSet?
    @NSManaged public var parameters: WaterParameter?

}

// MARK: Generated accessors for measurements
extension Tank {

    @objc(addMeasurementsObject:)
    @NSManaged public func addToMeasurements(_ value: Measurement)

    @objc(removeMeasurementsObject:)
    @NSManaged public func removeFromMeasurements(_ value: Measurement)

    @objc(addMeasurements:)
    @NSManaged public func addToMeasurements(_ values: NSSet)

    @objc(removeMeasurements:)
    @NSManaged public func removeFromMeasurements(_ values: NSSet)

}
