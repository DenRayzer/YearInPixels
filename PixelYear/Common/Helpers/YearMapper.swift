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

           var months: [[String]] = []

           for i in 0..<monthsString.count - 1 {
               let month = monthsString[i]
               months.append([])
               for j in 0..<30 {
                   let day = String(month[j])
                   months[i].append(day)
               }
           }
           return Year(year: year, months: months)
    }
}
