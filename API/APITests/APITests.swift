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
            case .success(let response):
                XCTAssertEqual(response.count, 47)

            case .failure(let error):
                var message = ""
                switch error {
                case .unknown(let error, let statusCode):
                    message = error.localizedDescription
                case .decoding(let error):
                    message = error.localizedDescription
                case .server(let erroMessage):
                    message = erroMessage
                default:
                    message = "unknown"
                }

                XCTFail(message)
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
                XCTAssertEqual(response.count, 1)

            case .failure:
                XCTFail()
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }

    func testOnlineExchangesById() throws {
        let expectation = XCTestExpectation(description: "testOnlineExchangesById")
        let api = WASAPI(environment: Environment.production)
        api.send(GetExchangesByIdRequest(id: "BINANCE")) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.count, 1)

            case .failure:
                XCTFail()
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }
}
