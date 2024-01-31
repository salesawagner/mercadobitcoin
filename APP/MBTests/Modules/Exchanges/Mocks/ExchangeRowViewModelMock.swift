//
//  ExchangeRowViewModelMock.swift
//  MBTests
//
//  Created by Wagner Sales on 30/01/24.
//

@testable import MB

extension ExchangeRowViewModel {
    static var mock: ExchangeRowViewModel {
        .init(thumbnailURL: nil, exchangeID: "", name: "", volume1dayUsd: 0)
    }
}

extension Array where Element == ExchangeRowViewModel {
    static var mock: [ExchangeRowViewModel] {
        [.mock]
    }
}

