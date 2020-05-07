//
//  SideMenuTableViewController.swift
//  ShahrYar
//
//  Created by Nima Akbarzade on 5/7/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func profileButton(_ sender: Any) {
        //Present to Edit and register VC
    }
    
    @IBAction func shareButton(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: ["برنامه‌ی شهر یار را از اناردونی دانلود کنید Anardoni.com"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        present(activityVC, animated: true, completion: nil)
        activityVC.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in

            if completed  {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func ArchiveButton(_ sender: Any) {
        
    }
    
    @IBAction func completeButton(_ sender: Any) {
        
    }
    
    @IBAction func emergencyNumbersButton(_ sender: Any) {
        
    }
    
    @IBAction func learnAndGuidButton(_ sender: Any) {
    }
    
    @IBAction func supportButton(_ sender: Any) {
    }
    
    @IBAction func exitButton(_ sender: Any) {
    }
    

}
