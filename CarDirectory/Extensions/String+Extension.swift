//
//  String+Extension.swift
//  CarDirectory
//
//  Created by Георгий Кашин on 13.10.2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import Foundation

extension String {
    var capitalizedWithSpaces: String {
        let withSpaces = reduce("") { result, character in
            character.isUppercase ? "\(result) \(character)" : "\(result)\(character)"
        }
        
        return withSpaces.capitalized
    }
}
