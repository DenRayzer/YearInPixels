//
//  MandarinShowServicw.swift
//  PixelYear
//
//  Created by Елизавета on 10.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

fileprivate enum MandarinShowServiceKeys {
    static let host = "https://mandarinshow.ru/api/app-pixels/year/"
}

class MandarinShowService: Service {

    let mapper: YearMapper

    init(mapper: YearMapper = YearMapper()) {
        self.mapper = mapper
    }

    func getYear(year: Int, completion: ((Result<Year, Error>) -> Void)?) {
        guard let completion = completion else { return }
        guard let url = NetworkHelper.prepareUrl(with: MandarinShowServiceKeys.host,
            for: "\(year)/") else {
            completion(.failure(APIError.badUrl))
            return
        }

        guard let request = getYearsRequest(url: url) else {
            completion(.failure(APIError.badUrl))
            return
        }

        let session = URLSession.shared
        session.dataTask(with: request) {
            data, response, error in

            if let currentError = error {
                completion(.failure(currentError))
                return
            }
            guard
                let resultData = data,
                let answer = try? JSONDecoder().decode([YearModel].self, from: resultData),
                let year = self.mapper.convertYearModel(yearModel: answer[0])
                else {
                    completion(.failure(APIError.resultParsingFailed))
                    return
            }
            completion(.success(year))
        }.resume()
    }

    func getYearsRequest(url: URL) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let token = SensitiveDataService().getMandarinShowToken() else { return nil }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }

    func setDay() { }
}
