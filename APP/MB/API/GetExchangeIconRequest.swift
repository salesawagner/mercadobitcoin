//
//  GetExchangeIconRequest.swift
//  MB
//
//  Created by Wagner Sales on 30/01/24.
//

import API

struct GetExchangeIconRequest: APIRequest {
    typealias Response = [GetExchangeIconResponse]

    var httpMethod: APIHTTPMethod {
        .get
    }

    var resourceName: String {
        "exchanges/icons/200"
    }
}

