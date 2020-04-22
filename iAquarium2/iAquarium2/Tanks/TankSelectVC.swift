//
//  TankSelectVC.swift
//  iAquarium2
//
//  Created by Maciej Zajecki on 10/04/2020.
//  Copyright © 2020 Maciej Zajecki. All rights reserved.
//

import UIKit

class TankSelectVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tankTableView: UITableView!
    var selectedTank : Tank?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DataManager.tanksArray += [Tank(newName: "Test", newBrand: "Test2", newCapacity: 50, newWaterType: "normal", newSaltAmount: 0)]
        tankTableView.delegate = self
        tankTableView.dataSource = self
        switchTabsEnabled(state: false)
    }
    
    func switchTabsEnabled(state : Bool) {
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
        return DataManager.tanksArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "tankCell"
        guard let cell:TankTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TankTableViewCell else
        {
            fatalError("Couldn't downcast cell")
        }
        
        let tank = DataManager.tanksArray[indexPath.row]
        cell.infoLabel.text = tank.brand + ": " + tank.name
        cell.info2Label.text = String(tank.capacity) + "L, Water: " + tank.waterType
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataManager.selectedTank = DataManager.tanksArray[indexPath.row]
        switchTabsEnabled(state: true)
    }
    
    //MARK: - Navigation
    @IBAction func unwindToTankSelect(sender: UIStoryboardSegue) {
        if let sourceVC = sender.source as? AddTankVC, let tank = sourceVC.newTank {
            let newIndexPath = IndexPath(row: DataManager.tanksArray.count, section: 0)
            DataManager.tanksArray += [tank]
            tankTableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}

