//
//  HomeViewController.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/5/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit
import SideMenu


class HomeViewController: UIViewController {
    
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
    
}
