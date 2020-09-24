//
//  SummarySettingsEntity+CoreDataProperties.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 24/09/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//
//

import Foundation
import CoreData


extension SummarySettingsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SummarySettingsEntity> {
        return NSFetchRequest<SummarySettingsEntity>(entityName: "SummarySettingsEntity")
    }

    @NSManaged public var ghAlertEnabled: Bool
    @NSManaged public var ghChartEnabled: Bool
    @NSManaged public var no2AlertEnabled: Bool
    @NSManaged public var no2ChartEnabled: Bool
    @NSManaged public var no3AlertEnabled: Bool
    @NSManaged public var no3ChartEnabled: Bool
    @NSManaged public var phAlertEnabled: Bool
    @NSManaged public var phChartEnabled: Bool
    @NSManaged public var tempAlertEnabled: Bool
    @NSManaged public var tempChartEnabled: Bool

}

extension SummarySettingsEntity : Identifiable {

}
