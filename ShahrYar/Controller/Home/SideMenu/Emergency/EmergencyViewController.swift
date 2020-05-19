//
//  EmergencyViewController.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/19/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit

class EmergencyViewController: UIViewController {

    @IBOutlet weak var emergencyTableView: UITableView!
    @IBOutlet weak var dismissOutlet: UIBarButtonItem!
    
    let numbers = ["119", "118"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "IRANSansMobile-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        dismissOutlet.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "IRANSansMobile", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }

    @IBAction func dismissAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension EmergencyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let emergencyCell = tableView.dequeueReusableCell(withIdentifier: "emergencyCell", for: indexPath)
        
        emergencyCell.textLabel?.text = numbers[indexPath.row]
        
        return emergencyCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
