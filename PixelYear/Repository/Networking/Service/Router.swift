//
//  Router.swift
//  PixelYear
//
//  Created by Елизавета on 21.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {

    private var task: URLSessionTask?

    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            session.dataTask(with: request) { data, response, error in
                completion(data, response, error)

            }.resume()
        } catch {
            completion(nil, nil, error)

        }
    }

    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        let url = route.baseURL.appendingPathComponent(route.path)
        var request = URLRequest (url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .requestParameters(let urlParameters): break
            case .requestWithMultipartFormData(let parameters):
                try request.setMultipartFormData(parameters!)
            case .requestHeaders(let additionHeaders): break

            }
        }

        return request
    }

    fileprivate func additionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for(key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
