//
//  ExchangesProtocols.swift
//  MB
//
//  Created by Wagner Sales on 10/12/23.
//

import Foundation

protocol ExchangesInputProtocol {
    var viewController: ExchangesOutputProtocol? { get set }
    var rows: [ExchangeRowViewModel] { get }
    func viewDidLoad()
    func requestExchanges()
    func didSelectRow(indexPath: IndexPath)
}

protocol ExchangesOutputProtocol {
    func startLoading()
    func success()
    func failure()
}
