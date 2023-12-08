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
        segmentedControl.tintColor = .black
        return segmentedControl
    }()

    private var isSCShown: Bool = false

    var cities: [City]? {
        didSet {
            if let cityNames = cities.flatMap({ $0.map { $0.name }}) {
                segmentedControl(cityNames: cityNames)
            }
        }
    }

    weak var delegate: HeaderViewDelegate?

    private func segmentedControl(cityNames: [String]) {

        /// This is needed since the segmented control gets refreshed along with the tableview
        /// it makes it only display the cities once otherwise it would duplicate them on each data reload
        if !isSCShown {
            for (index, cityName) in cityNames.enumerated() {
                customSC.insertSegment(withTitle: cityName, at: index, animated: false)
            }

            customSC.selectedSegmentIndex = 0
            let selectedCity = customSC.titleForSegment(at: customSC.selectedSegmentIndex) ?? ""
            selectCity(selectedCity)
            isSCShown = true
        }

        customSC.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)

        customSC.translatesAutoresizingMaskIntoConstraints = false
        addSubview(customSC)
        NSLayoutConstraint.activate([
            customSC.topAnchor.constraint(equalTo: topAnchor),
            customSC.leadingAnchor.constraint(equalTo: leadingAnchor),
            customSC.trailingAnchor.constraint(equalTo: trailingAnchor),
            customSC.bottomAnchor.constraint(equalTo: bottomAnchor)
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
        selectCity(cityName)
    }
}
