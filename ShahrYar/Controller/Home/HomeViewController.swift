//
//  HomeViewController.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/5/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var sendProblemOutlet: UIButton!
    @IBOutlet weak var parkingYabOutlet: UIButton!
    @IBOutlet weak var jahatYabiOutlet: UIButton!
    @IBOutlet weak var sandoghNumbersOutlet: UIButton!
    @IBOutlet weak var ImHereOutlet: UIButton!
    @IBOutlet weak var eghdamat: UIButton!
    @IBOutlet weak var itCitizenOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCornerRedius(sendProblemOutlet)
        setCornerRedius(parkingYabOutlet)
        setCornerRedius(jahatYabiOutlet)
        setCornerRedius(sandoghNumbersOutlet)
        setCornerRedius(ImHereOutlet)
        setCornerRedius(eghdamat)
        setCornerRedius(itCitizenOutlet)
    }
    
    func setCornerRedius(_ button: UIButton) {
        button.layer.cornerRadius = button.frame.width / 2
    }
    
}
