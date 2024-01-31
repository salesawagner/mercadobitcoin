//
//  ExchangesViewModelSpy.swift
//  MBTests
//
//  Created by Wagner Sales on 30/01/24.
//

import XCTest
@testable import MB

final class ExchangesViewModelSpy: ExchangesInputProtocol {
    var receivedMessages: [Message] = []
    let expectation: XCTestExpectation?

    var viewController: ExchangesOutputProtocol?
    var rows: [ExchangeRowViewModel] = []

    init(expectation: XCTestExpectation? = nil) {
        self.expectation = expectation
    }

    func viewDidLoad() {
        receivedMessages.append(.viewDidLoad)
    }

    func requestExchanges() {
        receivedMessages.append(.requestExchanges)
    }

    func didSelectRow(indexPath: IndexPath) {
        receivedMessages.append(.didSelecteRow)
    }

    func didTapReload() {
        receivedMessages.append(.didTapReload)
    }

    func pullToRefresh() {
        receivedMessages.append(.pullToRefresh)
    }
}

extension ExchangesViewModelSpy {
    enum Message {
        case viewDidLoad
        case requestExchanges
        case didSelecteRow
        case didTapReload
        case pullToRefresh
    }
}

