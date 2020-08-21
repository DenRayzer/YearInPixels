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
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestWithMultipartFormData(let parameters):
                try request.setMultipartFormData(parameters ?? [:])
            case .requestParametersHeaders(let urlParameters, let additionHeaders):
                if let params = urlParameters { self.configureParameters(params, urlRequest: &request) }
                if let headers = additionHeaders { self.additionalHeaders(headers, request: &request) }
            }
        }
        return request
    }

    fileprivate func configureParameters(_ urlParameters: Parameters, urlRequest: inout URLRequest) {
        guard let url = urlRequest.url else { return }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }

        components.queryItems = urlParameters.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
        urlRequest.url = components.url
    }

    fileprivate func additionalHeaders(_ additionalHeaders: HTTPHeaders, request: inout URLRequest) {
        for(key, value) in additionalHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
