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

    init(year: Int, months: [[Day]] = [[]]) {
        self.year = year
        if months.isEmpty {
            var month: [[Day]] = [[]]
            for i in 1..<13 {
                month.append([])
                for j in 1..<31 {
                    guard let date = YearMapper().makeDate(year: year, month: i, day: j) else { break }
                    let day = Day(date: date, status: "0")
                    month[i].append(day)
                }
            }
            self.months = month
            return
        }
        self.months = months
    }

}

