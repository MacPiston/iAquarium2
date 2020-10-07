//
//  MeasurementsVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 18/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit
import Eureka
import TableRow
import CoreData

class MeasurementsVC: FormViewController, passTank {
    var tank: Tank?
    var measurements: [Measurement]?
    var selectedMeasurement: Measurement?
    let dateFormatter = DateFormatter()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dateFormatter.dateFormat = "dd.MM, HH:mm"
        fetchTankMeasurements()
        updateFormValues(reloadData: true)
    }
    
    func finishPassing(selectedTank: Tank) {
        self.tank = selectedTank
    }
    
    func setupForm() {
        form
            +++ Section("Select measurement") {
                section in
                section.header?.height = {30}
            }
            <<< PushRow<Measurement> {
                $0.title = "Mesaurements..."
                $0.tag = "measurement_picker"
                $0.selectorTitle = "Pick a measurement"
                $0.displayValueFor = {
                    guard let measurement = $0 else { return nil }
                    return self.dateFormatter.string(from: measurement.date!)
                }
            }.onChange { cell in
                self.selectedMeasurement = cell.value
                self.updateFormValues(reloadData: true)
            }.onPresent { from, to in
                to.dismissOnChange = true
                to.dismissOnSelection = true
            }
        +++ Section("Measured values:") {
                    section in
                    section.footer?.height = {12}
                    section.header?.height = {12}
               }
            <<< LabelRow() {
                $0.title = VariableFormats.temp
                $0.tag = "temp"
        }
            <<< LabelRow() {
                $0.title = VariableFormats.ph
                $0.tag = "ph"
        }
            <<< LabelRow() {
                $0.title = VariableFormats.gh
                $0.tag = "gh"
        }
            <<< LabelRow() {
                $0.title = VariableFormats.kh
                $0.tag = "kh"
        }
            <<< LabelRow() {
                $0.title = VariableFormats.cl2
                $0.tag = "cl2"
        }
            <<< LabelRow() {
                $0.title = VariableFormats.no2
                $0.tag = "no2"
        }
            <<< LabelRow() {
                $0.title = VariableFormats.no3
                $0.tag = "no3"
        }
        +++ Section("Notes") {
                    section in
                    section.footer?.height = {12}
                    section.header?.height = {12}
            }
            <<< TextAreaRow() {
                $0.title = VariableFormats.notes
                $0.tag = "note"
                $0.textAreaMode = .readOnly
        }
        +++ Section()
            <<< ButtonRow() {
                $0.title = "Delete Measurement"
                $0.tag = "delete_button"
                }.onCellSelection(measurementDeletionHandler(cell:row:))
                .cellUpdate({ cell, row in
                    cell.textLabel?.textColor = .systemRed
                })
    }
    
    private func measurementDeletionHandler(cell: ButtonCellOf<String>, row: ButtonRow) {
        guard let currentMeasurement = selectedMeasurement else { return }
        tank?.removeFromMeasurements(currentMeasurement)
        do {
            try context.save()
        } catch let error as NSError {
            print("Couldn't save context after measurement deletion: \(error), \(error.userInfo)")
        }
        selectedMeasurement = nil
        
        fetchTankMeasurements()
        updateFormValues(reloadData: true)
    }
    
    private func updateFormValues(reloadData: Bool) {
        (form.rowBy(tag: "temp") as! LabelRow).value = selectedMeasurement?.parameter?.temp.description
        (form.rowBy(tag: "ph") as! LabelRow).value = selectedMeasurement?.parameter?.phValue.description
        (form.rowBy(tag: "gh") as! LabelRow).value = selectedMeasurement?.parameter?.ghValue.description
        (form.rowBy(tag: "kh") as! LabelRow).value = selectedMeasurement?.parameter?.khValue.description
        (form.rowBy(tag: "cl2") as! LabelRow).value = selectedMeasurement?.parameter?.cl2Value.description
        (form.rowBy(tag: "no2") as! LabelRow).value = selectedMeasurement?.parameter?.no2Value.description
        (form.rowBy(tag: "no3") as! LabelRow).value = selectedMeasurement?.parameter?.no3Value.description
        (form.rowBy(tag: "note") as! TextAreaRow).value = selectedMeasurement?.note
        (form.rowBy(tag: "measurement_picker") as! PushRow<Measurement>).value = selectedMeasurement
                
        if reloadData {
            self.tableView.reloadData()
        }
    }
    
    private func fetchTankMeasurements() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Measurement>(entityName: "Measurement")
        let pushRow = form.rowBy(tag: "measurement_picker") as! PushRow<Measurement>
        
        fetchRequest.predicate = NSPredicate(format: "ofTank.name == %@", (tank?.name)!)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            let data = try context.fetch(fetchRequest)
            
            measurements = data
            pushRow.options = measurements
            
            if measurements != nil {
                selectedMeasurement = measurements?.first
                pushRow.disabled = false
            } else {
                pushRow.disabled = true
            }
            pushRow.evaluateDisabled()
        } catch let error as NSError {
            print("Couldn't fetch tank's measurements: \(error), \(error.userInfo)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "showAddMeasurement"  {
            if let destinationNC = segue.destination as? UINavigationController {
                if let destinationVC = destinationNC.viewControllers[0] as? AddMeasurementVC {
                    destinationVC.tank = self.tank
                }
            }
        }
    }
    
    @IBAction func unwindToMeasurements(sender: UIStoryboardSegue) {

    }
}
