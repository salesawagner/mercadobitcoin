//
//  DetailProtocols.swift
//  MB
//
//  Created by Wagner Sales on 29/01/24.
//

import Foundation

protocol DetailInputProtocol {
    var viewController: DetailOutputProtocol? { get set }
    var sections: [DetailSectionViewModel] { get }
    func didTapReloadButton()
    func pullToRefresh()
    func viewDidLoad()
}

protocol DetailOutputProtocol {
    func setTitle(_ title: String)
    func startLoading()
    func success()
    func failure()
}
