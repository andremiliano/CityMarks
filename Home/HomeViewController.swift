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

    var viewModel: HomeViewModel?
    private let tableView = UITableView()
    private var selectedCity: City?
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
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "City Mark"
        getCitiesData()
        setupTableView()
    }

    private func getCitiesData() {
        viewModel?.onErrorHandling = { error in
            let alert = UIAlertController(title: "There was an issue",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default))

            self.present(alert, animated: true, completion: nil)
        }

        viewModel?.onSuccess = { cities in
            self.cities = cities
        }

        viewModel?.getCitiesData()
        refreshControl.endRefreshing()
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

    private func addRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc func refresh(_ sender: AnyObject) {
        getCitiesData()
    }
}

extension HomeViewController: HeaderViewDelegate {
    func updateSelectedCity(city: City?) {
        selectedCity = city
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCity?.marks.count ?? 0
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

        cell.mark = selectedCity?.marks[indexPath.row]
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCity else {
            return
        }

        let markUIView = MarkUIView(cityName: selectedCity.name,
                                    countryName: selectedCity.country,
                                    mark: selectedCity.marks[indexPath.row])
        let hostingController = UIHostingController(rootView: markUIView)
        present(hostingController, animated: true, completion: nil)
    }
}
