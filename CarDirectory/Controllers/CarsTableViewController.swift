//
//  CarsTableViewController.swift
//  CarDirectory
//
//  Created by Георгий Кашин on 13.10.2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class CarsTableViewController: UITableViewController {
    
    var cars: [Car] = []
    let storageManager = StorageManager()
    let cellManager = CellManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cars = storageManager.loadCars()
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell’s contents
        let car = cars[indexPath.row]
        cellManager.configure(cell, with: car)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            cars.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            break
        default:
            break
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDetailSegue" else { return }
        guard let destination = segue.destination as? CarDetailTableViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        /// pass selected car to CarDetailViewController
        destination.car = cars[indexPath.row]
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        let source = segue.source as! CarDetailTableViewController
        let car = source.car
        guard let selectedIndex = tableView.indexPathForSelectedRow else {
            cars.append(car)
            tableView.reloadData()
            return
        }
        cars[selectedIndex.row] = car
        tableView.reloadRows(at: [selectedIndex], with: .automatic)
    }
}
