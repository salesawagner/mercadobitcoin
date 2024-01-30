@testable import API

class Environment: APIEnvironment {
    var apiKey: String
    var domainURL: URL?
    var type: API.APIEnvironmentType

    init(apiKey: String, domainURL: URL? = nil, type: API.APIEnvironmentType) {
        self.apiKey = apiKey
        self.domainURL = domainURL
        self.type = type
    }
}

// MARK: - Utils

extension Environment {
    static var local = Environment(apiKey: "", type: .local)
}
