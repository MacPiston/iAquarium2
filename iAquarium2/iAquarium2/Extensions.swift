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
