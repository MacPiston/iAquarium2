//
//  Tank+CoreDataProperties.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 25/06/2020.
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
    @NSManaged public var capacity: Int32
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var salt: Int32
    @NSManaged public var waterType: String?
    @NSManaged public var expectedParameters: ExpectedWaterParameters?
    @NSManaged public var measurements: Set<Measurement>?

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
