//
//  AddTankVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 10/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit
import Eureka
import ImageRow
import os.log
import CoreData
import SplitRow
// MARK: - TODO
/*
 - values validation
 */
class AddTankVC: FormViewController {

    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationOptions = RowNavigationOptions.Disabled
    
        let hideCondition = Condition.function(["calculation"], { form in
            return !((form.rowBy(tag: "calculation") as? SegmentedRow<String>)?.value == "Manual")
        })
        
    // MARK: - Form
        // Basic Information
        form +++ Section("Tank information")
            <<< TextRow() {
                $0.title = "Tank Name"
                $0.placeholder = "Name..."
                $0.tag = "name"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
        }
            
            <<< TextRow() {
                $0.title = "Tank Brand"
                $0.placeholder = "Brand..."
                $0.tag = "brand"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
        }
        
            <<< ImageRow() {
                $0.title = "Tank Image"
                $0.tag = "image"
                
                $0.sourceTypes = [.Camera, .PhotoLibrary, .All]
                $0.allowEditor = true
                $0.placeholderImage = UIImage(systemName: "camera.on.rectangle")
                $0.clearAction = .yes(style: .destructive)
        }
            
            <<< IntRow() {
                    $0.title = "Tank Capacity"
                    $0.placeholder = "Capacity..."
                    $0.add(rule: RuleGreaterThan(min: 0))
                    $0.add(rule: RuleRequired())
                    $0.validationOptions = .validatesOnChange
                    $0.tag = "capacity"
        }

            <<< SegmentedRow<String>() {
                $0.title = "Water Type"
                $0.options = ["Normal", "Salty"]
                $0.value = "Normal"
                $0.tag = "watertype"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
        }
            <<< IntRow() {
                $0.title = "Salt"
                $0.placeholder = "g/L"
                $0.tag = "salt"
                $0.hidden = Condition.function(["watertype"], {
                    form in
                    return !((form.rowBy(tag: "watertype") as? SegmentedRow)?.value == "Salty")
                })
        }

        //PARAMETERS
        +++ Section("Parameters")
            <<< SegmentedRow<String>() {
                    $0.title = "Parameters calculation"
                    $0.options = ["Auto", "Manual"]
                    $0.value = "Auto"
                    $0.tag = "calculation"
            }
            
            <<< SplitRow<DecimalRow, DecimalRow>() {
                $0.rowLeftPercentage = 0.5
                $0.rowLeft = DecimalRow() {
                    $0.title = "Min. Temp"
                    $0.tag = "min_temp"
                    $0.placeholder = "[°C]"
                    $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                    $0.useFormatterOnDidBeginEditing = true
                    $0.validationOptions = .validatesOnChange
                }
                $0.rowRight = DecimalRow() {
                    $0.title = "Max. Temp"
                    $0.tag = "max_temp"
                    $0.placeholder = "[°C]"
                    $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                    $0.useFormatterOnDidBeginEditing = true
                    $0.validationOptions = .validatesOnChange
                }
                $0.hidden = hideCondition
            }
            
            <<< SplitRow<DecimalRow, DecimalRow>() {
                $0.rowLeftPercentage = 0.5
                $0.rowLeft = DecimalRow() {
                    $0.title = "Min. pH"
                    $0.tag = "min_ph"
                    $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                    $0.useFormatterOnDidBeginEditing = true
                    $0.validationOptions = .validatesOnChange
                }
                $0.rowRight = DecimalRow() {
                    $0.title = "Max. pH"
                    $0.tag = "max_ph"
                    $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                    $0.useFormatterOnDidBeginEditing = true
                    $0.validationOptions = .validatesOnChange
                }
                $0.hidden = hideCondition
            }
            
            <<< SplitRow<DecimalRow, DecimalRow>() {
                $0.rowLeftPercentage = 0.5
                $0.rowLeft = DecimalRow() {
                    $0.title = "Min. GH"
                    $0.tag = "min_gh"
                    $0.placeholder = "[°d]"
                    $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                    $0.useFormatterOnDidBeginEditing = true
                    $0.validationOptions = .validatesOnChange
                }
                $0.rowRight = DecimalRow() {
                    $0.title = "Max. GH"
                    $0.tag = "max_gh"
                    $0.placeholder = "[°d]"
                    $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                    $0.useFormatterOnDidBeginEditing = true
                    $0.validationOptions = .validatesOnChange
                }
                $0.hidden = hideCondition
            }
        
            <<< SplitRow<DecimalRow, DecimalRow>() {
                $0.rowLeftPercentage = 0.5
                $0.rowLeft = DecimalRow() {
                    $0.title = "Min. KH"
                    $0.tag = "min_kh"
                    $0.placeholder = "[°d]"
                    $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                    $0.useFormatterOnDidBeginEditing = true
                    $0.validationOptions = .validatesOnChange
                }
                $0.rowRight = DecimalRow() {
                    $0.title = "Max. KH"
                    $0.tag = "max_kh"
                    $0.placeholder = "[°d]"
                    $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                    $0.useFormatterOnDidBeginEditing = true
                    $0.validationOptions = .validatesOnChange
                }
                $0.hidden = hideCondition
            }
        
            <<< SplitRow<DecimalRow, DecimalRow>() {
                $0.rowLeftPercentage = 0.5
                $0.rowLeft = DecimalRow() {
                    $0.title = "Min. Cl2"
                    $0.tag = "min_cl2"
                    $0.placeholder = "[mg/l]"
                    $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                    $0.useFormatterOnDidBeginEditing = true
                    $0.validationOptions = .validatesOnChange
                }
                $0.rowRight = DecimalRow() {
                    $0.title = "Max. Cl2"
                    $0.tag = "max_cl2"
                    $0.placeholder = "[mg/l]"
                    $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                    $0.useFormatterOnDidBeginEditing = true
                    $0.validationOptions = .validatesOnChange
                }
                $0.hidden = hideCondition
            }
        
            <<< SplitRow<DecimalRow, DecimalRow>() {
                $0.rowLeftPercentage = 0.5
                $0.rowLeft = DecimalRow() {
                    $0.title = "Min. NO2"
                    $0.tag = "min_no2"
                    $0.placeholder = "[mg/l]"
                    $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                    $0.useFormatterOnDidBeginEditing = true
                    $0.validationOptions = .validatesOnChange
                }
                $0.rowRight = DecimalRow() {
                    $0.title = "Max. NO2"
                    $0.tag = "max_no2"
                    $0.placeholder = "[mg/l]"
                    $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                    $0.useFormatterOnDidBeginEditing = true
                    $0.validationOptions = .validatesOnChange
                }
                $0.hidden = hideCondition
            }
        
            <<< SplitRow<DecimalRow, DecimalRow>() {
                $0.rowLeftPercentage = 0.5
                $0.rowLeft = DecimalRow() {
                    $0.title = "Min. NO3"
                    $0.tag = "min_no3"
                    $0.placeholder = "[mg/l]"
                    $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                    $0.useFormatterOnDidBeginEditing = true
                    $0.validationOptions = .validatesOnChange
                }
                $0.rowRight = DecimalRow() {
                    $0.title = "Max. NO3"
                    $0.tag = "max_no3"
                    $0.placeholder = "[mg/l]"
                    $0.add(rule: RuleGreaterOrEqualThan(min: 0))
                    $0.useFormatterOnDidBeginEditing = true
                    $0.validationOptions = .validatesOnChange
                }
                $0.hidden = hideCondition
            }
    }
    
    func checkValidity() {
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveBarButton else {
            os_log("Not the Done button; cancelling...", log: OSLog.default, type: .debug)
            return
        }
        
        let values = form.values()
        let tankObject = Tank(context: context)
        let tankExpectedParameters = ExpectedWaterParameters(context: context)
        
        // BASIC VALUES
        tankObject.name = values["name"] as? String
        tankObject.brand = values["brand"] as? String
        tankObject.capacity = Int32(values["capacity"] as! Int)
        tankObject.waterType = values["watertype"] as? String
        tankObject.salt = Int32(values["salt"] as? Int ?? -1)
        
        // IMAGE
        if let pickedImage = values["image"] as? UIImage  {
            tankObject.image = pickedImage.pngData()
        }
        
        // EXPECTED WATER PARAMETERS
        if (self.form.rowBy(tag: "calculation") as? SegmentedRow<String>)?.value == "Manual" {
            tankExpectedParameters.tempValueMax = values["max_temp"] as! Double
            tankExpectedParameters.tempValueMin = values["min_temp"] as! Double
            
            tankExpectedParameters.phValueMax = values["max_ph"] as! Double
            tankExpectedParameters.phValueMin = values["min_ph"] as! Double
            
            tankExpectedParameters.ghValueMax = values["max_gh"] as! Double
            tankExpectedParameters.ghValueMin = values["min_gh"] as! Double
            
            tankExpectedParameters.khValueMax = values["max_kh"] as! Double
            tankExpectedParameters.khValueMin = values["min_kh"] as! Double
            
            tankExpectedParameters.cl2ValueMax = values["max_cl2"] as! Double
            tankExpectedParameters.cl2ValueMin = values["min_cl2"] as! Double
            
            tankExpectedParameters.no2ValueMax = values["max_no2"] as! Double
            tankExpectedParameters.no2ValueMin = values["min_no2"] as! Double
            
            tankExpectedParameters.no3ValueMax = values["max_no3"] as! Double
            tankExpectedParameters.no3ValueMin = values["min_no3"] as! Double
        } else {
            tankExpectedParameters.tempValueMax = -1
            tankExpectedParameters.tempValueMin = -1
            
            tankExpectedParameters.phValueMax = -1
            tankExpectedParameters.phValueMin = -1
            
            tankExpectedParameters.ghValueMax = -1
            tankExpectedParameters.ghValueMin = -1
            
            tankExpectedParameters.khValueMax = -1
            tankExpectedParameters.khValueMin = -1
            
            tankExpectedParameters.cl2ValueMax = -1
            tankExpectedParameters.cl2ValueMin = -1
            
            tankExpectedParameters.no2ValueMax = -1
            tankExpectedParameters.no2ValueMin = -1
            
            tankExpectedParameters.no3ValueMax = -1
            tankExpectedParameters.no3ValueMin = -1
            
        }
        
        tankObject.expectedParameters = tankExpectedParameters
        tankObject.measurements = Set<Measurement>.init()
        
        // SAVING
        do {
            try context.save()
        } catch let error as NSError {
            print("Couldn't save new tank: \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
