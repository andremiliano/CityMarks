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
            self.loadMap(with: marks)
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
        self.viewModel?.requestUserLocation()
        self.getMarksData()
    }

    private func getMarksData() {

        self.viewModel?.onErrorHandling = { error in
            let alert = UIAlertController(title: "There was an issue",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default))

            self.present(alert, animated: true, completion: nil)
        }

        self.viewModel?.onSuccess = { marks in
            self.marks = marks
        }

        self.viewModel?.getCitiesData()
        self.setupMapView()
    }

    private func setupMapView() {
        view.addSubview(self.mapView)
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        self.mapView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        self.mapView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        self.mapView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        self.mapView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true

//        self.addMapTrackingButton()
    }

    private func loadMap(with marks: [Mark]?) {
        guard let marks,
              let viewModel else {
            return
        }

        var mapAnnotations: [MKPointAnnotation] = []
        let annotation = MKPointAnnotation()
        for mark in marks {
            annotation.title = mark.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: mark.latitude, longitude: mark.longitude)
            mapAnnotations.append(annotation)
        }

        let centerUser = viewModel.userLocation ??
                        mapAnnotations.first?.coordinate ??
                        CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)

        let region = MKCoordinateRegion(center: centerUser, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.showsUserLocation = viewModel.userLocation != nil
        self.mapView.setRegion(region, animated: true)
        self.mapView.addAnnotations(mapAnnotations)
    }

    private func addMapTrackingButton(){
        let image = UIImage(systemName: "location.fill")?.withTintColor(.black)
        let button   = UIButton(type: .custom) as UIButton
        button.frame = CGRect(origin: CGPoint(x:10, y: 50), size: CGSize(width: 50, height: 50))
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(centerMapOnUserButtonClicked), for:.touchUpInside)
        self.mapView.addSubview(button)
    }

    @objc func centerMapOnUserButtonClicked() {
        self.mapView.setUserTrackingMode(.follow, animated: true)
    }
}
