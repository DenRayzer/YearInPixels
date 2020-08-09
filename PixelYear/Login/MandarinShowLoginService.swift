//
//  Service.swift
//  PixelYear
//
//  Created by Елизавета on 30.07.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//щф

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

class MandarinShowLoginService {

    func getAccessToken(with code: String) -> String? {
        let session = URLSession.shared
        let semaphore = DispatchSemaphore(value: 0)
        guard let url = prepareUrl(for: MandarinShowLoginServiceKeys.tokenEndpoint) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var token: String?
        let params = [MandarinShowLoginServiceKeys.clientIdParam: MandarinShowLoginServiceKeys.clientId,
                      MandarinShowLoginServiceKeys.clientSecretParam: MandarinShowLoginServiceKeys.clientSecret,
                      MandarinShowLoginServiceKeys.redirectUriParam: MandarinShowLoginServiceKeys.redirectUri,
                      MandarinShowLoginServiceKeys.codeParam: code]

        try? request.setMultipartFormData(params, encoding: String.defaultCStringEncoding)

        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            do {
                let answer = try JSONDecoder().decode(AutorizeAnswer.self, from: data!)
                token = answer.token

            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
            semaphore.signal()
        })

        task.resume()
        _ = semaphore.wait(timeout: .distantFuture)

        return token
    }

    func autorizePageRequest () -> URLRequest? {
        let params = [MandarinShowLoginServiceKeys.clientIdParam: MandarinShowLoginServiceKeys.clientId,
                      MandarinShowLoginServiceKeys.redirectUriParam: MandarinShowLoginServiceKeys.redirectUri]

        guard let requestURL = prepareUrl(for: MandarinShowLoginServiceKeys.autorizeEndpoint, params: params) else {
            return nil
        }
        return URLRequest(url: requestURL)
    }

    private func prepareUrl(for endpoint: String, params: [String: Any] = [:]) -> URL? {
        guard var components = URLComponents(string: MandarinShowLoginServiceKeys.host) else {
            return nil
        }
        let requestParams = params

        components.path.append(endpoint)
        components.queryItems = requestParams.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
        return components.url
    }
    
}

