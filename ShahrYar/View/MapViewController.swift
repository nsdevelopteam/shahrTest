//
//  MapViewController.swift
//  ShahrYar
//
//  Created by Nima Akbarzade on 5/7/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    
            initializeTheLocationManager()
            self.mapView.isMyLocationEnabled = true
        

        }
    
        func initializeTheLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let location = locationManager.location?.coordinate

        cameraMoveToLocation(toLocation: location)

    }

    func cameraMoveToLocation(toLocation: CLLocationCoordinate2D?) {
        if toLocation != nil {
            mapView.camera = GMSCameraPosition.camera(withTarget: toLocation!, zoom: 15)
        }
    }


}
    
