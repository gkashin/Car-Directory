//
//  StorageManager.swift
//  CarDirectory
//
//  Created by Георгий Кашин on 13.10.2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class StorageManager {
    
    // MARK: - Stored Properties
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let archiveURL: URL
    
    // MARK: - Initializers
    init() {
        archiveURL = documentDirectory.appendingPathComponent("cars").appendingPathExtension("plist")
    }
    
    // MARK: - Methods
    /// Save cars to property list
    /// - Parameter cars: array of cars of type Car
    func save(cars: [Car]) {
        let encoder = PropertyListEncoder()
        guard let encodedCars = try? encoder.encode(cars) else { return }
        try? encodedCars.write(to: archiveURL, options: .noFileProtection)
    }
    
    /// Load cars from property list
    func load() -> [Car]? {
        guard let data = try? Data(contentsOf: archiveURL) else { return nil }
        let decoder = PropertyListDecoder()
        return try? decoder.decode([Car].self, from: data)
    }
    
    /// Load cars directly
    func loadCars() -> [Car] {
        return [
            Car(releaseYear: "2016", manufacturer: "BMW", model: "8 Series", bodyType: "Gran-Coupe", imageData: UIImage(named: "bmw")?.pngData()),
            Car(releaseYear: "2017", manufacturer: "Mercedes-Benz", model: "GT", bodyType: "Coupe", imageData: UIImage(named: "mercedes")?.pngData()),
            Car(releaseYear: "2018", manufacturer: "Audi", model: "S7", bodyType: "Saloon", imageData: UIImage(named: "audi")?.pngData())
        ]
    }
}
