//
//  StorageManager.swift
//  CarDirectory
//
//  Created by Георгий Кашин on 13.10.2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class StorageManager {
    
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let archiveURL: URL
    
    init() {
        archiveURL = documentDirectory.appendingPathComponent("cars").appendingPathExtension("plist")
    }
    
    func save(cars: [Car]) {
        let encoder = PropertyListEncoder()
        guard let encodedCars = try? encoder.encode(cars) else { return }
        try? encodedCars.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() -> [Car]? {
        guard let data = try? Data(contentsOf: archiveURL) else { return nil }
        let decoder = PropertyListDecoder()
        return try? decoder.decode([Car].self, from: data)
    }
    
    func loadCars() -> [Car] {
        return [
            Car(releaseYear: "2016", manufacturer: "Nissan", model: "Micra", bodyType: "Universal", imageData: UIImage(named: "nissan")?.pngData()),
            Car(releaseYear: "2017", manufacturer: "Toyota", model: "Corolla", bodyType: "Hatchback", imageData: UIImage(named: "toyota")?.pngData()),
            Car(releaseYear: "2018", manufacturer: "BMW", model: "M6", bodyType: "Coupe", imageData: UIImage(named: "bmw")?.pngData())
        ]
    }
}
