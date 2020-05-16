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
}
