//
//  LaunchViewController.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/22/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    let userLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if userLoggedIn {
            presentVC(vcID: "homeVc")
             print("YES")
         } else {
             print("NO")
            presentVC(vcID: "introVc")
        }
    }
    
    func presentVC(vcID: String) {
        print("Function Called")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: vcID)
        controller.modalTransitionStyle   = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
}
