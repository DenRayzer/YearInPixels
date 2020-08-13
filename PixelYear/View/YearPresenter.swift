//
//  YearPresenter.swift
//  PixelYear
//
//  Created by Елизавета on 13.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

class YearPresenter {
    private var mandarinShowService: Service

    init(service: Service = MandarinShowService()) {
        self.mandarinShowService = service
    }

    public func getYear(year: Int) -> Year? {
        guard let yearModel = mandarinShowService.getYear(year: year) else {
            print("can't return year")
            return nil
        }
        return mapYear(yearModel: yearModel)
    }

    func mapYear(yearModel: YearModel) -> Year {

        let year = Int(yearModel.year)
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

        var months: [[Int]] = []

        for i in 0..<monthsString.count - 1 {
            let month = monthsString[i]
            months.append([])
            for j in 0..<30 {
                let day: Int = Int(String(month[j]))!
                months[i].append(day)
            }
        }

        return Year(year: year!, months: months)
    }
}
