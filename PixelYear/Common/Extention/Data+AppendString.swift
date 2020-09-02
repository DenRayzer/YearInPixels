//
//  Data.swift
//  PixelYear
//
//  Created by Елизавета on 30.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }

}
