//
//  ExchangesViewController.swift
//  MB
//
//  Created by Wagner Sales on 06/12/23.
//

import UIKit

final class ExchangesViewController: MBTableViewController {
    // MARK: Properties

    var viewModel: ExchangesInputProtocol
    var refreshControl = UIRefreshControl()
    var errorView: UIView?

    // MARK: Constructors

    private init(viewModel: ExchangesInputProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func create(with viewModel: ExchangesInputProtocol = ExchangesViewModel()) -> ExchangesViewController {
        let viewController = ExchangesViewController(viewModel: viewModel)
        viewController.viewModel.viewController = viewController
        return viewController
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        setupRefreshControl()
    }

    override func setupTableView() {
        super.setupTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ExchangeCell.self, forCellReuseIdentifier: ExchangeCell.identifier)
    }

    // MARK: Private Methods

    private func setupRefreshControl() {
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
    }

    @objc
    private func refresh(_ sender: AnyObject) {
        self.viewModel.pullToRefresh()
    }

    private func stopLoading() {
        activityIndicator.stopAnimating()
        refreshControl.endRefreshing()
    }

    private func removeErrorView() {
        errorView?.alpha = 0
        errorView?.removeFromSuperview()
        errorView = nil
    }
}

// MARK: - UITableViewDataSource

extension ExchangesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = viewModel.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeCell.identifier) as? ExchangeCell
        cell?.setup(with: row)
        cell?.backgroundColor = (indexPath.row % 2 == 0) ? .lightGray : .gray

        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension ExchangesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath: indexPath)
    }
}

// MARK: - ExchangesOutnputProtocol

extension ExchangesViewController: ExchangesOutputProtocol {
    func startLoading() {
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.tableView.alpha = 0
            self?.removeErrorView()
        }
    }

    func success() {
        stopLoading()
        tableView.reloadData()
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.tableView.alpha = 1
            self?.removeErrorView()
        }
    }

    func failure() {
        stopLoading()
        guard errorView == nil else { return }

        errorView = MBErrorView(delegate: self)
        errorView?.alpha = 0
        errorView?.fill(on: view)

        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.errorView?.alpha = 1
            self?.tableView.alpha = 0
        }
    }
}

// MARK: - MBErrorViewDelegate

extension ExchangesViewController: MBErrorViewDelegate {
    func didTapReloadButton() {
        viewModel.didTapReload()
    }
}
