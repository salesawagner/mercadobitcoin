//
//  DetailRowViewModelMock.swift
//  MarvelTests
//
//  Created by Wagner Sales on 10/12/23.
//

import Foundation
@testable import MB

extension DetailRowViewModel {
    static var mock: DetailRowViewModel {
        .init(text: "")
    }
}

extension Array where Element == DetailRowViewModel {
    static var mock: [DetailRowViewModel] {
        [.mock]
    }
}
