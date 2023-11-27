//
//  DataModel.swift
//  CityMarks
//
//  Created by André Emiliano on 26/11/2023.
//

import Foundation

struct City: Decodable {
    let name: String
    let country: String
    let image: String
    let marks: [Mark]
    let id: String
}

struct Mark: Decodable {
    let name: String
    let latitude: String
    let longitude: String
    let image: String
}
