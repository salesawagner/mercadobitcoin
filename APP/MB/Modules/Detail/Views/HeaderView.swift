//
//  HeaderView.swift
//  MB
//
//  Created by Wagner Sales on 30/01/24.
//

import UIKit

final class DetailHeaderView: UIView {
    // MARK: Private Properties

    private let thumbnailURL: String?
    private let thumbnail = UIImageView()

    // MARK: Inits

    init(thumbnailURL: String?) {
        self.thumbnailURL = thumbnailURL
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: Private Methods

    private func setupUI() {
        setupThumbnail()
    }

    private func setupThumbnail() {
        let thumbnail = UIImageView()
        thumbnail.backgroundColor = .white
        thumbnail.contentMode = .scaleAspectFit
        thumbnail.fill(on: self, insets: .init(top: .zero, left: .zero, bottom: 16, right: .zero))
        thumbnail.loadFromUrl(stringURL: thumbnailURL)
        NSLayoutConstraint.activate([thumbnail.heightAnchor.constraint(equalToConstant: 160)])
    }
}
