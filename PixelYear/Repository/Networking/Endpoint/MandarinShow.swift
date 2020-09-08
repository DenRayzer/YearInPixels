//
//  MandarinShow.swift
//  PixelYear
//
//  Created by Елизавета on 08.09.2020.
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

extension MandarinShow: EndpointType {
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
            return "\(year)/type/update"
        }
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        switch self {
        case .getYear(_):
            return .requestParameters(urlParameters: nil)
        case .setDay(let day):
            let yearString = String(day.date.get(.year))
            let monthString = String(day.date.get(.month) - 1)
            let dayString = String(day.date.get(.day) - 1)
            let params = [
                (MandarinShowKeys.yearParam, yearString),
                (MandarinShowKeys.monthParam, monthString),
                (MandarinShowKeys.dayParam, dayString),
                (MandarinShowKeys.infoParam, day.status)
            ]
            return .requestParameters(urlParameters: params)
        }
    }

    var headers: HTTPHeaders? {
        guard let token = SensitiveDataService().getMandarinShowToken() else { return nil }
        return [MandarinShowKeys.authorizationParam: "Bearer \(token)"]
    }

}
