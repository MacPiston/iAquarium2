//
//  Extensions.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 15/06/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import Charts

extension FormViewController {
    func textValidationCallback(textCell: TextCell, textRow: TextRow) {
        if !textRow.validate().isEmpty {
            textCell.textLabel?.textColor = .systemRed
        }
    }
    
    func decimalValidationCallback(decimalCell: DecimalCell, decimalRow: DecimalRow) {
        if !decimalRow.validate().isEmpty {
            decimalCell.textLabel?.textColor = .systemRed
        }
    }
    
    func integerValidationCallback(integerCell: IntCell, integerRow: IntRow) {
        if !integerRow.validate().isEmpty {
            integerCell.textLabel?.textColor = .systemRed
        }
    }
}

class ChartXAxisFormatter: NSObject {
    fileprivate var dateFormatter: DateFormatter?
    fileprivate var referenceTimeInterval: TimeInterval?

    convenience init(referenceTimeInterval: TimeInterval, dateFormatter: DateFormatter) {
        self.init()
        self.referenceTimeInterval = referenceTimeInterval
        self.dateFormatter = dateFormatter
    }
}


extension ChartXAxisFormatter: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let dateFormatter = dateFormatter,
        let referenceTimeInterval = referenceTimeInterval
        else {
            return ""
        }

        let date = Date(timeIntervalSince1970: value * 3600 * 24 + referenceTimeInterval)
        return dateFormatter.string(from: date)
    }

}
