//
//  ProblemsViewController.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/8/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Photos
import MobileCoreServices

class ProblemsViewController: UIViewController {
    
    @IBOutlet weak var problemsCollectionView: UICollectionView!
    @IBOutlet weak var rightButtonOutlet: UIBarButtonItem!
    let requestTypesURL = "http://moshkelateshahri.xyz/api/request-types/"
    let titles: [String] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        problemsCollectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
        navigationItem.title = "لطفا موضوع مورد نظر را انتخاب کنید"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "IRANSansMobile-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        rightButtonOutlet.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "IRANSansMobile", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        
        fetchData()
        
    }
    
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func fetchData() {
        AF.request(requestTypesURL,
           method: .get).responseJSON { (responseData) -> Void in
            if((responseData.value) != nil) {
                let result = JSON(responseData.value!)
//                print(result)
                for (_, res) in result {
//                    print(res["title"])
                    self.title?.append(res["title"].string ?? "title")
                    
                }
            }
        }
    }
    
}




extension ProblemsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let problemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "problemsCell", for: indexPath) as! ProblemsCell
        
        problemCell.imageView.image = UIImage(named: "problem" + "-\(indexPath.row + 1)")
        
        return problemCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: 110, height: 128)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            print("0")
            appDelegate.numberOfProblem = "0"
        case 1:
            print("1")
            appDelegate.numberOfProblem = "1"
        case 2:
            print("2")
            appDelegate.numberOfProblem = "2"

        case 3:
            print("3")
            appDelegate.numberOfProblem = "3"

        case 4:
            print("4")
            appDelegate.numberOfProblem = "4"

        case 5:
            print("5")
            appDelegate.numberOfProblem = "5"

        case 6:
            print("6")

            appDelegate.numberOfProblem = "6"
        case 7:
            print("7")
            appDelegate.numberOfProblem = "7"
        case 8:
            print("8")
            appDelegate.numberOfProblem = "8"

        default:
            break
        }
        
        let selectImageAlert = UIAlertController(title: "ارسال مشکل", message: "لطفا نحوه‌ی ارسال مشکل را انتخاب کنید", preferredStyle: .actionSheet)

        let openPhotos = UIAlertAction(title: "ارسال مشکل با عکس", style: .default) { (action) in
                             // Open photos
            
            DispatchQueue.main.async {
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let myPickerController = UIImagePickerController()
                    myPickerController.delegate = self
                    myPickerController.sourceType = .photoLibrary
                    myPickerController.mediaTypes = [kUTTypeJPEG as String, kUTTypeImage as String]
                    self.present(myPickerController, animated: true)
                }
            }
            
                }

        let goWithoutImage = UIAlertAction(title: "ارسال مشکل بدون عکس", style: .default) { (action) in
                             // Open maps
                    
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mapVc")
            self.present(vc, animated: true, completion: nil)
                }
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)


        selectImageAlert.addAction(openPhotos)
        selectImageAlert.addAction(goWithoutImage)
        selectImageAlert.addAction(cancel)

        selectImageAlert.popoverPresentationController?.sourceView = self.view
        selectImageAlert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        selectImageAlert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        self.present(selectImageAlert, animated: true)

    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            print("pickedImage triggerd")
            appDelegate.selectedImageProblems = pickedImage
            
        }
        
        dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mapVc")
        self.present(vc, animated: true, completion: nil)
    }
    
}
