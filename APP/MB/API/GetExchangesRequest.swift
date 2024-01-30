//
//  GetExchangesRequest.swift
//  MB
//
//  Created by Wagner Sales on 29/01/24.
//

import API

struct GetExchangesRequest: APIRequest {
    typealias Response = [GetExchangesResponse]

    var httpMethod: APIHTTPMethod {
        .get
    }

    var resourceName: String {
        "exchanges"
    }
}

