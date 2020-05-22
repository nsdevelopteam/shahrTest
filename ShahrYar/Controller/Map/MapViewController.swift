//
//  MapViewController.swift
//  ShahrYar
//
//  Created by Nima Akbarzade on 5/7/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    let appURL = "http://moshkelateshahri.xyz/api/app/"
    var locationManager = CLLocationManager()
    @IBOutlet weak var textField: UITextField!
    let defaults = UserDefaults.standard
    var lat = 0.0
    var long = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
            initializeTheLocationManager()
            self.mapView.isMyLocationEnabled = true
            self.mapView.delegate = self
            textField.delegate = self

            self.hideKeyboardWhenTappedAround()
        
        let locationcoordinate = getLocation()
        let testToken = "GihrnWP3rxmkplX57xPUHIhIGW43Pduz5tVooCCE0cjpncpY9psc3zKt3fnkZUfg0cMKUkyQIqwRFVJ0rGYbNJj8RUU8nYH5bE74"

        sendLocationAndData(api_token: testToken, lat: locationcoordinate[0], lng: locationcoordinate[1], type_id: "1", description: "test description")
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)


        }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }


    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
        func initializeTheLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0, execute: {
            self.locationManager.stopUpdatingLocation()
            self.mapView.isMyLocationEnabled = false
        })
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let location = locationManager.location?.coordinate

        cameraMoveToLocation(toLocation: location)

    }

    func sendLocationAndData(api_token: String, lat: String, lng: String, type_id: String, description: String) {
        
        let parameters = ["api_token": api_token, "name": lat, "province": lng, "type_id": type_id, "description": description]

        AF.request(appURL,
                   method: .post,
                   parameters: parameters).responseJSON { (responseData) -> Void in
                    if((responseData.value) != nil) {
                        let result = JSON(responseData.value!)
                        print(result)
//                        self.hideWaiting()
                        guard let verifyVc = self.storyboard?.instantiateViewController(withIdentifier: "homeVc") as? VerifyViewController else { return }
                        self.navigationController?.pushViewController(verifyVc, animated: true)
                    } else {
//                        self.hideWaiting()
            }
        }
    }
    
    func getLocation() -> [String] {
        let latitude = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        print(latitude)
        print(longitude)
        if (lat) <= 0.0 && long <= 0.0 {

            defaults.set(String(latitude), forKey: "lat")
            defaults.set(String(longitude), forKey: "long")
            
            print("Yeaeeeeejjjhhhh nill ")
        }
        
        return [String(latitude),String(longitude)]
    }
    
    @IBAction func sendData(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "problemsVc")
        present(vc, animated: true, completion: nil)

        print("clickeddddd")
        
    }
    
    func cameraMoveToLocation(toLocation: CLLocationCoordinate2D?) {
        if toLocation != nil {
            mapView.camera = GMSCameraPosition.camera(withTarget: toLocation!, zoom: 15)
        }
    }
}
    
extension MapViewController {
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
         let marker = GMSMarker()
         marker.position = coordinate
        print(coordinate.longitude)
        print(coordinate.latitude)
        lat = coordinate.latitude
        long = coordinate.longitude
        
        defaults.set(String(lat), forKey: "lat")
        defaults.set(String(long), forKey: "long")
        
         marker.title = "ارسال گزارش"
         marker.snippet = "تست"
         marker.map = mapView
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
