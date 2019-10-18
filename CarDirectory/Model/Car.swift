//
//  Car.swift
//  CarDirectory
//
//  Created by Георгий Кашин on 13.10.2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

@objcMembers class Car: NSObject, Codable {
    // MARK: - Stored Properties
    var manufacturer: String
    var model: String
    var releaseYear: String
    var bodyType: String
    var image: Data?
    
    // MARK: - Computed Properties
    var encoded: Data? {
        let encoder = PropertyListEncoder()
        return try? encoder.encode(self)
    }
    
    var capitalizedKeys: [String] {
        return keys.map { $0.capitalizedWithSpaces }
    }
    
    // Fields of Car class for dynamically changes of table
    var keys: [String] {
        return Mirror(reflecting: self).children.compactMap { $0.label }
    }
    
    // Values of Car class fields for dynamically changes of table
    var values: [Any?] {
        return Mirror(reflecting: self).children.map { $0.value }
    }
    
    // MARK: - Initializers
    convenience init?(from data: Data) {
        let decoder = PropertyListDecoder()
        guard let car = try? decoder.decode(Car.self, from: data) else { return nil }
        self.init(
            releaseYear: car.releaseYear,
            manufacturer: car.manufacturer,
            model: car.model,
            bodyType: car.bodyType,
            imageData: car.image
        )
    }
    
    init(
        releaseYear: String = "",
        manufacturer: String = "",
        model: String = "",
        bodyType: String = "",
        imageData: Data? = UIImage(named: "default")?.pngData()
    ) {
        self.releaseYear = releaseYear
        self.manufacturer = manufacturer
        self.model = model
        self.bodyType = bodyType
        self.image = imageData
    }
}
