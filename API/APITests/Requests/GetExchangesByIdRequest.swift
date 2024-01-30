import API

struct GetExchangesByIdRequest: APIRequest {
    typealias Response = [GetExchangesResponse]

    var httpMethod: APIHTTPMethod {
        .get
    }

    var resourceName: String {
        return "exchanges/\(id)"
    }

    var id: String

    init(id: String) {
        self.id = id
    }
}
