//
//  APIRequest.swift
//  API
//
//  Created by Wagner Sales on 05/12/23.
//

import Foundation

public protocol APIRequest: Encodable {
    associatedtype Response: Decodable

    var httpMethod: APIHTTPMethod { get }
    var resourceName: String { get }
}
