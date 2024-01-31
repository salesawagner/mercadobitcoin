//
//  DetailViewModelTests.swift
//  MarvelTests
//
//  Created by Wagner Sales on 10/12/23.
//

import XCTest
import API
@testable import MB

final class DetailViewModelTests: XCTestCase {
    private func makeSUT(api: APIClient, expectation: XCTestExpectation? = nil) -> (
        DetailViewModel,
        DetailViewViewControllerSpy
    ) {
        let viewControllerSpy = DetailViewViewControllerSpy(expectation: expectation)
        let sut = DetailViewModel(api: api, detail: .mock, thumbnailURL: "")
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
            XCTAssertEqual(viewControllerSpy.receivedMessages, [.setTitle, .success])
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_pullToRefresh_success_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestDetail_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local), expectation: expectation)
        sut.pullToRefresh()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.success))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_didTapReloadButton_success_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestDetail_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPI(environment: Environment.local), expectation: expectation)
        sut.didTapReloadButton()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.success))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_pullToRefresh_failure_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestDetail_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPIMock(), expectation: expectation)
        sut.pullToRefresh()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.failure))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }

    func test_didTapReloadButton_failure_shouldReceiveCorrectMessages() {
        let expectation = XCTestExpectation(description: "requestDetail_success")
        let (sut, viewControllerSpy) = makeSUT(api: WASAPIMock(), expectation: expectation)
        sut.didTapReloadButton()

        let result = XCTWaiter.wait(for: [expectation], timeout: 1)
        switch result {
        case .completed:
            XCTAssertTrue(viewControllerSpy.receivedMessages.contains(.failure))
        default:
            XCTFail("Delegate not called within timeout")
        }
    }
}
