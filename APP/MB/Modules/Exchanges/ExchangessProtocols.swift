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
    func didSelectRow(indexPath: IndexPath)
    func didTapReload()
    func pullToRefresh()
    func viewDidLoad()
}

protocol ExchangesOutputProtocol {
    func startLoading()
    func success()
    func failure()
}
