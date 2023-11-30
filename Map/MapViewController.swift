//
//  MapViewController.swift
//  CityMarks
//
//  Created by André Emiliano on 30/11/2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    var viewModel: MapViewModel?
    private let locationManager = CLLocationManager()

    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.requestUserLocation()
    }

    private func requestUserLocation() {
        guard CLLocationManager.locationServicesEnabled() else {
          return
        }

        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters

        self.locationManager.delegate = self


        switch locationManager.authorizationStatus {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        default:
            self.locationManager.requestLocation()
        }
    }
}
