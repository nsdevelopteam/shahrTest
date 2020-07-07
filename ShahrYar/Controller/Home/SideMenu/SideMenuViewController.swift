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
    
    let sideMenusOptions = ["● پروفایل"
        , "● اشتراک گذاری"
        , "● آرشیو ارسال مشکل‌ها"
        , "● اقدامات انجام شده"
        , "● مشکلات"
        , "● آموزش و راهنما"
        , "● پشتیبانی",
        "● خروجی"]
    
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
            //Profile
        case 0:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "registerVc")
            present(vc, animated: true, completion: nil)
            
            //share
        case 1:

            //Set the default sharing message.
             let message = "Share"
             //Set the link to share.
             if let link = NSURL(string: "http://gorgan.ir")
             {
                let objectsToShare = [message,link] as [Any]
                 let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
                self.present(activityVC, animated: true, completion: nil)
             }
            
            //archive
        case 2:
            let alert = UIAlertController(title: "خطا", message: "مجددا تلاش کنید", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "باشه", style: .default, handler: nil))

            self.present(alert, animated: true)
            
//            done things
        case 3:
            let alert = UIAlertController(title: "اقدامات انجام شده", message: "لطفا موضوع مورد نظر را انتخاب کنید", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "باشه", style: .default, handler: nil))

            self.present(alert, animated: true)
            
//            emergency numbers
        case 4:
            let alert = UIAlertController(title: "خطا", message: "مجددا تلاش کنید", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "باشه", style: .default, handler: nil))

            self.present(alert, animated: true)
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "emergencyVc")
//            present(vc, animated: true, completion: nil)
            
//            learn
        case 5:
            let alert = UIAlertController(title: "خطا", message: "مجددا تلاش کنید", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "باشه", style: .default, handler: nil))

            self.present(alert, animated: true)

            
//            support
        case 6:
            // Create new Alert
            let dialogMessage = UIAlertController(title: "پشتیبانی", message: "طراحی، اجرا و پشتیبانی: سفارش دات نت\nشماره تماس: ۰۲۱-۲۸۴۲۲۵۶۵\nایمیل: info@Sefaresh.net\nوب سایت: Sefaresh.net", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "باشه", style: .default, handler: { (action) -> Void in
             })
            
            //Add OK button to a dialog message
            dialogMessage.addAction(ok)
            // Present Alert to
            self.present(dialogMessage, animated: true, completion: nil)
            
            //logout
        case 7:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "introVc")
            present(vc, animated: true, completion: nil)
        default:
            break
        }
        
    }
}
