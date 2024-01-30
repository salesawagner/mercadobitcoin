//
//  ExchangesViewControllerTests.swift
//  MBTests
//
//  Created by Wagner Sales on 30/01/24.
//

import XCTest
@testable import MB

final class ExchangesViewControllerTests: XCTestCase {
    private func makeSUT(expectation: XCTestExpectation? = nil) -> (
        sut: ExchangesViewController,
        viewModel: ExchangesViewModelSpy
    ) {
        let viewModelSpy = ExchangesViewModelSpy(expectation: expectation)
        let sut = ExchangesViewController.create(with: viewModelSpy)
        return (sut, viewModelSpy)
    }

    private func loadView(sut: ExchangesViewController) {
        let window = UIWindow()
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests

    func test_viewDidLoad_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        loadView(sut: sut)

        XCTAssertEqual(viewModelSpy.receivedMessages, [.viewDidLoad])
    }

    func test_didSelectRow_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        viewModelSpy.rows = .mock
        loadView(sut: sut)

        sut.tableView(UITableView(), didSelectRowAt: .init(row: 0, section: 0))
        XCTAssertTrue(viewModelSpy.receivedMessages.contains(.didSelecteRow))
    }

    func test_didTapReloadButton_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        viewModelSpy.rows = .mock
        loadView(sut: sut)

        sut.didTapReloadButton()
        XCTAssertTrue(viewModelSpy.receivedMessages.contains(.didTapReload))
    }

    func test_pullToRefresh_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        viewModelSpy.rows = .mock
        loadView(sut: sut)

        sut.pullToRefresh()
        XCTAssertTrue(viewModelSpy.receivedMessages.contains(.pullToRefresh))
    }
}

