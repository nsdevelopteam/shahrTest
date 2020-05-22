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

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            let info = notification.userInfo!
            let _: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= 200
                }
            }
        }
        
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            let info = notification.userInfo!
            let _: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
                if self.view.frame.origin.y != 0 {
                    self.view.frame.origin.y += 200
                }
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
    

    func postComplexPictures(url:URL, params:[String:Any], pictures : UIImage) {
          
          let headers: HTTPHeaders
          headers = ["Content-type": "multipart/form-data"]
          
          AF.upload(multipartFormData: { (multipartFormData) in
              
              for (key, value) in params {
                  print("key : \(key), value \(value)")
                  multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
              }
              
              if let imageData = pictures.pngData()
              {
                  multipartFormData.append(imageData, withName: "problem-6.png", fileName: "problem-6.png", mimeType: "image/jpg")
              }
          }, to: url, usingThreshold: UInt64.init(), method: .post, headers: headers)
              .responseJSON
              {
                  response in
                  //debugPrint(response)
                  switch response.result
                  {
                      
                  case .success(let value):
                      print("value : \(value)")
                      do
                      {
//                              let parsedData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
//                              let getvalue = try JSONDecoder().decode(fitme.self, from: parsedData)
//                              print(getvalue.result)
                          
                      }
                      
                  case .failure(let error):
                      print("error : \(error)")
                      break
                  }
          }
    }


    func sendLocationAndData(api_token: String, lat: String, lng: String, type_id: String, description: String) {
        
        let parameters = ["api_token": api_token, "name": lat, "province": lng, "type_id": type_id, "description": description]
        let url = NSURL(string: appURL)

        if appDelegate.selectedImageProblems.images != nil {

            postComplexPictures(url: url! as URL, params: parameters, pictures: appDelegate.selectedImageProblems)
            
        } else {
                    
            AF.request(appURL,
                       method: .post,
                       parameters: parameters).responseJSON { (responseData) -> Void in
                        if((responseData.value) != nil) {
                            let result = JSON(responseData.value!)
                            print(result)
                        } else {
                }
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
        
        let api_token = UserDefaults.standard.string(forKey: "api_token")!
        
        let locationcoordinate = getLocation()

        let numberOfProblem = appDelegate.numberOfProblem
        
        sendLocationAndData(api_token: api_token, lat: locationcoordinate[0], lng: locationcoordinate[1], type_id: numberOfProblem, description: textField.text ?? "مشکل")

        dismiss(animated: true, completion: nil)
        
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
