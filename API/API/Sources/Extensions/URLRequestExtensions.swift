//
//  URLRequestExtensions.swift
//  API
//
//  Created by Wagner Sales on 28/01/24.
//

import Foundation

extension URLRequest {
    var cURL: String {
        guard let url = url else {
            return "Error: URL not found"
        }

        var components = ["curl -v"]

        if let httpMethod = self.httpMethod {
            components.append("-X \(httpMethod)")
        }

        if let allHTTPHeaderFields = self.allHTTPHeaderFields {
            for (key, value) in allHTTPHeaderFields {
                components.append("-H \"\(key): \(value)\"")
            }
        }

        if let httpBody = self.httpBody, let bodyString = String(data: httpBody, encoding: .utf8) {
            components.append("-d '\(bodyString)'")
        }

        components.append("\"\(url.absoluteString)\"")
        return components.joined(separator: " ")
    }
}
