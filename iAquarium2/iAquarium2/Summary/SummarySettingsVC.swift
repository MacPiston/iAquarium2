//
//  SummarySettingsVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 24/09/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit
import Eureka
import CoreData

class SummarySettingsVC: FormViewController {

    // MARK: - Class stuff
    var settings: SummarySettingsEntity?
    
    override func viewWillAppear(_ animated: Bool) {
        fetchSummarySettings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }
    
    // MARK: - Form
    func setupForm() {
        form
            +++ Section("Charts")
            <<< SwitchRow() {
                $0.tag = "temp_chart"
                $0.title = "Display temperature chart"
            }.cellSetup(getSwitchValue(cell:row:))
            <<< SwitchRow() {
                $0.tag = "ph_chart"
                $0.title = "Display PH chart"
            }
            <<< SwitchRow() {
                $0.tag = "gh_chart"
                $0.title = "Display GH chart"
            }
            <<< SwitchRow() {
                $0.tag = "no2_chart"
                $0.title = "Display NO2 chart"
            }
            <<< SwitchRow() {
                $0.tag = "no3_chart"
                $0.title = "Display NO3 chart"
            }
    }
    
    private func getSwitchValue(cell: SwitchCell, row: SwitchRow) {
    }
    
    // MARK: - CoreData
    func fetchSummarySettings() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<SummarySettingsEntity>(entityName: "SummarySettingsEntity")
        
        do {
            let data = try context.fetch(fetchRequest)
            
            if data.isEmpty {
                settings = SummarySettingsEntity(context: context)
            } else {
                settings = data.first
            }
            
        } catch let error as NSError {
            print("Couldn't fetch summary settings: \(error), \(error.userInfo)")
        }
    }
    
    func createSettingsEntityFromForm() {
        settings?.tempChartEnabled = form.values()["temp_chart"] as! Bool
        settings?.phChartEnabled = form.values()["ph_chart"] as! Bool
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try context.save()
        } catch let error as NSError {
            print("Couldn't save summary settings: \(error), \(error.userInfo)")
        }
    }
}
