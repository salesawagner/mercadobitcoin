//
//  ExchangesViewModel.swift
//  MB
//
//  Created by Wagner Sales on 29/01/24.
//

import API

final class ExchangesViewModel {
    // MARK: Properties

    private var api: APIClient
    private var response: GetExchangesRequest.Response = []
    private var thumbnails: GetExchangeIconRequest.Response = []
    private let title = "Exchanges"

    var viewController: ExchangesOutputProtocol?
    var rows: [ExchangeRowViewModel] {
        response.compactMap {
            guard let exchangeID = $0.exchangeID, let name = $0.name, let volume1DayUsd = $0.volume1DayUsd else {
                return nil
            }

            return .init(
                thumbnailURL: getThumbnailURL(exchangeID: exchangeID),
                exchangeID: exchangeID,
                name: name,
                volume1dayUsd: volume1DayUsd
            )
        }
    }

    // MARK: Inits

    init(api: APIClient = WASAPI(environment: Environment.production)) {
        self.api = api
    }

    // MARK: Private Methods

    private func getThumbnailURL(exchangeID: String?) -> String? {
        thumbnails.first { $0.exchangeID == exchangeID }?.url
    }

    private func requestExchanges() {
        viewController?.startLoading()
        requestIcons { [weak self] in
            self?.api.send(GetExchangesRequest()) { result in
                switch result {
                case .success(let response):
                    self?.response = response.sorted {
                        guard let name0 = $0.name, let name1 = $1.name else {
                            return $0.name != nil
                        }
                        return name0 < name1
                    }

                    DispatchQueue.main.async {
                        self?.viewController?.success()
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self?.viewController?.failure()
                    }
                }
            }
        }
    }

    private func requestIcons(completion: @escaping () -> Void) {
        api.send(GetExchangeIconRequest()) { [weak self] result in
            switch result {
            case .success(let response):
                self?.thumbnails = response
                completion()
            case .failure:
                completion()
            }
        }
    }
}

// MARK: - ExchangesInputProtocol

extension ExchangesViewModel: ExchangesInputProtocol {
    func didSelectRow(indexPath: IndexPath) {
        let exchange = response[indexPath.row]
        let detailViewModel = DetailViewModel(
            api: api,
            detail: exchange,
            thumbnailURL: getThumbnailURL(exchangeID: exchange.exchangeID)
        )

        (viewController as? UIViewController)?.navigationController?.pushViewController(
            DetailViewController.create(with: detailViewModel),
            animated: true
        )
    }

    func didTapReload() {
        requestExchanges()
    }

    func pullToRefresh() {
        requestExchanges()
    }

    func viewDidLoad() {
        viewController?.setTitle(title)
        requestExchanges()
    }
}
