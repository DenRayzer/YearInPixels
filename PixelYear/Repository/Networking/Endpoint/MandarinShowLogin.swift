//
//  MandarinShowLogin.swift
//  PixelYear
//
//  Created by Елизавета on 08.09.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

public enum MandarinShowLoginKeys {
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

enum MandarinShowLogin {
    case autorizePage
    case token(code: String)
}

extension MandarinShowLogin: EndpointType {
    var baseURL: URL {
        guard let url = URL(string: MandarinShowLoginKeys.host) else { fatalError("baseURL couldn't be configured") }
        return url
    }

    var path: String {
        switch self {
        case .autorizePage:
            return MandarinShowLoginKeys.autorizeEndpoint
        case .token:
            return MandarinShowLoginKeys.tokenEndpoint
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .autorizePage:
            return .get
        case .token:
            return .post
        }
    }

    var task: HTTPTask {
        switch self {
        case .autorizePage:
            let params = [
                (MandarinShowLoginKeys.clientIdParam, MandarinShowLoginKeys.clientId),
                (MandarinShowLoginKeys.redirectUriParam, MandarinShowLoginKeys.redirectUri)
            ]
            return .requestParameters(urlParameters: params)
        case .token(let code):
            let params = [
                MandarinShowLoginKeys.clientIdParam: MandarinShowLoginKeys.clientId,
                MandarinShowLoginKeys.clientSecretParam: MandarinShowLoginKeys.clientSecret,
                MandarinShowLoginKeys.redirectUriParam: MandarinShowLoginKeys.redirectUri,
                MandarinShowLoginKeys.codeParam: code
            ]
            return .requestWithMultipartFormData(parameters: params)
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }


}

