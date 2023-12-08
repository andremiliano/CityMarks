//
//  MainViewController.swift
//  CityMarks
//
//  Created by André Emiliano on 26/11/2023.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {

    lazy var refreshControl = UIRefreshControl()

    var viewModel: HomeViewModel
    private let tableView = UITableView()
    private var cities: [City]? {
        didSet {
            tableView.reloadData()
        }
    }

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "City Mark"
        getCitiesData()
        setupTableView()
    }

    private func getCitiesData() {
        viewModel.onErrorHandling = { [weak self] error in
            self?.showErrorAlert(with: error.localizedDescription)
        }

        viewModel.onSuccess = { [weak self] cities in
            self?.cities = cities
        }

        viewModel.getCitiesData()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.register(UINib(nibName: "MarksTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableTableCell")

        tableView.separatorStyle = .none

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true

        addRefreshControl()
    }

    private func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "There was an issue", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func addRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc func refresh(_ sender: AnyObject) {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension HomeViewController: HeaderViewDelegate {
    func updateSelectedCity(city: City?) {
        viewModel.selectedCity = city
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMarks()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? HeaderView else {
            return nil
        }

        headerView.cities = cities
        headerView.delegate = self
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableTableCell", for: indexPath) as? MarksTableViewCell else {
            return UITableViewCell()
        }

        cell.mark = viewModel.didSelectCity(at: indexPath.row)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cityMark = viewModel.selectedMark(at: indexPath.row) {
            let viewModel = MarkDetailViewModel (
                mark: cityMark,
                cityName: viewModel.cityName(),
                countryName: viewModel.countryName()
            )

            let markUIView = MarkUIView(viewModel: viewModel)
            let hostingController = UIHostingController(rootView: markUIView)
            present(hostingController, animated: true, completion: nil)
        }
    }
}
