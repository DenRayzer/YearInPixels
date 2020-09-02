//
//  MandarinShowManager.swift
//  PixelYear
//
//  Created by Елизавета on 25.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

class MandarinShowService: Manager {

    let router: Router<MandarinShow>
    let mapper: YearMapper

    init(mapper: YearMapper = YearMapper(), router: Router<MandarinShow> = Router<MandarinShow>()) {
        self.mapper = mapper
        self.router = router
    }

    func getYear(year: Int, completion: @escaping (Result<Year, Error>) -> Void) {
        router.request(.getYear(year: year)) {
            data, response, error in
            if let currentError = error {
                completion(.failure(currentError))
            }
            guard let resultData = data,
                let yearsModels = try? JSONDecoder().decode([YearModel].self, from: resultData) else {
                    completion(.failure(APIError.resultParsingFailed))
                    return
            }
            if !yearsModels.isEmpty {
                guard let year = self.mapper.convertYearModel(yearModel: yearModel) else { return }
            }

            completion(.success(year))
        }
    }

    func setDay(day: Day, completion: @escaping (Result<Data?, Error>) -> Void) {
        router.request(.setDay(day: day)) {
            data, response, error in
            if let currentError = error {
                completion(.failure(currentError))
            }
            completion(.success(data))
        }
    }

}

