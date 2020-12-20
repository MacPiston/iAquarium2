//
//  SummaryTankSettingsVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 08/10/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit
import Eureka
import ImageRow
import SplitRow

class SummaryTankSettingsVC: FormViewController, passTank {
    // MARK: - Variables
    var tank: Tank?
    
    // MARK: - Class stuff
    func finishPassing(selectedTank: Tank) {
        self.tank = selectedTank
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }
    
    // MARK: - Form
    
    private func setupInfoSection() {
        form
            +++ Section("Tank information")
            <<< TextRow() {
                $0.title = "Tank Name"
                $0.placeholder = "Name..."
                $0.tag = "name"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnBlur
            }
            
            <<< TextRow() {
                $0.title = "Tank Brand"
                $0.placeholder = "Brand..."
                $0.tag = "brand"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnBlur
            }
        
            <<< ImageRow() {
                $0.title = "Tank Image"
                $0.tag = "image"
                $0.sourceTypes = [.Camera, .PhotoLibrary, .All]
                $0.allowEditor = true
                $0.placeholderImage = UIImage(systemName: "camera.on.rectangle")
                $0.cell.imageView?.contentMode = .scaleToFill
                $0.clearAction = .yes(style: .destructive)
            }
            
            <<< IntRow() {
                $0.title = "Tank Capacity"
                $0.placeholder = "L"
                $0.add(rule: RuleGreaterThan(min: 0))
                $0.add(rule: RuleRequired())
                $0.tag = "capacity"
            }

            <<< SegmentedRow<String>() {
                $0.title = "Water Type"
                $0.options = ["Normal", "Salty"]
                $0.value = "Normal"
                $0.tag = "watertype"
                $0.add(rule: RuleRequired())
            }
            <<< IntRow() {
                $0.title = "Salt"
                $0.placeholder = "g/L"
                $0.tag = "salt"
                $0.hidden = "$watertype != \"Salty\""
            }
    }
    
    private func setupParametersSection() {
        form
                +++ Section("Parameters")
                
                <<< SplitRow<DecimalRow, DecimalRow>() {
                    $0.rowLeftPercentage = 0.5
                    $0.rowLeft = DecimalRow() {
                        $0.title = "Min. Temp"
                        $0.tag = "min_temp"
                        $0.placeholder = "[°C]"
                        $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                        $0.useFormatterOnDidBeginEditing = true
                    }
                    $0.rowRight = DecimalRow() {
                        $0.title = "Max. Temp"
                        $0.tag = "max_temp"
                        $0.placeholder = "[°C]"
                        $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                        $0.useFormatterOnDidBeginEditing = true
                    }
                }
                
                <<< SplitRow<DecimalRow, DecimalRow>() {
                    $0.rowLeftPercentage = 0.5
                    $0.rowLeft = DecimalRow() {
                        $0.title = "Min. pH"
                        $0.tag = "min_ph"
                        $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                        $0.useFormatterOnDidBeginEditing = true
                    }
                    $0.rowRight = DecimalRow() {
                        $0.title = "Max. pH"
                        $0.tag = "max_ph"
                        $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                        $0.useFormatterOnDidBeginEditing = true
                    }
                }
                
                <<< SplitRow<DecimalRow, DecimalRow>() {
                    $0.rowLeftPercentage = 0.5
                    $0.rowLeft = DecimalRow() {
                        $0.title = "Min. GH"
                        $0.tag = "min_gh"
                        $0.placeholder = "[°d]"
                        $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                        $0.useFormatterOnDidBeginEditing = true
                    }
                    $0.rowRight = DecimalRow() {
                        $0.title = "Max. GH"
                        $0.tag = "max_gh"
                        $0.placeholder = "[°d]"
                        $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                        $0.useFormatterOnDidBeginEditing = true
                    }
                }
            
                <<< SplitRow<DecimalRow, DecimalRow>() {
                    $0.rowLeftPercentage = 0.5
                    $0.rowLeft = DecimalRow() {
                        $0.title = "Min. KH"
                        $0.tag = "min_kh"
                        $0.placeholder = "[°d]"
                        $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                        $0.useFormatterOnDidBeginEditing = true
                    }
                    $0.rowRight = DecimalRow() {
                        $0.title = "Max. KH"
                        $0.tag = "max_kh"
                        $0.placeholder = "[°d]"
                        $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                        $0.useFormatterOnDidBeginEditing = true
                    }
                }
            
                <<< SplitRow<DecimalRow, DecimalRow>() {
                    $0.rowLeftPercentage = 0.5
                    $0.rowLeft = DecimalRow() {
                        $0.title = "Min. Cl2"
                        $0.tag = "min_cl2"
                        $0.placeholder = "[mg/l]"
                        $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                        $0.useFormatterOnDidBeginEditing = true
                    }
                    $0.rowRight = DecimalRow() {
                        $0.title = "Max. Cl2"
                        $0.tag = "max_cl2"
                        $0.placeholder = "[mg/l]"
                        $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                        $0.useFormatterOnDidBeginEditing = true
                    }
                }
            
                <<< SplitRow<DecimalRow, DecimalRow>() {
                    $0.rowLeftPercentage = 0.5
                    $0.rowLeft = DecimalRow() {
                        $0.title = "Min. NO2"
                        $0.tag = "min_no2"
                        $0.placeholder = "[mg/l]"
                        $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                        $0.useFormatterOnDidBeginEditing = true
                    }
                    $0.rowRight = DecimalRow() {
                        $0.title = "Max. NO2"
                        $0.tag = "max_no2"
                        $0.placeholder = "[mg/l]"
                        $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                        $0.useFormatterOnDidBeginEditing = true
                    }
                }
            
                <<< SplitRow<DecimalRow, DecimalRow>() {
                    $0.rowLeftPercentage = 0.5
                    $0.rowLeft = DecimalRow() {
                        $0.title = "Min. NO3"
                        $0.tag = "min_no3"
                        $0.placeholder = "[mg/l]"
                        $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                        $0.useFormatterOnDidBeginEditing = true
                    }
                    $0.rowRight = DecimalRow() {
                        $0.title = "Max. NO3"
                        $0.tag = "max_no3"
                        $0.placeholder = "[mg/l]"
                        $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                        $0.useFormatterOnDidBeginEditing = true
                    }
                }
    }
    
    private func loadFormValues() {
        
        tableView.reloadData()
    }
    
    private func setupForm() {
        setupInfoSection()
        setupParametersSection()
        loadFormValues()
    }
    
    // MARK: - Core Data
    private func updateTankParameters() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
    }

    // MARK: - Navigation


}
