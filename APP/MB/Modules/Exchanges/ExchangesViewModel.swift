//
//  ExchangesViewModel.swift
//  MB
//
//  Created by Wagner Sales on 06/12/23.
//

import API

class ExchangesViewModel {
    // MARK: Properties

    private var api: APIClient
    private var response: GetExchangesRequest.Response = []

    var viewController: ExchangesOutputProtocol?
    var rows: [ExchangeRowViewModel] {
        response.compactMap {
            guard let exchangeID = $0.exchangeID, let name = $0.name, let volume1DayUsd = $0.volume1DayUsd else {
                return nil
            }

            return .init(exchangeID: exchangeID, name: name, volume1dayUsd: volume1DayUsd)
        }
    }

    // MARK: Inits

    init(api: APIClient = WASAPI(environment: Environment.production)) {
        self.api = api
    }
}

// MARK: - ExchangesInputProtocol

extension ExchangesViewModel: ExchangesInputProtocol {
    func viewDidLoad() {
        requestExchanges()
    }

    func requestExchanges() {
        viewController?.startLoading()
        api.send(GetExchangesRequest()) { [weak self] result in
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

    func didSelectRow(indexPath: IndexPath) {
        let exchange = response[indexPath.row]
        print(exchange.name)
//
//        (viewController as? UIViewController)?.navigationController?.pushViewController(
//            DetailViewController.create(with: .init(name: comic.name, resourceURI: comic.resourceURI)),
//            animated: true
//        )
    }
}
