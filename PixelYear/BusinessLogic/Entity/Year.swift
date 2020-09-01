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
    var months: [[String]]

    init(year: Int, months: [[String]] = [[]]) {
        self.year = year
        if months.isEmpty {
            var month: [[String]] = [[]]
            for i in 1..<12 {
                month.append([])
                for _ in 1..<31 {
                    month[i].append("0")
                }
            }
            self.months = month
            return
        }
        self.months = months
    }
}
