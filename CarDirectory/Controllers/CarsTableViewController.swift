//
//  CarsTableViewController.swift
//  CarDirectory
//
//  Created by Георгий Кашин on 13.10.2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class CarsTableViewController: UITableViewController {
    
    // MARK: - Stored Properties
    var cars: [Car]! {
        didSet {
            storageManager.save(cars: cars)
        }
    }
    let storageManager = StorageManager()
    let cellManager = CellManager()
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load cars either from property list or directly from StorageManager class
        cars = storageManager.load() ?? storageManager.loadCars()
    }
}

// MARK: - UITableViewDataSource
extension CarsTableViewController {
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
}

// MARK: - UITableViewDelegate
extension CarsTableViewController {
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
}

// MARK: - Navigation
extension CarsTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toDetailSegue" else { return }
        guard let destination = segue.destination as? CarDetailTableViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        // Pass selected car to CarDetailTableViewController
        destination.car = cars[indexPath.row]
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        let source = segue.source as! CarDetailTableViewController
        let car = source.car
        // If row wasn't selected - append new car to cars
        guard let selectedIndex = tableView.indexPathForSelectedRow else {
            cars.append(car)
            tableView.reloadData()
            return
        }
        // If row was selected - update car information by selected index
        cars[selectedIndex.row] = car
        tableView.reloadRows(at: [selectedIndex], with: .automatic)
    }
}
