//
//  MandarinShowService.swift
//  PixelYear
//
//  Created by Елизавета on 08.09.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

class MandarinShowService: CalendarService {
    let router: Router<MandarinShow>
    let mapper: YearMapper

    init(mapper: YearMapper = YearMapper(), router: Router<MandarinShow> = Router<MandarinShow>()) {
        self.mapper = mapper
        self.router = router
    }

    func getYear(yearDate: Int, completion: @escaping (Result<Year, Error>) -> Void) {
        router.request(.getYear(year: yearDate)) {
            data, response, error in
            if let currentError = error {
                completion(.failure(currentError))
            }
            guard
                let resultData = data,
                let yearsModels = try? JSONDecoder().decode([YearModel].self, from: resultData),
                let yearModel = yearsModels.first
                else {
                    completion(.failure(APIError.resultParsingFailed))
                    return
            }
            guard let year = self.mapper.convertYearModel(yearModel: yearModel) else {
                completion(.failure(APIError.resultParsingFailed))
                return
            }
            completion(.success(year))
        }
    }

    func setDay(day: Day, completion: @escaping (Result<Void, Error>) -> Void) {
        router.request(.setDay(day: day)) {
            data, response, error in
            if let currentError = error {
                completion(.failure(currentError))
            }
            completion(.success(Void()))
        }
    }

}
