//
//  FavouritesViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 13/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController,ADPageControlDelegate,UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var menuVw: UIView!
    @IBOutlet weak var sellerVw: UIView!
    @IBOutlet weak var gigVw: UIView!
    @IBOutlet weak var sellerTable: UITableView!
    @IBOutlet weak var gigTable: UITableView!
    
    var searchpageControl: ADPageControl?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true

        //page 1
        let pageModel1 = ADPageModel()
        pageModel1.strPageTitle = "Seller"
        pageModel1.iPageNumber = 0
        pageModel1.bShouldLazyLoad = true
        
        //page 2
        let pageModel2 = ADPageModel()
        pageModel2.strPageTitle = "Gig"
        pageModel2.iPageNumber = 1
        pageModel2.bShouldLazyLoad = true
        
        //*** 2. Initialize page control ***
        searchpageControl = ADPageControl()
        searchpageControl!.delegateADPageControl = self
        searchpageControl!.arrPageModel = [pageModel1, pageModel2]
        
        //*** 3. Customize parameters (Optinal, as all have default value set) ***
        searchpageControl!.iFirstVisiblePageNumber = 0
        searchpageControl!.iTitleViewHeight = 40
        searchpageControl!.iPageIndicatorHeight = 4
        searchpageControl!.iCustomFixedTabWidth = Int32(view.bounds.size.width / 2)
        searchpageControl!.fontTitleTabText = UIFont(name: "Geomanist", size: 16)
        searchpageControl!.bEnablePagesEndBounceEffect = true
        searchpageControl!.bEnableTitlesEndBounceEffect = true
        searchpageControl!.colorTabText = UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0)
        searchpageControl!.colorTitleBarBackground = UIColor.white
        searchpageControl!.colorPageIndicator = UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0)
        searchpageControl!.bShowMoreTabAvailableIndicator = false
        searchpageControl!.view.frame = menuVw.frame
        view.addSubview(searchpageControl!.view)
    }
    func adPageControlGetViewController(for pageModel: ADPageModel?) -> UIViewController?
    {
        if pageModel!.iPageNumber == 0
        {
            let page1 = UIViewController()
            sellerVw.frame = UIScreen.main.bounds
            page1.view.addSubview(sellerVw)
            return page1
        }
        else
        {
            let page1 = UIViewController()
            gigVw.frame = UIScreen.main.bounds
            page1.view.addSubview(gigVw)
            return page1
        }
    }
    private func adPageControlCurrentVisiblePageIndex(_ iCurrentVisiblePage: Int)
    {
        if iCurrentVisiblePage == 0
        {
            print("Page Visible \(iCurrentVisiblePage)")
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == sellerTable
        {
            return 6
        }
        else
        {
            return 3
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == sellerTable
        {
            var nib = Bundle.main.loadNibNamed("FavSellerTableViewCell", owner: self, options: nil)
            let cell = nib?[0] as? FavSellerTableViewCell
            cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
            
            cell?.favBtn.tag = indexPath.row
            cell?.favBtn.addTarget(self, action: #selector(favClicked), for: .touchUpInside)
            
            return cell!
        }
        else
        {
            var nib = Bundle.main.loadNibNamed("FavGigTableViewCell", owner: self, options: nil)
            let cell = nib?[0] as? FavGigTableViewCell
            cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
            
            if (indexPath.row % 2 == 0)
            {
                cell?.statusVw.backgroundColor = UIColor(red:0.00, green:0.62, blue:0.00, alpha:1.0)
                cell?.statusLbl.textColor = UIColor(red:0.00, green:0.62, blue:0.00, alpha:1.0)
                cell?.statusLbl.text = "Online"
            }
            else
            {
                cell?.statusVw.backgroundColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
                cell?.statusLbl.textColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
                cell?.statusLbl.text = "Offline"

            }
            
            cell?.favBtn.tag = indexPath.row
            cell?.favBtn.addTarget(self, action: #selector(gigfavClicked), for: .touchUpInside)
            
            return cell!
        }
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == sellerTable
        {
            let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchUserDetailsViewController") as? SearchUserDetailsViewController
            if let wc = wc
            {
                navigationController?.pushViewController(wc, animated: true)
            }
        }
        else
        {
            let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GigDetailsViewController") as? GigDetailsViewController
            if let wc = wc
            {
                navigationController?.pushViewController(wc, animated: true)
            }
        }
    }
    @IBAction func favClicked(_ sender: UIButton)
    {
        let myIndexPath = NSIndexPath(row: sender.tag, section: 0)
        let cell = self.sellerTable.cellForRow(at: myIndexPath as IndexPath) as? FavSellerTableViewCell
        
        if (cell?.favBtn.currentImage?.isEqual(UIImage(named: "fav_line")))!
        {
            cell?.favBtn.setImage(UIImage.init(named: "fav_icon"), for: .normal)
        }
        else
        {
            cell?.favBtn.setImage(UIImage.init(named: "fav_line"), for: .normal)
        }
    }
    @IBAction func gigfavClicked(_ sender: UIButton)
    {
        let myIndexPath = NSIndexPath(row: sender.tag, section: 0)
        let cell = self.gigTable.cellForRow(at: myIndexPath as IndexPath) as? FavGigTableViewCell
        
        if (cell?.favBtn.currentImage?.isEqual(UIImage(named: "fav_line")))!
        {
            cell?.favBtn.setImage(UIImage.init(named: "fav_icon"), for: .normal)
        }
        else
        {
            cell?.favBtn.setImage(UIImage.init(named: "fav_line"), for: .normal)
        }
    }
    @IBAction func menuBtn(_ sender: Any)
    {
        sideMenuController?.showLeftView(animated: true, completionHandler: nil)
    }
}
