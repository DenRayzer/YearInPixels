//
//  File.swift
//  PixelYear
//
//  Created by Елизавета on 08.09.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

class MandarinShowLoginService {
    let router: Router<MandarinShowLogin>

    init(router: Router<MandarinShowLogin> = Router<MandarinShowLogin>()) {
        self.router = router
    }

    func getAccessToken(with code: String, completion: @escaping (Result<String, Error>) -> Void) {
        router.request(.token(code: code)) {
            data, response, error in
            if let currentError = error {
                completion(.failure(currentError))
                return
            }
            guard let resultData = data,
                let answer = try? JSONDecoder().decode(AutorizeAnswer.self, from: resultData) else {
                    completion(.failure(APIError.resultParsingFailed))
                    return
            }
            let token = answer.token
            completion(.success(token))
        }
    }

    func autorizePageRequest() -> URLRequest? {
        return try? router.buildRequest(from: MandarinShowLogin.autorizePage)
    }

}

