//
//  DetailViewModelSpy.swift
//  MarvelTests
//
//  Created by Wagner Sales on 10/12/23.
//

import Foundation
@testable import MB

final class DetailViewModelSpy: DetailInputProtocol {
    var receivedMessages: [Message] = []
    var viewController: DetailOutputProtocol?
    var sections: [DetailSectionViewModel] = []

    func didTapReloadButton() {
        receivedMessages.append(.didTapReloadButton)
    }

    func pullToRefresh() {
        receivedMessages.append(.pullToRefresh)
    }

    func viewDidLoad() {
        receivedMessages.append(.viewDidLoad)
    }
}

extension DetailViewModelSpy {
    enum Message {
        case didTapReloadButton
        case pullToRefresh
        case viewDidLoad
    }
}
