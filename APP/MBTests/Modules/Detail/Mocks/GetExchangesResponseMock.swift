//
//  GetExchangesResponseMock.swift
//  MBTests
//
//  Created by Wagner Sales on 30/01/24.
//

import API
@testable import MB

extension GetExchangesResponse {
    static var mock: GetExchangesResponse {
        .init(
            exchangeID: "",
            website: nil,
            name: "",
            dataQuoteStart: nil,
            dataQuoteEnd: nil,
            dataOrderbookStart: nil,
            dataOrderbookEnd: nil,
            dataTradeStart: nil,
            dataTradeEnd: nil,
            dataSymbolsCount: nil,
            volume1HrsUsd: nil,
            volume1DayUsd: nil,
            volume1MthUsd: nil
        )
    }
}
