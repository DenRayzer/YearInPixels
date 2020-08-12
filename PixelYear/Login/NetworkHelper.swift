//
//  NetworkHelper.swift
//  PixelYear
//
//  Created by Елизавета on 10.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation
class NetworkHelper {

    static func prepareUrl(with host: String, for endpoint: String, params: [String: Any] = [:]) -> URL? {
        guard var components = URLComponents(string: host) else {
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

