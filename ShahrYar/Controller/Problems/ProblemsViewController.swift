//
//  ProblemsViewController.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/8/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit

class ProblemsViewController: UIViewController {
    
    @IBOutlet weak var problemsCollectionView: UICollectionView!
    @IBOutlet weak var rightButtonOutlet: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        problemsCollectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
        navigationItem.title = "لطفا موضوع مورد نظر را انتخاب کنید"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "IRANSansMobile-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        rightButtonOutlet.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "IRANSansMobile", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        
    }
    
    @IBAction func dismissView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension ProblemsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
}
