//
//  DetailViewController.swift
//  MB
//
//  Created by Wagner Sales on 29/01/24.
//

import UIKit

final class DetailViewController: MBTableViewController {
    // MARK: - Properties

    var viewModel: DetailInputProtocol
    var refreshControl = UIRefreshControl()
    var errorView: UIView?

    // MARK: Constructors

    private init(viewModel: DetailInputProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func create(with viewModel: DetailInputProtocol) -> DetailViewController {
        let viewController = DetailViewController(viewModel: viewModel)
        viewController.viewModel.viewController = viewController
        return viewController
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.viewDidLoad()
    }

    override func setupUI() {
        super.setupUI()
        setupRefreshControl()
    }

    override func setupTableView() {
        super.setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: Private Methods

    private func setupRefreshControl() {
        self.refreshControl.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
    }

    @objc
    private func pullToRefresh(_ sender: AnyObject) {
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

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.sections[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = section.rows[indexPath.row].text
        cell?.textLabel?.numberOfLines = 0
        cell?.backgroundColor = (indexPath.row % 2 == 0) ? .lightGray : .gray
        cell?.selectionStyle = .none

        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewModel = viewModel.sections[section]
        
        // FIXME: - Criar class
        let view = UIView(frame: .zero)

        let thumbnail = UIImageView()
        thumbnail.backgroundColor = .white
        thumbnail.contentMode = .scaleAspectFit
        thumbnail.fill(on: view, insets: .init(top: .zero, left: .zero, bottom: 16, right: .zero))
        thumbnail.loadFromUrl(stringURL: viewModel.thumbnailURL)
        NSLayoutConstraint.activate([thumbnail.heightAnchor.constraint(equalToConstant: 160)])

        return view
    }
}

// MARK: - MBErrorViewDelegate

extension DetailViewController: MBErrorViewDelegate {
    func didTapReloadButton() {
        viewModel.didTapReloadButton()
    }
}

// MARK: - DetailOutputProtocol

extension DetailViewController: DetailOutputProtocol {
    func setTitle(_ title: String) {
        navigationItem.title = title
    }

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
        tableView.reloadData()
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
