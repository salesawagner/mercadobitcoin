//
//  ExchangesViewControllerSpy.swift
//  MBTests
//
//  Created by Wagner Sales on 30/01/24.
//

import XCTest
@testable import MB

final class ExchangesViewControllerSpy: ExchangesOutputProtocol {
    var receivedMessages: [Message] = []
    let expectation: XCTestExpectation?

    init(expectation: XCTestExpectation? = nil) {
        self.expectation = expectation
    }

    func startLoading() {
        receivedMessages.append(.startLoading)
    }

    func success() {
        receivedMessages.append(.success)
        expectation?.fulfill()
    }

    func failure() {
        receivedMessages.append(.failure)
        expectation?.fulfill()
    }

    func update(section: Int) {
        receivedMessages.append(.updateSection)
    }
}

extension ExchangesViewControllerSpy {
    enum Message {
        case startLoading
        case success
        case failure
        case updateSection
    }
}

