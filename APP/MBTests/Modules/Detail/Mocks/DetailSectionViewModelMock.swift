//
//  DetailectionViewModelMock.swift
//  MarvelTests
//
//  Created by Wagner Sales on 10/12/23.
//

import Foundation
@testable import MB

extension DetailSectionViewModel {
    static var mock: DetailSectionViewModel {
        .init(thumbnailURL: "", rows: [])
    }
}

extension Array where Element == DetailSectionViewModel {
    static var mock: [DetailSectionViewModel] {
        [.mock]
    }
}
