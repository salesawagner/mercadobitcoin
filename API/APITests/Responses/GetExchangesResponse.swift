import API

struct GetExchangesResponse: Decodable {
    let exchangeID: String?
    let website: String?
    let name: String
    let dataQuoteStart: String?

    enum CodingKeys: String, CodingKey {
        case exchangeID = "exchange_id"
        case website
        case name
        case dataQuoteStart = "data_quote_start"
    }
}
