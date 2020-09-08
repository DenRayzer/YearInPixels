//
//  CalendarHelper.swift
//  PixelYear
//
//  Created by Елизавета on 07.09.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

class CalendarHelper {
    static func getDateString(for date: Date) -> String? {
        let components = date.get(.day, .month, .year)
        guard
            let day = components.day,
            let month = components.month,
            let year = components.year else { return nil }
        let monthString = convertMonth(month: month)
        return "\(day)\(monthString) \(year)"
    }

    static func convertMonth(month: Int) -> String {
        switch month {
        case 1:
            return " Января"
        case 2:
            return " Февраля"
        case 3:
            return " Марта"
        case 4:
            return " Апреля"
        case 5:
            return " Мая"
        case 6:
            return " Июня"
        case 7:
            return " Июля"
        case 8:
            return " Августа"
        case 9:
            return " Сентября"
        case 10:
            return " Октября"
        case 11:
            return " Ноября"
        case 12:
            return " Декабря"
        default:
            return ""
        }
    }
}
