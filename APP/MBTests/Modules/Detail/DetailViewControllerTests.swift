//
//  DetailViewControllerTests.swift
//  MarvelTests
//
//  Created by Wagner Sales on 06/12/23.
//

import XCTest
@testable import MB

final class DetailViewControllerTests: XCTestCase {
    private func makeSUT() -> (sut: DetailViewController, viewModel: DetailViewModelSpy) {
        let viewModelSpy = DetailViewModelSpy()
        let sut = DetailViewController.create(with: viewModelSpy)
        return (sut, viewModelSpy)
    }

    private func loadView(sut: DetailViewController) {
        let window = UIWindow()
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests

    func test_didTapReloadButton_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        loadView(sut: sut)
        sut.didTapReloadButton()

        XCTAssertTrue(viewModelSpy.receivedMessages.contains(.didTapReloadButton))
    }

    func test_pullToRefresh_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        loadView(sut: sut)
        sut.pullToRefresh()

        XCTAssertTrue(viewModelSpy.receivedMessages.contains(.pullToRefresh))
    }

    func test_viewDidLoad_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        loadView(sut: sut)

        XCTAssertEqual(viewModelSpy.receivedMessages, [.viewDidLoad])
    }

    func test_setTitle_shouldReceiveCorrectMessages() {
        let (sut, _) = makeSUT()
        loadView(sut: sut)
        sut.setTitle("tests")

        XCTAssertEqual(sut.navigationItem.title, "tests")
    }

    func test_success_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        viewModelSpy.sections = .mock
        loadView(sut: sut)

        sut.success()
        XCTAssertEqual(sut.tableView.numberOfSections, 1)
        XCTAssertNil(sut.errorView)
        XCTAssertEqual(sut.tableView.alpha, 1)
    }

    func test_failure_shouldReceiveCorrectMessages() {
        let (sut, _) = makeSUT()
        loadView(sut: sut)

        sut.failure()
        XCTAssertNotNil(sut.errorView)
        XCTAssertEqual(sut.errorView?.alpha, 1)
        XCTAssertEqual(sut.tableView.alpha, 0)
    }

    func test_startLoading_shouldReceiveCorrectMessages() {
        let (sut, _) = makeSUT()
        loadView(sut: sut)

        sut.startLoading()
        XCTAssertNil(sut.errorView)
        XCTAssertEqual(sut.tableView.alpha, 0)
    }
}
