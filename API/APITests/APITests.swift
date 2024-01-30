//
//  APITests.swift
//  APITests
//
//  Created by Wagner Sales on 05/12/23.
//

import XCTest
import API

final class APITests: XCTestCase {
    func testExchanges() throws {
        let expectation = XCTestExpectation(description: "testExchanges")
        let api = WASAPI(environment: Environment.local)
        api.send(GetExchangesRequest()) { result in
            switch result {
            case .success(let response): XCTAssertEqual(response.count, 47)
            case .failure(let error): XCTFail(error.localizedDescription)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }

    func testExchangesById() throws {
        let expectation = XCTestExpectation(description: "testExchangesById")
        let api = WASAPI(environment: Environment.local)
        api.send(GetExchangesByIdRequest(id: "BINANCE")) { result in
            switch result {
            case .success(let response):
                guard let exchange = response.first else {
                    XCTFail("Response error")
                    return
                }

                XCTAssertEqual(exchange.exchangeID, "BINANCE")
                XCTAssertEqual(exchange.website, "https://www.binance.com/")
                XCTAssertEqual(exchange.name, "Binance")
                XCTAssertEqual(exchange.dataQuoteStart, "2017-12-18T00:00:00.0000000Z")

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }
}
