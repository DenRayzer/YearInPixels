//
//  MandarinShow.swift
//  PixelYear
//
//  Created by Елизавета on 25.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

enum MandarinShowKeys {
    static let host = "https://mandarinshow.ru/api/app-pixels/year/"
    static let authorizationParam = "Authorization"
    static let yearParam = "year"
    static let monthParam = "month"
    static let dayParam = "day"
    static let infoParam = "info"
}

enum MandarinShow {
    case getYear(year: Int)
    case setDay(day: Day)
}

extension MandarinShow: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: MandarinShowKeys.host) else { fatalError("baseURL couldn't be configured") }
        return url
    }

    var path: String {
        switch self {
        case .getYear(let year):
            return String(year)

        case .setDay(let day):
            let year = day.date.get(.year)
            return "year/\(year)/type/update"
        }
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        switch self {
        case .getYear(_):
            return .requestParametersHeaders(urlParameters: nil)
        case .setDay(let dayToset):
            let year = String(dayToset.date.get(.year))
            let month = String(dayToset.date.get(.month))
            let day = String(dayToset.date.get(.day))
            let params = [MandarinShowKeys.yearParam: year,
                MandarinShowKeys.monthParam: month,
                MandarinShowKeys.dayParam: day,
                MandarinShowKeys.infoParam: dayToset.status]
            return .requestParametersHeaders(urlParameters: params)
        }
    }

    var headers: HTTPHeaders? {
        guard let token = SensitiveDataService().getMandarinShowToken() else { return nil }
        return [MandarinShowKeys.authorizationParam: token]
    }


}
