//
//  UIExtensions.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/6/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit

class UIExtensions: UIViewController {

    static let shared = UIExtensions()
    
    fileprivate var currentVc: UIViewController?
    
    func hideNavigationBar(vc: UIViewController) {
        currentVc = vc
        currentVc?.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        currentVc?.navigationController?.navigationBar.shadowImage = UIImage()
        currentVc?.navigationController?.navigationBar.isTranslucent = true
        currentVc?.navigationController?.navigationBar.tintColor = .white
    }
    
    func setCornerRedius(_ button: UIButton) {
        button.layer.cornerRadius = button.frame.width / 2
    }
}
