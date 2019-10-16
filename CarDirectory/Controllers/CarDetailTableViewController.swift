//
//  CarsDetailTableViewController.swift
//  CarDirectory
//
//  Created by Георгий Кашин on 13.10.2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class CarDetailTableViewController: UITableViewController {
    
    var car = Car()
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - UI
    func updateUI() {
        
    }
    
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return car.keys.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let key = car.capitilizedKeys[section]
        return key
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let value = car.values[section]
        let cell = getCellFor(indexPath: indexPath, with: value)
        return cell
    }
}

// MARK: - Cell Configurator
extension CarDetailTableViewController {
    func getCellFor(indexPath: IndexPath, with value: Any?) -> UITableViewCell {
        if let imageValue = value as? UIImage {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! ImageCell
            cell.largeImageView.image = imageValue
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell") as! TextFieldCell
            let stringValue = value as? String
            cell.textField.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
            cell.textField.text = stringValue
            cell.textField.section = indexPath.section
            return cell
        }
    }
}

// MARK: - Actions
extension CarDetailTableViewController {
    @objc func textFieldValueChanged(_ sender: SectionTextField) {
        let key = car.keys[sender.section!]
        let text = sender.text ?? ""
        car.setValue(text, forKey: key)
        
        // TODO: - Setup save button appropriate
        
        if car.value(forKey: "manufacturer") {
            saveButton.isEnabled = true
        }
    }
}
