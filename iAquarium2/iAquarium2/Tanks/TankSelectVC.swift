//
//  TankSelectVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 10/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit
import CoreData
// MARK: - TODO
/*
 - values validation
 */
class TankSelectVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tankTableView: UITableView!
    
    var tanks: [Tank] = []
    var selectedTank: Tank?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tankSummaryDelegate: passTank?
    var tankMeasurementDelegate: passTank?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tankTableView.delegate = self
        tankTableView.dataSource = self
        switchTabsEnabled(state: false)
        tankTableView.rowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchTanks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let indexPath = tankTableView.indexPathForSelectedRow {
            tankTableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    func fetchTanks() {
        do {
            tanks = try context.fetch(NSFetchRequest(entityName: "Tank"))
        } catch {
            print("Failed to fetch tanks")
        }
    }
    
    func switchTabsEnabled(state: Bool) {
        if let arrayOfTabBarItems = tabBarController?.tabBar.items as AnyObject as? NSArray, let summaryItem = arrayOfTabBarItems[1] as? UITabBarItem, let measurementsItem = arrayOfTabBarItems[2] as? UITabBarItem {
            summaryItem.isEnabled = state
            measurementsItem.isEnabled = state
        }
    }
    
    //MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tanks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "tankCell"
        let tank = tanks[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TankTableViewCell else
        {
            fatalError("Couldn't downcast cell")
        }
        
        cell.infoLabel.text = tank.name
        cell.info2Label.text = String(tank.capacity)
        if tank.image != nil {
            cell.imageView?.image = UIImage(data: tank.image!)
        } else {
            cell.imageView?.image = UIImage(systemName: "questionmark")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switchTabsEnabled(state: true)
        if let tankIndex = tankTableView.indexPathForSelectedRow?.row {
            selectedTank = tanks[tankIndex]
            
            self.tankSummaryDelegate = ((tabBarController?.children[1] as? UINavigationController)?.viewControllers[0]) as? SummaryVC
            self.tankSummaryDelegate?.finishPassing(selectedTank: selectedTank!)
            
            self.tankMeasurementDelegate = (tabBarController?.children[2] as? UINavigationController)?.viewControllers[0] as? MeasurementsVC
            self.tankMeasurementDelegate?.finishPassing(selectedTank: selectedTank!)
            
            Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(switchToSummaryTab), userInfo: nil, repeats: false)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let tank = tanks[indexPath.row]
            context.delete(tank)
            do {
                try context.save()
            } catch let error as NSError {
                print("Couldn't delete tank: \(error), \(error.userInfo)")
            }
            fetchTanks()
            tankTableView.reloadData()
        }
    }
            
    //MARK: - Navigation
    @IBAction func unwindToTankSelect(sender: UIStoryboardSegue) {
        fetchTanks()
        tankTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @objc func switchToSummaryTab() {
        tabBarController!.selectedIndex = 1
    }
}

