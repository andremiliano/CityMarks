//
//  MapViewModel.swift
//  CityMarks
//
//  Created by André Emiliano on 30/11/2023.
//

import Foundation
import CoreLocation
import MapKit

class MapViewModel: NSObject {
    private var apiService = APIService.shared
    private let locationManager = CLLocationManager()

    var userLocation: CLLocationCoordinate2D?
    var onSuccess: (([Mark]) -> Void)?
    var onErrorHandling: ((Error) -> Void)?

    override init() {
        super.init()
        configureLocationManager()
    }

    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    func requestUserLocation() {
        DispatchQueue.global().async {
            guard CLLocationManager.locationServicesEnabled() else {
                return
            }

            switch self.locationManager.authorizationStatus {
            case .notDetermined:
                self.locationManager.requestWhenInUseAuthorization()
            default:
                self.locationManager.requestLocation()
            }
        }
    }

    func getCitiesData() {
        apiService.getCityMarks { [weak self] result in
            switch result {
            case .success(let cities):
                let marks = cities.flatMap({ $0.marks })
                DispatchQueue.main.async {
                    self?.onSuccess?(marks)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onErrorHandling?(error)
                }
            }
        }
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = manager.location?.coordinate else {
            return
        }
        
        self.userLocation = userLocation
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
}

