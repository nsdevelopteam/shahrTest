//
//  SideMenuViewController.swift
//  ShahrYar
//
//  Created by Sina Rabiei on 5/8/20.
//  Copyright © 2020 Sina Rabiei. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    let defaults = UserDefaults.standard
    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    let sideMenusOptions = ["● پروفایل", "● اشتراک گذاری", "● آرشیو ارسال مشکل‌ها", "● اقدامات انجام شده", "● شماره های ضروری", "● آموزش و راهنما", "● پشتیبانی", "● خروجی"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = defaults.string(forKey: "Name")
        phoneNumberLabel.text = defaults.string(forKey: "Number")

        sideMenuTableView.tableHeaderView = headerView
        sideMenuTableView.tableFooterView = UIView()
        sideMenuTableView.separatorColor = .clear
    }
}


extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenusOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sideMenuCell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell", for: indexPath)
        
        sideMenuCell.textLabel?.text = sideMenusOptions[indexPath.row]
        sideMenuCell.textLabel?.textAlignment = .right
        sideMenuCell.textLabel?.textColor = .white
        sideMenuCell.textLabel?.font = UIFont(name: "IRANSansMobile", size: 17)
        sideMenuCell.selectionStyle = .none
        
        return sideMenuCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "registerVc")
            present(vc, animated: true, completion: nil)
        default:
            break
        }
        
    }
}
