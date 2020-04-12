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

    var tanksArray = [Tank]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tanksArray += [Tank(newName: "Test", newBrand: "Test2", newCapacity: 50, newWaterType: "normal", newSaltAmount: 0)]
        tankTableView.delegate = self
        tankTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tanksArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "tankCell"
        guard let cell:TankTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TankTableViewCell else
        {
            fatalError("Couldn't downcast cell")
        }
        
        let tank = tanksArray[indexPath.row]
        cell.infoLabel.text = tank.brand + ": " + tank.name
        cell.info2Label.text = String(tank.capacity) + "L, Water: " + tank.waterType
        return cell
    }
    
    @IBAction func unwindToTankSelect(sender: UIStoryboardSegue) {
        if let sourceVC = sender.source as? AddTankVC, let tank = sourceVC.newTank {
            let newIndexPath = IndexPath(row: tanksArray.count, section: 0)
            tanksArray += [tank]
            tankTableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}

