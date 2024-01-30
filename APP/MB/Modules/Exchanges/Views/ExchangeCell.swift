//
//  ExchangesRow.swift
//  MB
//
//  Created by Wagner Sales on 29/01/24.
//

import UIKit

final class ExchangeCell: UITableViewCell {
    static var identifier = String(describing: ExchangeCell.self)

    // MARK: Properties

    private let idLabel = UILabel()
    private let nameLabel = UILabel()
    private let volumeLabel = UILabel()

    // MARK: Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setupUI() {
        setupStackView()
        accessoryType = .disclosureIndicator
    }

    private func setupStackView() {
        let stackViewVertical = UIStackView()
        stackViewVertical.axis = .vertical
        stackViewVertical.alignment = .top
        stackViewVertical.spacing = 8

        stackViewVertical.addArrangedSubview(idLabel)
        stackViewVertical.addArrangedSubview(nameLabel)
        stackViewVertical.addArrangedSubview(volumeLabel)
        stackViewVertical.fill(on: self, constant: 8)
    }

    // MARK: Internal Methods

    func setup(with viewModel: ExchangeRowViewModel) {
        idLabel.text = "id: \(viewModel.exchangeID)"
        nameLabel.text = "nome: \(viewModel.name)"
        volumeLabel.text = "Volume de 1 dia: \(viewModel.volume1dayUsd)"
    }
}
