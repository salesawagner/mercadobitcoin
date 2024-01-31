//
//  DetailViewModel.swift
//  MB
//
//  Created by Wagner Sales on 29/01/24.
//

import API

final class DetailViewModel {
    // MARK: Properties

    private var api: APIClient
    private var detail: GetExchangesResponse
    private let thumbnailURL: String?

    var viewController: DetailOutputProtocol?
    var sections: [DetailSectionViewModel] = []

    // MARK: Inits

    init(api: APIClient, detail: GetExchangesResponse, thumbnailURL: String?) {
        self.api = api
        self.detail = detail
        self.thumbnailURL = thumbnailURL
    }

    // MARK: Private Methods

    private func requestDetail() {
        guard let id = detail.exchangeID else {
            viewController?.failure()
            return
        }

        viewController?.startLoading()
        api.send(GetExchangesByIdRequest(id: id)) { [weak self] result in
            switch result {
            case .success(let response):
                guard let detail = response.first else {
                    self?.viewController?.failure()
                    return
                }

                self?.detail = detail
                self?.buildSection()

            case .failure:
                DispatchQueue.main.async {
                    self?.viewController?.failure()
                }
            }
        }
    }

    private func buildSection() {
        sections = [.init(thumbnailURL: thumbnailURL, rows: [
            .init(text: "Id: \(detail.exchangeID ?? "-")"),
            .init(text: "Website: \(detail.website ?? "-")"),
            .init(text: "Volume 1hr: \(detail.volume1HrsUsd ?? 0)"),
            .init(text: "Volume 1 dia: \(detail.volume1DayUsd ?? 0)"),
            .init(text: "Volume 1 mês: \(detail.volume1MthUsd ?? 0)")
        ])]

        DispatchQueue.main.async { [weak self] in
            self?.viewController?.success()
        }
    }
}

// MARK: - DetailsInputProtocol

extension DetailViewModel: DetailInputProtocol {
    func didTapReloadButton() {
        requestDetail()
    }

    func pullToRefresh() {
        requestDetail()
    }
    
    func viewDidLoad() {
        buildSection()
        
        guard let name = detail.name else { return }
        viewController?.setTitle(name)
    }
}
