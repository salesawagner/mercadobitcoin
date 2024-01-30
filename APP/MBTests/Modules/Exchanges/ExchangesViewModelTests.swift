//
//  ExchangesViewModelTests.swift
//  MBTests
//
//  Created by Wagner Sales on 30/01/24.
//

import XCTest
import API
@testable import MB

final class ExchangesViewModelTests: XCTestCase {
    private func makeSUT(api: APIClient, expectation: XCTestExpectation? = nil) -> (
        ExchangesViewModel,
        ExchangesViewControllerSpy
    ) {
        let viewControllerSpy = ExchangesViewControllerSpy(expectation: expectation)
        let sut = ExchangesViewModel(api: api)
        sut.viewController = viewControllerSpy

        return (sut, viewControllerSpy)
    }

    func test_viewDidLoad_success_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "viewDidLoad_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local), expectation: expectation)
        sut.viewDidLoad()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertEqual(viewControllerSpy.receivedMessages, [.startLoading, .success])
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_requestExchanges_startLoading_shouldReceiveCorrectMessages() {
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local))
        sut.requestExchanges()

        XCTAssertEqual(viewControllerSpy.receivedMessages, [.startLoading])
    }

    func test_requestExchanges_success_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestExchanges_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local), expectation: expectation)
        sut.requestExchanges()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.success))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_requestExchanges_failure_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestExchanges_failure")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPIMock(), expectation: expectation)
        sut.requestExchanges()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.failure))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }
}

