//
//  DataModel.swift
//  CityMarks
//
//  Created by André Emiliano on 26/11/2023.
//

import Foundation
import MapKit

struct City: Decodable {
    let name: String
    let country: String
    let marks: [Mark]
    let id: String
}

struct Mark: Decodable {
    let name: String
    let latitude: Double
    let longitude: Double
    let image: String
}

struct MarkLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
