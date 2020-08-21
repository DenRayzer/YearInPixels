//
//  MandarinShowLoginEndPoint.swift
//  PixelYear
//
//  Created by Елизавета on 21.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

public enum MandarinShowLoginEndPoint {
    case autorizePage
    case token(code: String)
}

extension MandarinShowLoginEndPoint: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: MandarinShowLoginServiceKeys.host) else { fatalError("baseURL couldn't be configured") }
        return url
    }

    var path: String {
        switch self {
        case .autorizePage:
            return MandarinShowLoginServiceKeys.autorizeEndpoint
        case .token:
            return MandarinShowLoginServiceKeys.tokenEndpoint
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
            let params = [MandarinShowLoginServiceKeys.clientIdParam: MandarinShowLoginServiceKeys.clientId,
                MandarinShowLoginServiceKeys.redirectUriParam: MandarinShowLoginServiceKeys.redirectUri]
            return .requestParametersHeaders(urlParameters: params, additionHeaders: nil)
        case .token(let code):
            let params = [MandarinShowLoginServiceKeys.clientIdParam: MandarinShowLoginServiceKeys.clientId,
                MandarinShowLoginServiceKeys.clientSecretParam: MandarinShowLoginServiceKeys.clientSecret,
                MandarinShowLoginServiceKeys.redirectUriParam: MandarinShowLoginServiceKeys.redirectUri,
                MandarinShowLoginServiceKeys.codeParam: code]
            return .requestWithMultipartFormData(parameters: params)

        }
    }

    var headers: HTTPHeaders? {
        return nil
    }


}
