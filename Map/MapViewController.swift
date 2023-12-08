//
//  MapViewController.swift
//  CityMarks
//
//  Created by André Emiliano on 30/11/2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var viewModel: MapViewModel

    private let mapView = MKMapView()

    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateAppearance()
        getMarksData()
    }

    private func getMarksData() {
        viewModel.onErrorHandling = { [weak self] error in
            self?.showErrorAlert(with: error.localizedDescription)
        }

        viewModel.onSuccess = { [weak self] marks in
            self?.loadMap(with: marks)
        }

        viewModel.getCitiesData()
        setupMapView()
        viewModel.requestUserLocation()
    }

    private func setupMapView() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadMap(with marks: [Mark]) {
        mapView.removeAnnotations(mapView.annotations)

        for mark in marks {
            let annotation = MKPointAnnotation()
            annotation.title = mark.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: mark.latitude, longitude: mark.longitude)
            mapView.addAnnotation(annotation)
        }

        mapView.setUserTrackingMode(.follow, animated: true)
    }

    private func updateAppearance() {
        let appearance = UINavigationBarAppearance()
        let navigationBar = navigationController?.navigationBar
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationBar?.standardAppearance = appearance
        navigationBar?.scrollEdgeAppearance = navigationBar?.standardAppearance

        title = "Mark Finder"
        navBarButton()
    }

    private func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "There was an issue", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func navBarButton() {
        let customItemImage = UIImage(systemName: "location.fill")
        let customItem = UIBarButtonItem(image: customItemImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(centerMapOnUserButtonClicked))

        navigationItem.rightBarButtonItem?.isEnabled = viewModel.userLocation == nil
        navigationItem.rightBarButtonItem = customItem
    }

    @objc func centerMapOnUserButtonClicked() {
        mapView.setUserTrackingMode(.follow, animated: true)
    }
}
