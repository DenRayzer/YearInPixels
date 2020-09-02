//
//  Extention.swift
//  PixelYear
//
//  Created by Елизавета on 07.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

enum constant {
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
            body.append("--\(boundary)--\(constant.newLine)")

            return body
        }()
    }

    func makeFormField(named name: String, value: String, using boundary: String) -> String {
        var fieldString = "--\(boundary)\(constant.newLine)"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\(constant.newLine)"
        fieldString += constant.newLine
        fieldString += value + constant.newLine

        return fieldString
    }

    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }

}
