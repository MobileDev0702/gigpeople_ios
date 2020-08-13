//
//  HomeViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 04/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var objImageSliderView:ImageSliderView!
    @IBOutlet weak var bannerVw: UIView!
    @IBOutlet weak var tableObj: UITableView!
    
    var menuName = NSArray()
    var menuImage = NSArray()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true

        self.tableObj.tableFooterView = UIView()
        
        menuName = ["Graphic Design","Digital Marketing","Writing Translation","Video Animation"]
        menuImage = ["home_icon_one","home_icon_two","home_icon_three","home_icon_four"]
    }
    override func viewWillAppear(_ animated: Bool)
    {
        setupImageSwipeView()
        super.viewWillAppear(true)
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        if((objImageSliderView) != nil)
        {
            objImageSliderView.TimerStop()
        }
        super.viewWillDisappear(true)
    }
    func setupImageSwipeView()
    {
        let arrEmpty = ["banner_one","banner1","banner2","banner3"]
        let nibContents = Bundle.main.loadNibNamed("ImageSliderView", owner: nil, options: nil)
        objImageSliderView = (nibContents!.last! as! ImageSliderView)
        objImageSliderView.frame = bannerVw.bounds
        bannerVw.addSubview(objImageSliderView)
        let swiftArray = NSArray(array: arrEmpty) as? [String]
        self.objImageSliderView.initialize(arrImages: swiftArray!)
        objImageSliderView.TimerStart()
    }
    @IBAction func menuBtn(_ sender: Any)
    {
        sideMenuController?.showLeftView(animated: true, completionHandler: nil)
    }
    @IBAction func notificationsBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationsViewController") as? NotificationsViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func searchBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchDetailsViewController") as? SearchDetailsViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.menuName.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var nib = Bundle.main.loadNibNamed("HomeTableViewCell", owner: self, options: nil)
        let cell = nib?[0] as? HomeTableViewCell
        cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
        
        cell?.labelObj.text = menuName.object(at: indexPath.row) as? String
        cell?.imgObj.image = UIImage.init(named: menuImage.object(at: indexPath.row) as! String)
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubCategoryViewController") as? SubCategoryViewController
        wc?.getPageFrom = (menuName.object(at: indexPath.row) as? String)!
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
}
