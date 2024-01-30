//
//  WASAPIMock.swift
//  MBTests
//
//  Created by Wagner Sales on 29/01/24.
//

import Foundation
import API

final class WASAPIMock: APIClient {
    func send<T>(_ request: T, completion: @escaping ResultCallback<T.Response>) where T: APIRequest {
        completion(.failure(.invalidParam))
    }
}
