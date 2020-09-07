//
//  YearMapper.swift
//  PixelYear
//
//  Created by Елизавета on 17.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

class YearMapper {
    func convertYearModel(yearModel: YearModel) -> Year? {
        guard let year = Int(yearModel.year) else {
            print("data is corrupted")
            return nil
        }
           var monthsString: [String] = []

           monthsString.append(yearModel.jan)
           monthsString.append(yearModel.feb)
           monthsString.append(yearModel.mar)
           monthsString.append(yearModel.apr)
           monthsString.append(yearModel.may)
           monthsString.append(yearModel.jun)
           monthsString.append(yearModel.jul)
           monthsString.append(yearModel.aug)
           monthsString.append(yearModel.sep)
           monthsString.append(yearModel.oct)
           monthsString.append(yearModel.nov)
           monthsString.append(yearModel.dec)

           var months: [[Day]] = []

           for i in 0..<monthsString.count {
               let month = monthsString[i]
               months.append([])
            for j in 0..<monthsString[i].count {
                guard let date = makeDate(year: year, month: i + 1, day: j + 1) else { break }
                let day = Day(date: date, status: String(month[j]))
                   months[i].append(day)
               }
           }
           return Year(year: year, months: months)
    }

    func makeDate(year: Int, month: Int, day: Int) -> Date? {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy/MM/dd"

        guard let date = formatter.date(from: "\(year)/\(month)/\(day)") else { return nil }
           return date

       }
}
