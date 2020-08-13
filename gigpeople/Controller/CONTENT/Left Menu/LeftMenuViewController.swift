//
//  LeftMenuViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 04/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit
import FCAlertView

class LeftMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FCAlertViewDelegate
{
    var menuName = NSArray()
    var menuImage = NSArray()
    
    var menu2Name = NSArray()
    var menu2Image = NSArray()
    
    var menu3Name = NSArray()
    var menu3Image = NSArray()
    
    @IBOutlet weak var tableObj: UITableView!
    @IBOutlet weak var profilePic: NZCircularImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        menuName = ["Home","Gig Requests","My Gigs","My Sales"]
        menuImage = ["home_icon","buyers_request_icon","mygigs_icon","my_sales_icon"]
        
        menu2Name = ["Manage Requests","My Orders"]
        menu2Image = ["manage_request_icon","my_orders_icon"]
        
        menu3Name = ["Favourites","Chat","Withdrawal","Settings","Logout"]
        menu3Image = ["fav_line","chat_icon","withdrawls_icon","setting_icon","settings_logout"]
        
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        self.tableObj.tableHeaderView = UIView(frame: frame)
        
        self.tableObj.separatorColor = UIColor.red
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        var screenWidth: CGFloat = UIScreen.main.bounds.size.width / 3
        screenWidth = screenWidth * 2.4
        let inView = UIView(frame: CGRect(x: 20, y: 0, width: screenWidth - 40, height: 1))
        inView.backgroundColor = UIColor.darkGray
        view.addSubview(inView)
        view.backgroundColor = UIColor.clear
        return view
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 3
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
        else
        {
            return self.menu3Name.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var nib = Bundle.main.loadNibNamed("LeftMenuTableViewCell", owner: self, options: nil)
        let cell = nib?[0] as? LeftMenuTableViewCell
        cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
        
        if indexPath.section == 0
        {
            cell?.labelObj.text = menuName.object(at: indexPath.row) as? String
            cell?.imgObj.image = UIImage.init(named: menuImage.object(at: indexPath.row) as! String)
        }
        else if indexPath.section == 1
        {
            cell?.labelObj.text = menu2Name.object(at: indexPath.row) as? String
            cell?.imgObj.image = UIImage.init(named: menu2Image.object(at: indexPath.row) as! String)
        }
        else
        {
            cell?.labelObj.text = menu3Name.object(at: indexPath.row) as? String
            cell?.imgObj.image = UIImage.init(named: menu3Image.object(at: indexPath.row) as! String)
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
                var naviVC: UINavigationController? = nil
                if let homeVC = homeVC
                {
                    naviVC = UINavigationController(rootViewController: homeVC)
                }
                sideMenuController!.rootViewController = naviVC
                sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
            }
            else if indexPath.row == 1
            {
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BrowseRequestsViewController") as? BrowseRequestsViewController
                var naviVC: UINavigationController? = nil
                if let homeVC = homeVC
                {
                    naviVC = UINavigationController(rootViewController: homeVC)
                }
                sideMenuController!.rootViewController = naviVC
                sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
            }
            else if indexPath.row == 2
            {
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyGigsViewController") as? MyGigsViewController
                var naviVC: UINavigationController? = nil
                if let homeVC = homeVC
                {
                    naviVC = UINavigationController(rootViewController: homeVC)
                }
                sideMenuController!.rootViewController = naviVC
                sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
            }
            else if indexPath.row == 3
            {
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MySalesViewController") as? MySalesViewController
                var naviVC: UINavigationController? = nil
                if let homeVC = homeVC
                {
                    naviVC = UINavigationController(rootViewController: homeVC)
                }
                sideMenuController!.rootViewController = naviVC
                sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
            }
        }
        else if indexPath.section == 1
        {
            if indexPath.row == 0
            {
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ManageRequestsViewController") as? ManageRequestsViewController
                var naviVC: UINavigationController? = nil
                if let homeVC = homeVC
                {
                    naviVC = UINavigationController(rootViewController: homeVC)
                }
                sideMenuController!.rootViewController = naviVC
                sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
            }
            else if indexPath.row == 1
            {
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyOrdersViewController") as? MyOrdersViewController
                var naviVC: UINavigationController? = nil
                if let homeVC = homeVC
                {
                    naviVC = UINavigationController(rootViewController: homeVC)
                }
                sideMenuController!.rootViewController = naviVC
                sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
            }
        }
        else
        {
            if indexPath.row == 0
            {
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavouritesViewController") as? FavouritesViewController
                var naviVC: UINavigationController? = nil
                if let homeVC = homeVC
                {
                    naviVC = UINavigationController(rootViewController: homeVC)
                }
                sideMenuController!.rootViewController = naviVC
                sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
            }
            else if indexPath.row == 1
            {
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatListViewController") as? ChatListViewController
                var naviVC: UINavigationController? = nil
                if let homeVC = homeVC
                {
                    naviVC = UINavigationController(rootViewController: homeVC)
                }
                sideMenuController!.rootViewController = naviVC
                sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
            }
            else if indexPath.row == 2
            {
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WithdrawalsViewController") as? WithdrawalsViewController
                var naviVC: UINavigationController? = nil
                if let homeVC = homeVC
                {
                    naviVC = UINavigationController(rootViewController: homeVC)
                }
                sideMenuController!.rootViewController = naviVC
                sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
            }
            else if indexPath.row == 3
            {
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
                var naviVC: UINavigationController? = nil
                if let homeVC = homeVC
                {
                    naviVC = UINavigationController(rootViewController: homeVC)
                }
                sideMenuController!.rootViewController = naviVC
                sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
            }
            else if indexPath.row == 4
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
    @IBAction func profileBtn(_ sender: Any)
    {
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyProfileViewController") as? MyProfileViewController
        var naviVC: UINavigationController? = nil
        if let homeVC = homeVC
        {
            naviVC = UINavigationController(rootViewController: homeVC)
        }
        sideMenuController!.rootViewController = naviVC
        sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
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
