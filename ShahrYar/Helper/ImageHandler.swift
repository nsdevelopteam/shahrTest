//
//  ImageHandlerViewController.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/16/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices

class ImageHandler: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    static let shared = ImageHandler()
    fileprivate var currentVC: UIViewController?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    func pickPhoto(vc: UIViewController) {
        currentVC = vc
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self
                myPickerController.sourceType = .photoLibrary
                myPickerController.mediaTypes = [kUTTypeJPEG as String, kUTTypeImage as String]
                self.currentVC?.present(myPickerController, animated: true)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            appDelegate.imageUrl = pickedImage
        }
        
        currentVC?.dismiss(animated: true, completion: nil)
    }
}
