//
//  GetExchangesResponse.swift
//  MB
//
//  Created by Wagner Sales on 29/01/24.
//

struct GetExchangesResponse: Decodable {
    let exchangeID: String?
    let website: String?
    let name: String?
    let dataQuoteStart: String?
    let dataQuoteEnd: String?
    let dataOrderbookStart: String?
    let dataOrderbookEnd: String?
    let dataTradeStart: String?
    let dataTradeEnd: String?
    let dataSymbolsCount: Int?
    let volume1HrsUsd: Double?
    let volume1DayUsd: Double?
    let volume1MthUsd: Double?

    enum CodingKeys: String, CodingKey {
        case exchangeID = "exchange_id"
        case website
        case name
        case dataQuoteStart = "data_quote_start"
        case dataQuoteEnd = "data_quote_end"
        case dataOrderbookStart = "data_orderbook_start"
        case dataOrderbookEnd = "data_orderbook_end"
        case dataTradeStart = "data_trade_start"
        case dataTradeEnd = "data_trade_end"
        case dataSymbolsCount = "data_symbols_count"
        case volume1HrsUsd = "volume_1hrs_usd"
        case volume1DayUsd = "volume_1day_usd"
        case volume1MthUsd = "volume_1mth_usd"
    }

//    init(
//        exchangeID: String?,
//        website: String?,
//        name: String?,
//        dataQuoteStart: String?,
//        dataQuoteEnd: String?,
//        dataOrderbookStart: String?,
//        dataOrderbookEnd: String?,
//        dataTradeStart: String?,
//        dataTradeEnd: String?,
//        dataSymbolsCount: Int?,
//        volume1HrsUsd: Double?,
//        volume1DayUsd: Double?,
//        volume1MthUsd: Double?
//    ) {
//        self.exchangeID = exchangeID
//        self.website = website
//        self.name = name
//        self.dataQuoteStart = dataQuoteStart
//        self.dataQuoteEnd = dataQuoteEnd
//        self.dataOrderbookStart = dataOrderbookStart
//        self.dataOrderbookEnd = dataOrderbookEnd
//        self.dataTradeStart = dataTradeStart
//        self.dataTradeEnd = dataTradeEnd
//        self.dataSymbolsCount = dataSymbolsCount
//        self.volume1HrsUsd = volume1HrsUsd
//        self.volume1DayUsd = volume1DayUsd
//        self.volume1MthUsd = volume1MthUsd
//    }
}
