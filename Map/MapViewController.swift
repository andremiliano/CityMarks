//
//  MapViewController.swift
//  CityMarks
//
//  Created by André Emiliano on 30/11/2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var viewModel: MapViewModel?
    private let mapView = MKMapView()
    private var marks: [Mark]? {
        didSet {
            loadMap(with: marks)
        }
    }

    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateAppearance()
        viewModel?.requestUserLocation()
        getMarksData()
    }

    private func getMarksData() {

        viewModel?.onErrorHandling = { error in
            let alert = UIAlertController(title: "There was an issue",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default))

            self.present(alert, animated: true, completion: nil)
        }

        viewModel?.onSuccess = { marks in
            self.marks = marks
        }

        viewModel?.getCitiesData()
        setupMapView()
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

    private func loadMap(with marks: [Mark]?) {
        guard let marks else {
            return
        }

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

    private func navBarButton() {
        let customItemImage = UIImage(systemName: "location.fill")
        let customItem = UIBarButtonItem(image: customItemImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(centerMapOnUserButtonClicked))

        navigationItem.rightBarButtonItem?.isHidden = viewModel?.userLocation == nil
        navigationItem.rightBarButtonItem = customItem
    }

    @objc func centerMapOnUserButtonClicked() {
        mapView.setUserTrackingMode(.follow, animated: true)
    }
}
