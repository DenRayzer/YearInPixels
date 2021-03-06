//
//  Year.swift
//  PixelYear
//
//  Created by Елизавета on 10.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

struct Year {
    let year: Int
    var months: [[Day]]

    init(year: Int, months: [[Day]]) {
        self.year = year
        self.months = months
    }

}
