//
//  MarkDetailViewModel.swift
//  CityMarks
//
//  Created by André Emiliano on 07/12/2023.
//

import Foundation
import MapKit

class MarkDetailViewModel: ObservableObject {
    private let mark: Mark
    private let cityName: String
    private let countryName: String
    
    init(mark: Mark, cityName: String, countryName: String) {
        self.mark = mark
        self.cityName = cityName
        self.countryName = countryName
    }
    
    var imageUrl: URL? {
        return URL(string: mark.image)
    }
    
    var markName: String {
        return mark.name
    }
    
    var locationDescription: String {
        return "\(cityName), \(countryName)"
    }
    
    var markDescription: String {
        return mark.description
    }
    
    var mapCoordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: mark.latitude, longitude: mark.longitude)
    }
}
