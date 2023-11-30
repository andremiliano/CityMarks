//
//  HeaderView.swift
//  CityMarks
//
//  Created by André Emiliano on 28/11/2023.
//

import UIKit
import Foundation

//TODO: Make delegate for when button is clicked

class HeaderView: UITableViewHeaderFooterView {

    var cities: [City]? {
        didSet {
            //self.createStackView()
            if let cityNames = cities.flatMap({ $0.map { $0.name }}) {
                self.segmentedControl(cityNames: cityNames)
            }
        }
    }

    private func segmentedControl(cityNames: [String]) {
        let customSC = UISegmentedControl(items: cityNames)
        customSC.selectedSegmentIndex = 0
        customSC.layer.cornerRadius = 0
        customSC.tintColor = .black

        //TODO: Add target to segment
        customSC.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(customSC)

        NSLayoutConstraint.activate([
            customSC.topAnchor.constraint(equalTo: self.topAnchor),
            customSC.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customSC.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            customSC.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
