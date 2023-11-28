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

    convenience init(viewModel: HomeViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.setupTableView()
    }

    private func setUp() {
        self.title = "City Marks"
        self.viewModel?.getMarks {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "MarksTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableTableCell")

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
        return 3
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        header.cities = self.viewModel?.cities

        return header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableTableCell", for: indexPath) as! MarksTableViewCell
        cell.cityLabel.text = "Location"
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Open individual Mark screen
    }
}
