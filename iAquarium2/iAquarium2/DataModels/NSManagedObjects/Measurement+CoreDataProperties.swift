//
//  Measurement+CoreDataProperties.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 24/05/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//
//

import Foundation
import CoreData


extension Measurement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Measurement> {
        return NSFetchRequest<Measurement>(entityName: "Measurement")
    }

    @NSManaged public var date: Date?
    @NSManaged public var note: String?
    @NSManaged public var ofTank: Tank?
    @NSManaged public var parameter: WaterParameter?

}
