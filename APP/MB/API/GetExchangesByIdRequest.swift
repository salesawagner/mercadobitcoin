//
//  GetExchangesByIdRequest.swift
//  MB
//
//  Created by Wagner Sales on 29/01/24.
//

import API

struct GetExchangesByIdRequest: APIRequest {
    typealias Response = [GetExchangesResponse]

    var httpMethod: APIHTTPMethod {
        .get
    }

    var resourceName: String {
        return "exchanges/\(id)"
    }

    @SkipBody var id: String

    init(id: String) {
        self.id = id
    }
}
