//
//  MainViewController.swift
//  CityMarks
//
//  Created by André Emiliano on 26/11/2023.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: MainViewModel?

    convenience init(viewModel: MainViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }

    private func setUp() {
        navigationController?.isNavigationBarHidden = false
        self.title = "City Marks"
        self.setupTableView()
        self.viewModel?.decodeJson()
    }

    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "MarksTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableTableCell")
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableTableCell", for: indexPath) as! MarksTableViewCell
        cell.cityLabel.text = "Location"
        return cell
    }
}
