//
//  CarsDetailTableViewController.swift
//  CarDirectory
//
//  Created by Георгий Кашин on 13.10.2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class CarDetailTableViewController: UITableViewController {
    
    // MARK: - Stored Properties
    var car = Car()
    
    // MARK: - IB Outlets
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set title "Add new car" if we want to add a new car or manufacturer of car otherwise
        title = car.manufacturer.isEmpty ? "Add new car" : car.manufacturer
        // Hide keyboard on drag
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
    }

    // MARK: - UI
    /// Enable or disable saveButton depending on whether car manufacturer is impty
    func updateSaveButton() {
        saveButton.isEnabled = !car.manufacturer.isEmpty
    }
}

// MARK: - UITableViewDataSource
extension CarDetailTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return car.keys.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let key = car.capitalizedKeys[section]
        return key
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let value = car.values[section]
        // Get cell for specified value
        let cell = getCellFor(indexPath: indexPath, with: value)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CarDetailTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let value = car.values[indexPath.section]
        return value is Data ? 0.25 * UIScreen.main.bounds.height : UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let value = car.values[indexPath.section]
        // If value is Data -> create alert with image picker controller
        if value is Data {
            // Create alert
            let alert = UIAlertController(title: "Choose Source", message: nil, preferredStyle: .actionSheet)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancel)
            
            // Setup imagePicker
            let imagePicker = SectionImagePickerController()
            imagePicker.delegate = self
            imagePicker.section = indexPath.section
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
                    imagePicker.sourceType = .camera
                    self.present(imagePicker, animated: true)
                }
                alert.addAction(cameraAction)
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let photoAction = UIAlertAction(title: "Photo Library", style: .default) { action in
                    imagePicker.sourceType = .photoLibrary
                    self.present(imagePicker, animated: true)
                }
                alert.addAction(photoAction)
            }
            
            present(alert, animated: true)
        }
        // Deselect selected row
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Cell Configurator
extension CarDetailTableViewController {
    /// Get cell for indexPath with value that defines depending on chosen section
    /// - Parameter indexPath: indexPath
    /// - Parameter value: value of Car class' field with number of chosen section
    func getCellFor(indexPath: IndexPath, with value: Any?) -> UITableViewCell {
        if let dataValue = value as? Data {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! ImageCell
            cell.largeImageView.image = UIImage(data: dataValue)
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
    /// Selector called when a text field changes its value
    /// - Parameter sender: chosen text field
    @objc func textFieldValueChanged(_ sender: SectionTextField) {
        let key = car.keys[sender.section!]
        let text = sender.text ?? ""
        car.setValue(text, forKey: key)
        // Update save button
        updateSaveButton()
    }
}

// MARK: - UIImagePickerControllerDelegate
extension CarDetailTableViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else { return }
        guard let sectionPicker = picker as? SectionImagePickerController else { return }
        guard let section = sectionPicker.section else { return }
        // Set data of image for Car's image key
        let key = car.keys[section]
        let data = image.pngData()
        car.setValue(data, forKey: key)
        // Reload chosen rows
        let indexPath = IndexPath(row: 0, section: section)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        // Update save button
        updateSaveButton()
    }
}

// MARK: - UINavigationControllerDelegate
extension CarDetailTableViewController: UINavigationControllerDelegate {}
