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
    // MARK: - Variables
    var settings: SummarySettingsEntity?
    
    // MARK: - Class stuff

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSummarySettings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        saveSummarySettings()
        let parentNavCon = self.parent as! UINavigationController
        let parentVC = parentNavCon.viewControllers[0] as? SummaryVC
        
        parentVC?.fetchSummarySettings()
        parentVC?.updateChartViews(reloadData: true)
    }
    
    // MARK: - Form
    func setupForm() {
        form
            +++ Section("Charts")
            <<< SwitchRow() {
                $0.tag = "temp_chart"
                $0.title = "Display temperature chart"
            }.cellSetup({ cell, row in
                row.value = self.settings?.tempChartEnabled
            }).onChange({ row in
                self.settings?.tempChartEnabled = row.value!
            })
            
            <<< SwitchRow() {
                $0.tag = "ph_chart"
                $0.title = "Display PH chart"
            }.cellSetup({ cell, row in
                row.value = self.settings?.phChartEnabled
            }).onChange({ row in
                self.settings?.phChartEnabled = row.value!
            })
            
            <<< SwitchRow() {
                $0.tag = "gh_chart"
                $0.title = "Display GH chart"
            }.cellSetup({ cell, row in
                row.value = self.settings?.ghChartEnabled
            }).onChange({ row in
                self.settings?.ghChartEnabled = row.value!
            })
            
            <<< SwitchRow() {
                $0.tag = "no2_chart"
                $0.title = "Display NO2 chart"
            }.cellSetup({ cell, row in
                row.value = self.settings?.no2ChartEnabled
            }).onChange({ row in
                self.settings?.no2ChartEnabled = row.value!
            })
            
            <<< SwitchRow() {
                $0.tag = "no3_chart"
                $0.title = "Display NO3 chart"
            }.cellSetup({ cell, row in
                row.value = self.settings?.no3ChartEnabled
            }).onChange({ row in
                self.settings?.no3ChartEnabled = row.value!
            })
    }
    
    // MARK: - CoreData
    private func fetchSummarySettings() {
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
    
    private func saveSummarySettings() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try context.save()
        } catch let error as NSError {
            print("Couldn't save summary settings: \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
}
