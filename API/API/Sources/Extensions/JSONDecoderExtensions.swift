//
//  JSONDecoderExtensions.swift
//  API
//
//  Created by Wagner Sales on 24/01/24.
//

import Foundation

extension JSONDecoder {
    func httpRequest<R: APIRequest>(request: R, data: Data) throws -> R.Response {
        try self.decode(R.Response.self, from: data)
    }
}
