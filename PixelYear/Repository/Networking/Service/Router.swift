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
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        do {
            let request = try self.buildRequest(from: route)
            session.dataTask(with: request) { data, response, error in
                completion(data, response, error)

            }.resume()
        } catch {
            completion(nil, nil, error)
        }
    }

    func buildRequest(from route: EndPoint) throws -> URLRequest {
        let url = route.baseURL.appendingPathComponent(route.path)
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        request.httpMethod = route.httpMethod.rawValue

        switch route.task {
        case .requestWithMultipartFormData(let parameters):
            do {
                try request.setMultipartFormData(parameters ?? [:])
            }
        case .requestParametersHeaders(let urlParameters):
            if let params = urlParameters { request.url = self.configureParameters(params, url: url) }
            route.headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        }
        return request
    }

    private func configureParameters(_ urlParameters: Parameters, url: URL) -> URL? {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        components.queryItems = urlParameters.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
        return components.url
    }

}
