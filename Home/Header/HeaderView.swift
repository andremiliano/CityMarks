//
//  HeaderView.swift
//  CityMarks
//
//  Created by André Emiliano on 28/11/2023.
//

import UIKit
import Foundation

protocol HeaderViewDelegate: AnyObject {
    func updateSelectedCity(city: City?)
}

class HeaderView: UITableViewHeaderFooterView {

    private let customSC: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [])
        segmentedControl.layer.cornerRadius = 0
        segmentedControl.tintColor = .black
        return segmentedControl
    }()

    private var isSCShown: Bool = false

    var cities: [City]? {
        didSet {
            if let cityNames = cities.flatMap({ $0.map { $0.name }}) {
                self.segmentedControl(cityNames: cityNames)
            }
        }
    }

    weak var delegate: HeaderViewDelegate?

    private func segmentedControl(cityNames: [String]) {

        if !isSCShown {
            for (index, cityName) in cityNames.enumerated() {
                customSC.insertSegment(withTitle: cityName, at: index, animated: false)
            }

            customSC.selectedSegmentIndex = 0
            let selectedCity = customSC.titleForSegment(at: customSC.selectedSegmentIndex) ?? ""
            self.selectCity(selectedCity)
            isSCShown = true
        }

        customSC.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)

        customSC.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(customSC)
        NSLayoutConstraint.activate([
            customSC.topAnchor.constraint(equalTo: self.topAnchor),
            customSC.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customSC.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            customSC.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func selectCity(_ cityName: String) {
        let selectedCity = cities?.first(where: { $0.name == cityName })
        delegate?.updateSelectedCity(city: selectedCity)
    }

    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        guard selectedIndex != UISegmentedControl.noSegment else {
            return
        }

        let cityName = sender.titleForSegment(at: selectedIndex) ?? ""
        self.selectCity(cityName)
        }
}
