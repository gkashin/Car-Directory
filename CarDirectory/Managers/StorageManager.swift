//
//  StorageManager.swift
//  CarDirectory
//
//  Created by Георгий Кашин on 13.10.2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class StorageManager {
    
    func loadCars() -> [Car] {
        return [
            Car(releaseYear: "2016", manufacturer: "Nissan", model: "Micra", bodyType: "Universal", image: UIImage(named: "nissan")!),
            Car(releaseYear: "2017", manufacturer: "Toyota", model: "Corolla", bodyType: "Hatchback", image: UIImage(named: "toyota")!),
            Car(releaseYear: "2018", manufacturer: "BMW", model: "M6", bodyType: "Coupe", image: UIImage(named: "bmw")!)
        ]
    }
}
