//
//  ViewController.swift
//  Diplom
//
//  Created by Махова Татьяна on 25.01.2023.
//

import UIKit
import GoogleMaps
import FirebaseFirestore
import GoogleMapsUtils

class MapViewController: UIViewController, GMSMapViewDelegate {

    private var clusterManager: GMUClusterManager?
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    private var circleRadius: Double = 2000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        getPlacec()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpMapView()
        setupClusterManager()
        createRadiusCircle()
    }
    
    private var placeArray: [ Place ] = [] {
        didSet {
            drawMarkers()
        }
    }
    
    private func addTargets() {
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(sender:)), for: .allEvents)
    }

    @objc private func segmentedControlValueChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0: circleRadius = 2000
            case 1: circleRadius = 5000
            case 2: circleRadius = 30000
            default: break
        }
        clearMap()
        drawMarkers()
        createRadiusCircle()
    }
    
    private func setUpMapView() {
        mapView.isMyLocationEnabled = true
    }
    
    private func getPlacec() {
        APIManager.shared.getPlacec { [weak self]  placecFromFirebase in
            self?.placeArray = placecFromFirebase
        }
    }
    
    private func drawMarkers() {
        for place in placeArray {
            let position = CLLocationCoordinate2D(latitude: place.location.latitude, longitude: place.location.langitude)
            guard let myPosition = mapView.myLocation else { return }
            createMarker(coordinate: position, position: myPosition, id: place.id )
        }
    }

    private func setupClusterManager() {
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        clusterManager?.setMapDelegate(self)
    }
    
    private func clearMap() {
        mapView.clear()
        clusterManager?.clearItems()
    }
    
    private func createRadiusCircle() {
        guard let myPosition = mapView.myLocation else { return }
        let circle = GMSCircle(position: myPosition.coordinate, radius: circleRadius )
        circle.fillColor = UIColor.green.withAlphaComponent(0.1)
        circle.map = mapView
    }
    
private func createMarker(coordinate: CLLocationCoordinate2D , position: CLLocation, id: String) {
        let distance = position.distance(from: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
        if distance < circleRadius {
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
            clusterManager?.add(marker)
            marker.map = mapView
            marker.userData = ["id": id ]
       }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let dict = marker.userData as? [ String: String ]
        guard let id = dict?["id"] as? String else { return false }
        let descriptionViewController = PlaceDescriptionViewController(placeId: id)
        present(descriptionViewController, animated: true)
        return true
    }
}

