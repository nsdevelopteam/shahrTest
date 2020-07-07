//
//  HomeViewController.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/5/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit
import SideMenu
import Photos
import MessageUI


class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UNUserNotificationCenterDelegate, MFMailComposeViewControllerDelegate {
    
    // SEND PROBLEM SECTION
    func displayUploadImageDialog(btnSelected: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        let alertController = UIAlertController(title: "", message: "Upload profile photo?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel action"), style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            alertController.dismiss(animated: true) {() -> Void in }
        })
        alertController.addAction(cancelAction)
        let cameraRollAction = UIAlertAction(title: NSLocalizedString("Open library", comment: "Open library action"), style: .default, handler: {(_ action: UIAlertAction) -> Void in
            if UI_USER_INTERFACE_IDIOM() == .pad {
                OperationQueue.main.addOperation({() -> Void in
                    picker.sourceType = .photoLibrary
                    self.present(picker, animated: true) {() -> Void in }
                })
            }
            else {
                picker.sourceType = .photoLibrary
                self.present(picker, animated: true) {() -> Void in }
            }
        })
        alertController.addAction(cameraRollAction)
        alertController.view.tintColor = .black
        present(alertController, animated: true) {() -> Void in }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//        profileImage.image = image
        let imageData = image.jpegData(compressionQuality: 0.05)
        self.dismiss(animated: true, completion: nil)
    }

    func checkPermission() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized:
            self.displayUploadImageDialog(btnSelected: self.sendProblemOutlet)
        case .denied:
            print("Error")
        default:
            break
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    func checkLibrary() {
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .authorized {
            switch photos {
            case .authorized:
                self.displayUploadImageDialog(btnSelected: self.sendProblemOutlet)
            case .denied:
                print("Error")
            default:
                break
            }
        }
    }

    
    // MARK: - Outlets
    @IBOutlet weak var sendProblemOutlet: UIButton!
    @IBOutlet weak var parkingYabOutlet: UIButton!
    @IBOutlet weak var jahatYabiOutlet: UIButton!
    @IBOutlet weak var sandoghNumbersOutlet: UIButton!
    @IBOutlet weak var ImHereOutlet: UIButton!
    @IBOutlet weak var eghdamat: UIButton!
    @IBOutlet weak var itCitizenOutlet: UIButton!
    
    // MARK: - Variables
    var UIExtensionsVariable = UIExtensions.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIExtensionsVariable.hideNavigationBar(vc: self)
        
        UIExtensionsVariable.setCornerRedius(sendProblemOutlet)
        UIExtensionsVariable.setCornerRedius(parkingYabOutlet)
        UIExtensionsVariable.setCornerRedius(jahatYabiOutlet)
        UIExtensionsVariable.setCornerRedius(sandoghNumbersOutlet)
        UIExtensionsVariable.setCornerRedius(ImHereOutlet)
        UIExtensionsVariable.setCornerRedius(eghdamat)
        UIExtensionsVariable.setCornerRedius(itCitizenOutlet)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        UserDefaults.standard.set(true, forKey: "isLoggedIn")

    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                let menu = storyboard!.instantiateViewController(withIdentifier: "sidemenu") as! SideMenuNavigationController
                present(menu, animated: true, completion: nil)
            default:
                break
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func sideMenu(_ sender: Any) {
        
    }
    @IBAction func sendProblemButton(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "problemsVc")
//        present(vc, animated: true, completion: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "problemsVc")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
        
        
        
//        let photos = PHPhotoLibrary.authorizationStatus()
//        if photos == .notDetermined {
//            PHPhotoLibrary.requestAuthorization({status in
//                if status == .authorized{
//                    print("OKAY")
//                } else {
//                    print("NOTOKAY")
//                }
//            })
//        }
//        checkLibrary()
//        checkPermission()
        
    }
    
    @IBAction func parkingFinderButton(_ sender: Any) {
        if let url = URL(string: "https://cafebazaar.ir/app/net.sefaresh.mycar") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func navigateButton(_ sender: Any) {
        if let url = URL(string: "https://www.gorgan.ir") {
            UIApplication.shared.open(url)
        }
    }
    
    //Ravabet omumi
    @IBAction func boxNumbersButton(_ sender: Any) {
        if let url = URL(string: "http://www.gorgan.ir/ravabetomomi.html") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func IAmHereButton(_ sender: Any) {
        if let url = URL(string: "https://maps.google.com/") {
            UIApplication.shared.open(url)
        }
    }
    // Setade khabari
    @IBAction func doneThingsButton(_ sender: Any) {
        
        let dialogMessage = UIAlertController(title: "تماس", message: "رئیس حراست: سید کمال الدین محب حسینی", preferredStyle: .alert)
        
        // Create OK button with action handler
        let call = UIAlertAction(title: "تماس", style: .default, handler: { (action) -> Void in

            if let url = URL(string: "tel://+981732231301") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        
        let email = UIAlertAction(title: "ایمیل", style: .default, handler: { (action) -> Void in
            print("email button tapped")
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self

            // Configure the fields of the interface.
            composeVC.setToRecipients(["heasat@gorgan.ir"])
            composeVC.setSubject("موضوع:")
            composeVC.setMessageBody("", isHTML: false)

            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)

        })
        
        let sms = UIAlertAction(title: "پیامک", style: .default, handler: { (action) -> Void in
            print("sms button tapped")

        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "بازگشت", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(call)
        dialogMessage.addAction(email)
        dialogMessage.addAction(sms)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    @IBAction func electronicCitizenButton(_ sender: Any) {
        
        
        let dialogMessage = UIAlertController(title: "شهروند الکترونیک", message: "", preferredStyle: .alert)
        
        // Create OK button with action handler
        let shahrnama = UIAlertAction(title: "شهرنما", style: .default, handler: { (action) -> Void in

            if let url = URL(string: "http://pano.gorgan.ir/shahrnama/") {
                UIApplication.shared.open(url)
            }
            
        })
        
        
        // Create Cancel button with action handlder
        let avarez = UIAlertAction(title: "پرداخت عوارض خودرو", style: .default) { (action) -> Void in
            if let url = URL(string: "http://cartax.gorgan.ir/web/guest/internetvmt") {
                UIApplication.shared.open(url)
            }
            
        }
        
        
        // Create Cancel button with action handlder
        let khadamateShahrvandi = UIAlertAction(title: "خدمات شهروندی", style: .default) { (action) -> Void in
            if let url = URL(string: "http://esup.gorgan.ir:8008/new/desk.html") {
                UIApplication.shared.open(url)
            }
            
        }

        
        // Create Cancel button with action handlder
        let pardakhteAvarez = UIAlertAction(title: "سامانه پرداخت عوارض نوسازی", style: .default) { (action) -> Void in
            if let url = URL(string: "http://esup.gorgan.ir:8008/new/desk.html?pgname=Fish") {
                UIApplication.shared.open(url)
            }
            
        }
        
        let cancel = UIAlertAction(title: "بازگشت", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(shahrnama)
        dialogMessage.addAction(avarez)
        dialogMessage.addAction(khadamateShahrvandi)
        dialogMessage.addAction(pardakhteAvarez)
        dialogMessage.addAction(cancel)

        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    
}
