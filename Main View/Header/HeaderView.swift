//
//  HeaderView.swift
//  CityMarks
//
//  Created by André Emiliano on 28/11/2023.
//

import UIKit
import Foundation

class HeaderView: UIView {
    var cities: [City]? {
        didSet {
            self.createButtons()
            self.createStackView()
        }
    }
    private var buttonArray: [UIButton]? = []

    private func createButtons() {
        self.cities?.forEach { city in
            let button = UIButton(type: .system)
            button.setTitle(city.name, for: .normal)
            button.setTitleColor( UIColor.white, for: .normal)
            self.buttonArray?.append(button)
        }
    }

    private func createStackView() {
        let stackView = UIStackView(arrangedSubviews: buttonArray ?? [])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
