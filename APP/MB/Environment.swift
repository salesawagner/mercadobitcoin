//
//  Environment.swift
//  MB
//
//  Created by Wagner Sales on 07/12/23.
//

import API

class Environment: APIEnvironment {
    var apiKey: String
    var domainURL: URL?
    var type: API.APIEnvironmentType

    init(apiKey: String, domainURL: URL? = nil, type: API.APIEnvironmentType) {
        self.apiKey = apiKey
        self.domainURL = domainURL
        self.type = type
    }

    // FIXME: Colocar no plist ?

    static var local = Environment(apiKey: "", type: .local)
    static var production = Environment(
        apiKey: "A2CC1F18-478B-4F2C-AFB2-E9D0A236B840",
        domainURL: URL(string: "https://rest.coinapi.io/v1/"),
        type: .production
    )
}
