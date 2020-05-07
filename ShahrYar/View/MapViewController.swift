//
//  MapViewController.swift
//  ShahrYar
//
//  Created by Nima Akbarzade on 5/7/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var google_map: GMSMapView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.requestWhenInUseAuthorization()
        google_map.delegate = self
    }

    
    func show_marker(posotion: CLLocationCoordinate2D) {
        let marker = GMSMarker()
        marker.position = posotion
        marker.title = "hi"
        marker.snippet = "cadaw"
        marker.map = google_map
    }
    
}

extension MapViewController: CLLocationManagerDelegate {

    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()

            google_map.isMyLocationEnabled = true
            google_map.settings.myLocationButton = true
        }
    }

    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            google_map.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)

            locationManager.stopUpdatingLocation()

        }
    }
}
