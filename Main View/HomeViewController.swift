//
//  MainViewController.swift
//  CityMarks
//
//  Created by André Emiliano on 26/11/2023.
//

import UIKit

class HomeViewController: UIViewController {

    var viewModel: HomeViewModel?
    private let tableView = UITableView()
    private var cities: [City]? {
        didSet {
            self.tableView.reloadData()
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
        self.title = "City Marks"
        self.getCitiesData()
    }

    private func getCitiesData() {

        self.viewModel?.onErrorHandling = { error in
            let alert = UIAlertController(title: "There was an issue",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default))

            self.present(alert, animated: true, completion: nil)
            print(error.localizedDescription)
        }

        self.viewModel?.onSuccess = { cities in
            self.cities = cities
        }

        self.viewModel?.getCitiesData()
        self.setupTableView()
    }

    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "HeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderView")
        self.tableView.register(UINib(nibName: "MarksTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableTableCell")

        self.tableView.separatorStyle = .none

        view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities?.first?.marks.count ?? 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? HeaderView else {
            return nil
        }

        headerView.cities = self.cities
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableTableCell", for: indexPath) as? MarksTableViewCell else {
            return UITableViewCell()
        }

        //TODO: Update the city that is sent depending on whats selected on the header
        cell.mark = self.cities?.first?.marks[indexPath.row]
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: Open individual Mark screen with SwiftUI
    }
}
