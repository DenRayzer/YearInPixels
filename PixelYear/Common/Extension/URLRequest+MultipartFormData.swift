//
//  File.swift
//  PixelYear
//
//  Created by Елизавета on 08.09.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

enum Constant {
    static let newLine = "\r\n"
}

extension URLRequest {
    public mutating func setMultipartFormData(_ parameters: Parameters, encoding: String.Encoding = String.defaultCStringEncoding) throws {
        let boundary = generateBoundary()
        setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        httpBody = {
            var body = Data()
            parameters
                .map { makeFormField(named: $0.key, value: $0.value, using: boundary) }
                .forEach { body.append($0) }
            body.append("--\(boundary)--\(Constant.newLine)")

            return body
        }()
    }

    func makeFormField(named name: String, value: String, using boundary: String) -> String {
        var fieldString = "--\(boundary)\(Constant.newLine)"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\(Constant.newLine)"
        fieldString += Constant.newLine
        fieldString += value + Constant.newLine

        return fieldString
    }

    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }

}
