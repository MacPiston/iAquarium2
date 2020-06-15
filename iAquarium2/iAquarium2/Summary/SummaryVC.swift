//
//  SummaryVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 10/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//
import UIKit
import Eureka
import SplitRow
import CoreData

class SummaryVC: FormViewController, passTank {
    
    var tank: Tank?
    var parameters: WaterParameter?
    var measurements: [Measurement]?
    var latestMeasurement: Measurement?
    
    let dateFormatter = DateFormatter()
    
    func finishPassing(selectedTank: Tank) {
        self.tank = selectedTank
        self.parameters = selectedTank.parameters
        print("Summary - passed: \(self.tank?.name)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Summary tank: \(tank?.name), \(tank?.managedObjectContext)")
        fetchTankMeasurements()
        updateFormValues()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }
    
    //MARK: -Form
    func setupForm() {

        form
            +++ Section("Summary")
            <<< LabelRow() {
                $0.title = "Selected tank"
                $0.tag = "selected_tank"
            }
            <<< LabelRow() {
                $0.title = "Status"
                $0.tag = "status"
            }
            <<< LabelRow() {
                $0.title = "Latest measurement"
                $0.tag = "date_last"
            }
            
            +++ Section("Temperature") {
                section in
                section.footer?.height = {15}
                section.header?.height = {15}
            }
            <<< SplitRow<LabelRow, LabelRow>() {
                $0.rowLeftPercentage = 0.5
                $0.tag = "split_temps"
                $0.rowLeft = LabelRow() {
                    $0.title = "Expected"
                    $0.tag = "temp_expected"
                }
                $0.rowRight = LabelRow() {
                    $0.title = "Last"
                    $0.tag = "temp_last"
                }
            }
            
            +++ Section("PH") {
                section in
                section.footer?.height = {15}
                section.header?.height = {15}
        }
            <<< SplitRow<LabelRow, LabelRow>() {
                $0.rowLeftPercentage = 0.5
                $0.tag = "split_ph"
                $0.rowLeft = LabelRow() {
                    $0.title = "Expected"
                }
                
                $0.rowRight = LabelRow() {
                    $0.title = "Last"
                }
            }
            +++ Section("GH") {
                section in
                section.footer?.height = {15}
                section.header?.height = {15}
        }
            <<< SplitRow<LabelRow, LabelRow>() {
                $0.rowLeftPercentage = 0.5
                $0.tag = "split_gh"
                $0.rowLeft = LabelRow() {
                    $0.title = "Expected"
                }
                
                $0.rowRight = LabelRow() {
                    $0.title = "Last"
                }
            }        
            +++ Section("NO#") {
                section in
                section.footer?.height = {15}
                section.header?.height = {15}
        }
            <<< SplitRow<LabelRow, LabelRow>() {
                $0.rowLeftPercentage = 0.5
                $0.tag = "split_nox"
                $0.rowLeft = LabelRow() {
                    $0.title = "NO2 Last"
                }
                
                $0.rowRight = LabelRow() {
                    $0.title = "NO3 Last"
                }
            }
    }
    
    func updateFormValues() {
        dateFormatter.dateFormat = "dd-MM, HH:mm"
        // tank values
        (form.rowBy(tag: "selected_tank") as! LabelRow).value = tank?.name
        (form.rowBy(tag: "split_temps") as! SplitRow<LabelRow, LabelRow>).rowLeft?.value = (parameters?.tempMin.description)! + " - " + (parameters?.tempMax.description)!
        (form.rowBy(tag: "split_ph") as! SplitRow<LabelRow, LabelRow>).rowLeft?.value = parameters?.phValue.description
        (form.rowBy(tag: "split_gh") as! SplitRow<LabelRow, LabelRow>).rowLeft?.value = parameters?.ghValue.description
        
        // last measurement values
        if latestMeasurement != nil {
            (form.rowBy(tag: "date_last") as! LabelRow).value = dateFormatter.string(from: (latestMeasurement?.date)!)
            (form.rowBy(tag: "split_temps") as! SplitRow<LabelRow, LabelRow>).rowRight?.value = latestMeasurement?.parameter?.temp.description
            (form.rowBy(tag: "split_ph") as! SplitRow<LabelRow, LabelRow>).rowRight?.value = latestMeasurement?.parameter?.phValue.description
            (form.rowBy(tag: "split_gh") as! SplitRow<LabelRow, LabelRow>).rowRight?.value = latestMeasurement?.parameter?.ghValue.description
            (form.rowBy(tag: "split_nox") as! SplitRow<LabelRow, LabelRow>).rowLeft?.value = latestMeasurement?.parameter?.no2Value.description
            (form.rowBy(tag: "split_nox") as! SplitRow<LabelRow, LabelRow>).rowRight?.value  = latestMeasurement?.parameter?.no3Value.description
        }
        tableView.reloadData()
    }
    
    func fetchTankMeasurements() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Measurement>(entityName: "Measurement")
        fetchRequest.predicate = NSPredicate(format: "ofTank.name == %@", (tank?.name)!)
        do {
            let data = try context.fetch(fetchRequest)
            measurements = data
            if measurements != nil {
                latestMeasurement = measurements?.first
            }
        } catch let error as NSError {
            print("Couldn't fetch tank's measurements: \(error), \(error.userInfo)")
        }
    }
    
    //MARK: -Navigation
    
    @IBAction func comingFromTankSelector(segue: UIStoryboardSegue) {
        
    }
}
