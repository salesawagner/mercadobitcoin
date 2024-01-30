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
