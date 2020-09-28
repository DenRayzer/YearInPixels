//
//  Service.swift
//  PixelYear
//
//  Created by Елизавета on 30.07.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

fileprivate enum MandarinShowLoginServiceKeys {
    static let host = "https://mandarinshow.ru/api/oauth/action/"
    static let clientIdParam = "client_id"
    static let clientId = "20"
    static let redirectUriParam = "redirect_uri"
    static let redirectUri = "https://example.com"
    static let autorizeEndpoint = "authorize"
    static let tokenEndpoint = "token"
    static let clientSecretParam = "client_secret"
    static let clientSecret = "KxgVD20ozQc6GrlYw3LmBOAhkZXJ9jETMyv1ItPqHS7uC8UbRf5andFsNWipe4"
    static let codeParam = "code"
}

enum APIError: Error {
    case badUrl
    case resultParsingFailed
    case dataCorrupted
}


class MandarinShowLoginService {

    func getAccessToken(with code: String, completion: @escaping (Result<String, Error>) -> Void) {
        let session = URLSession.shared
        guard let url = NetworkHelper.prepareUrl(with: MandarinShowLoginServiceKeys.host,
            for: MandarinShowLoginServiceKeys.tokenEndpoint) else {
            completion(.failure(APIError.badUrl))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let params = [MandarinShowLoginServiceKeys.clientIdParam: MandarinShowLoginServiceKeys.clientId,
            MandarinShowLoginServiceKeys.clientSecretParam: MandarinShowLoginServiceKeys.clientSecret,
            MandarinShowLoginServiceKeys.redirectUriParam: MandarinShowLoginServiceKeys.redirectUri,
            MandarinShowLoginServiceKeys.codeParam: code]

        try? request.setMultipartFormData(params, encoding: String.defaultCStringEncoding)
        session.dataTask(with: request) { data, response, error in
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
        }.resume()
    }

    func autorizePageRequest () -> URLRequest? {
        let params = [MandarinShowLoginServiceKeys.clientIdParam: MandarinShowLoginServiceKeys.clientId,
            MandarinShowLoginServiceKeys.redirectUriParam: MandarinShowLoginServiceKeys.redirectUri]

        guard let requestURL = NetworkHelper.prepareUrl(with: MandarinShowLoginServiceKeys.host,
            for: MandarinShowLoginServiceKeys.autorizeEndpoint,
            params: params) else {
            return nil
        }
        return URLRequest(url: requestURL)
    }

}
