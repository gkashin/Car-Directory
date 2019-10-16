//
//  Car.swift
//  CarDirectory
//
//  Created by Георгий Кашин on 13.10.2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

@objcMembers class Car: NSObject {
    var image = UIImage()
    var releaseYear = ""
    var manufacturer = ""
    var model = ""
    var bodyType = ""
    
    init(
        releaseYear: String = "",
        manufacturer: String = "",
        model: String = "",
        bodyType: String = "",
        image: UIImage = UIImage()
    ) {
        self.releaseYear = releaseYear
        self.manufacturer = manufacturer
        self.model = model
        self.bodyType = bodyType
        self.image = image
    }
    
    var capitilizedKeys: [String] {
        return keys.map { $0.capitalizedWithSpaces }
    }
    
    var keys: [String] {
        return Mirror(reflecting: self).children.compactMap { $0.label }
    }
    
    var values: [Any?] {
        return Mirror(reflecting: self).children.map { $0.value }
    }
}
