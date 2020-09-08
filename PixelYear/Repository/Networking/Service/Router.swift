//
//  Router.swift
//  PixelYear
//
//  Created by Елизавета on 08.09.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

class Router<EndPoint: EndpointType>: NetworkRouter {
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)

    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        do {
            guard let request = try self.buildRequest(from: route) else {
                completion(nil, nil, APIError.badUrl)
                return
            }
            session.dataTask(with: request) { data, response, error in
                completion(data, response, error)
            }.resume()
        } catch {
            completion(nil, nil, error)
        }
    }

    func buildRequest(from route: EndPoint) throws -> URLRequest? {
        let url = route.baseURL.appendingPathComponent(route.path)
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        request.httpMethod = route.httpMethod.rawValue

        switch route.task {
        case .requestWithMultipartFormData(let parameters):
            do {
                try request.setMultipartFormData(parameters ?? [:])
            }
        case .requestParameters(let urlParameters):
            if let params = urlParameters {
                if let newUrl = configureParameters(params, url: url) {
                    request.url = newUrl
                } else { return nil }
            }
            route.headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        }
        return request
    }

    private func configureParameters(_ urlParameters: [(String, String)], url: URL) -> URL? {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        components.queryItems = []

//        for i in urlParameters {
//            print ("key \(i.key) \(i.value)  ")
//            let item = URLQueryItem(name: i.key, value: i.value)
//            components.queryItems?.append(item)
//        }
        components.queryItems = urlParameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        return components.url
    }
}

