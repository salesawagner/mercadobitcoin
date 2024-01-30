//
//  DetailViewModel.swift
//  MB
//
//  Created by Wagner Sales on 29/01/24.
//

import API

class DetailViewModel {
    // MARK: Properties

    private var api: APIClient
    private var detail: GetExchangesResponse

    var viewController: DetailOutputProtocol?
    var sections: [DetailSectionViewModel] = []

    // MARK: Inits

    init(api: APIClient = WASAPI(environment: Environment.production), detail: GetExchangesResponse) {
        self.api = api
        self.detail = detail
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
        var rows: [DetailRowViewModel] = []
        rows.append(.init(text: "Id: \(detail.exchangeID ?? "-")"))
        rows.append(.init(text: "Name: \(detail.name ?? "-")"))
        rows.append(.init(text: "Website: \(detail.website ?? "-")"))
        rows.append(.init(text: "Volume 1hr: \(detail.volume1HrsUsd ?? 0)"))
        rows.append(.init(text: "Volume 1 dia: \(detail.volume1DayUsd ?? 0)"))
        rows.append(.init(text: "Volume 1 mês: \(detail.volume1MthUsd ?? 0)"))

        // FIXME: Icon
        sections = []
        sections.append(.init(thumbnailURL: "", rows: rows))

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
