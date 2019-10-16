//
//  CellManager.swift
//  CarDirectory
//
//  Created by Георгий Кашин on 13.10.2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit

class CellManager {
    
    func configure(_ cell: UITableViewCell, with car: Car) {
        cell.textLabel?.text = car.manufacturer
        guard let data = car.image else { return }
        cell.imageView?.image = UIImage(data: data)
    }
}
