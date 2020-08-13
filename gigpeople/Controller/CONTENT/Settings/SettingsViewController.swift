//
//  SettingsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 12/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit
import FCAlertView

class SettingsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, FCAlertViewDelegate
{
    var menuName = NSArray()
    var menuImage = NSArray()
    
    var menu2Name = NSArray()
    var menu2Image = NSArray()
    
    var menu3Name = NSArray()
    var menu3Image = NSArray()
    
    var menu4Name = NSArray()
    var menu4Image = NSArray()

    @IBOutlet weak var tableObj: UITableView!
    
    override func viewDidLoad()
    {
        navigationController?.isNavigationBarHidden = true

        menuName = ["Customer Orders","Push Notifications"]
        menuImage = ["purchase_order","settings_push"]
        
        menu2Name = ["Change Password","Analytics","Payment History","Billing"]
        menu2Image = ["settings_changepwd","analytics_icon","settings_payment","settings_billing"]
        
        menu3Name = ["Terms & Conditions","Privacy policy","Help & Support"]
        menu3Image = ["settings_terms","settings_privacy","setting_cc"]
        
        menu4Name = ["Logout"]
        menu4Image = ["settings_logout"]
        
        self.tableObj.tableFooterView = UIView()

        super.viewDidLoad()
    }
    @IBAction func menuBtn(_ sender: Any)
    {
        sideMenuController?.showLeftView(animated: true, completionHandler: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return self.menuName.count
        }
        else if section == 1
        {
            return self.menu2Name.count
        }
        else if section == 2
        {
            return self.menu3Name.count
        }
        else
        {
            return self.menu4Name.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var nib = Bundle.main.loadNibNamed("LeftMenuTableViewCell", owner: self, options: nil)
        let cell = nib?[0] as? LeftMenuTableViewCell
        cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
        cell?.contentView.backgroundColor = UIColor.white
        if indexPath.section == 0
        {
            cell?.switchObj.isHidden = false
            cell?.labelObj.text = menuName.object(at: indexPath.row) as? String
            cell?.imgObj.image = UIImage.init(named: menuImage.object(at: indexPath.row) as! String)
        }
        else if indexPath.section == 1
        {
            cell?.labelObj.text = menu2Name.object(at: indexPath.row) as? String
            cell?.imgObj.image = UIImage.init(named: menu2Image.object(at: indexPath.row) as! String)
        }
        else if indexPath.section == 2
        {
            cell?.labelObj.text = menu3Name.object(at: indexPath.row) as? String
            cell?.imgObj.image = UIImage.init(named: menu3Image.object(at: indexPath.row) as! String)
        }
        else
        {
            cell?.labelObj.text = menu4Name.object(at: indexPath.row) as? String
            cell?.imgObj.image = UIImage.init(named: menu4Image.object(at: indexPath.row) as! String)
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 1
        {
            if indexPath.row == 0
            {
                let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditPasswordViewController") as? EditPasswordViewController
                if let wc = wc
                {
                    navigationController?.pushViewController(wc, animated: true)
                }
            }
            else if indexPath.row == 1
            {
                let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnalyticsViewController") as? AnalyticsViewController
                if let wc = wc
                {
                    navigationController?.pushViewController(wc, animated: true)
                }
            }
            else if indexPath.row == 2
            {
                let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaymentHistoryViewController") as? PaymentHistoryViewController
                if let wc = wc
                {
                    navigationController?.pushViewController(wc, animated: true)
                }
            }
            else if indexPath.row == 3
            {
                let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BillingViewController") as? BillingViewController
                if let wc = wc
                {
                    navigationController?.pushViewController(wc, animated: true)
                }
            }
        }
        else if indexPath.section == 2
        {
            if indexPath.row == 0
            {
                let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TermsViewController") as? TermsViewController
                wc?.getPageFrom = "Terms & Conditions"
                if let wc = wc
                {
                    navigationController?.pushViewController(wc, animated: true)
                }
            }
            else if indexPath.row == 1
            {
                let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TermsViewController") as? TermsViewController
                wc?.getPageFrom = "Privacy Policy"
                if let wc = wc
                {
                    navigationController?.pushViewController(wc, animated: true)
                }
            }
            else if indexPath.row == 2
            {
                let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HelpSupportViewController") as? HelpSupportViewController
                if let wc = wc
                {
                    navigationController?.pushViewController(wc, animated: true)
                }
            }
        }
        else
        {
            if indexPath.section != 0
            {
                let arrayOfButtonTitles = ["Yes", "No"]
                let cusAlert = FCAlertView()
                cusAlert.delegate = self
                cusAlert.showAlert(inView: self, withTitle: "Logout", withSubtitle: "Are you sure you want to logout?", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: arrayOfButtonTitles)
                cusAlert.hideDoneButton = true
                cusAlert.titleFont = UIFont(name: "Geomanist", size: 20)
                cusAlert.titleColor = UIColor.black
                cusAlert.subtitleFont = UIFont(name: "Geomanist", size: 18)
                cusAlert.subTitleColor = UIColor.black
                cusAlert.firstButtonBackgroundColor = UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0)
                cusAlert.secondButtonBackgroundColor = UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0)
                cusAlert.firstButtonCustomFont = UIFont(name: "Geomanist", size: 16)
                cusAlert.secondButtonCustomFont = UIFont(name: "Geomanist", size: 16)
                cusAlert.firstButtonTitleColor = UIColor.white
                cusAlert.secondButtonTitleColor = UIColor.white
            }
        }
    }
    func fcAlertView(_ alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String)
    {
        if title == "Yes"
        {
            let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
            var naviObj: UINavigationController? = nil
            if let wc = wc
            {
                naviObj = UINavigationController(rootViewController: wc)
            }
            UIApplication.shared.keyWindow?.rootViewController = naviObj
        }
    }
}
