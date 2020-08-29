//
//  Manager.swift
//  PixelYear
//
//  Created by Елизавета on 23.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

struct MandarinShowLoginManager {
      let router = Router<MandarinShowLogin>()

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
