//
//  MySalesViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 13/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class MySalesViewController: UIViewController,ADPageControlDelegate,UITableViewDelegate, UITableViewDataSource,TPFloatRatingViewDelegate
{
    @IBOutlet weak var menuVw: UIView!
    @IBOutlet weak var reqVw: UIView!
    @IBOutlet weak var currentVw: UIView!
    @IBOutlet weak var completedVw: UIView!
    @IBOutlet weak var cancelledVw: UIView!
    @IBOutlet weak var reqTable: UITableView!
    @IBOutlet weak var currentTable: UITableView!
    @IBOutlet weak var completedTable: UITableView!
    @IBOutlet weak var cancelledTable: UITableView!
    
    var searchpageControl: ADPageControl?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        //page 1
        let pageModel1 = ADPageModel()
        pageModel1.strPageTitle = "Order Requests"
        pageModel1.iPageNumber = 0
        pageModel1.bShouldLazyLoad = true
        
        //page 2
        let pageModel2 = ADPageModel()
        pageModel2.strPageTitle = "Current"
        pageModel2.iPageNumber = 1
        pageModel2.bShouldLazyLoad = true
        
        //page 3
        let pageModel3 = ADPageModel()
        pageModel3.strPageTitle = "Completed"
        pageModel3.iPageNumber = 2
        pageModel3.bShouldLazyLoad = true
        
        //page 4
        let pageModel4 = ADPageModel()
        pageModel4.strPageTitle = "Cancelled"
        pageModel4.iPageNumber = 3
        pageModel4.bShouldLazyLoad = true
        
        //*** 2. Initialize page control ***
        searchpageControl = ADPageControl()
        searchpageControl!.delegateADPageControl = self
        searchpageControl!.arrPageModel = [pageModel1, pageModel2,pageModel3,pageModel4]
        
        let pageName = UserDefaults.standard.string(forKey: "ORDER_ACCEPT")
        if(pageName == "Yes")
        {
            UserDefaults.standard.removeObject(forKey: "ORDER_ACCEPT")
            searchpageControl!.iFirstVisiblePageNumber = 1
        }
        else if(pageName == "No")
        {
            UserDefaults.standard.removeObject(forKey: "ORDER_ACCEPT")
            searchpageControl!.iFirstVisiblePageNumber = 3
        }
        else if(pageName == "Completed")
        {
            UserDefaults.standard.removeObject(forKey: "ORDER_ACCEPT")
            searchpageControl!.iFirstVisiblePageNumber = 2
        }
        else
        {
            searchpageControl!.iFirstVisiblePageNumber = 0
        }
        
        //*** 3. Customize parameters (Optinal, as all have default value set) ***
        searchpageControl!.iTitleViewHeight = 40
        searchpageControl!.iPageIndicatorHeight = 4
        searchpageControl!.iCustomFixedTabWidth = Int32(view.bounds.size.width / 4)
        searchpageControl!.fontTitleTabText = UIFont(name: "Geomanist", size: 12)
        searchpageControl!.bEnablePagesEndBounceEffect = true
        searchpageControl!.bEnableTitlesEndBounceEffect = true
        searchpageControl!.colorTabText = UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0)
        searchpageControl!.colorTitleBarBackground = UIColor.white
        searchpageControl!.colorPageIndicator = UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0)
        searchpageControl!.bShowMoreTabAvailableIndicator = false
        searchpageControl!.view.frame = menuVw.frame
        view.addSubview(searchpageControl!.view)
    }
    @IBAction func menuBtn(_ sender: Any)
    {
        sideMenuController?.showLeftView(animated: true, completionHandler: nil)
    }
    func adPageControlGetViewController(for pageModel: ADPageModel?) -> UIViewController?
    {
        if pageModel!.iPageNumber == 0
        {
            let page1 = UIViewController()
            reqVw.frame = UIScreen.main.bounds
            page1.view.addSubview(reqVw)
            return page1
        }
        else if pageModel!.iPageNumber == 1
        {
            let page1 = UIViewController()
            currentVw.frame = UIScreen.main.bounds
            page1.view.addSubview(currentVw)
            return page1
        }
        else if pageModel!.iPageNumber == 2
        {
            let page1 = UIViewController()
            completedVw.frame = UIScreen.main.bounds
            page1.view.addSubview(completedVw)
            return page1
        }
        else
        {
            let page1 = UIViewController()
            cancelledVw.frame = UIScreen.main.bounds
            page1.view.addSubview(cancelledVw)
            return page1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == completedTable
        {
            var nib = Bundle.main.loadNibNamed("MySalesCompletedTableViewCell", owner: self, options: nil)
            let cell = nib?[0] as? MySalesCompletedTableViewCell
            cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
            
            let starRatingView = TPFloatRatingView(frame: (cell?.ratingVw.frame)!)
            starRatingView.delegate = self
            starRatingView.emptySelectedImage = UIImage(named: "foregroundStar")
            starRatingView.fullSelectedImage = UIImage(named: "backgroundStar")
            starRatingView.contentMode = UIView.ContentMode.scaleAspectFill
            starRatingView.maxRating = 5
            starRatingView.minRating = 0
            starRatingView.rating = 3.0
            starRatingView.editable = false
            starRatingView.halfRatings = true
            starRatingView.floatRatings = false
            cell?.contentView.addSubview(starRatingView)
            
            return cell!
        }
        else
        {
            var nib = Bundle.main.loadNibNamed("MySalesTableViewCell", owner: self, options: nil)
            let cell = nib?[0] as? MySalesTableViewCell
            cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
            return cell!
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == completedTable
        {
            let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MySalesCurrentAndCompletedViewController") as? MySalesCurrentAndCompletedViewController
            wc?.getPageFrom = "Completed"
            if let wc = wc
            {
                navigationController?.pushViewController(wc, animated: true)
            }
        }
        else if tableView == currentTable
        {
            let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MySalesCurrentAndCompletedViewController") as? MySalesCurrentAndCompletedViewController
            wc?.getPageFrom = "Current"
            if let wc = wc
            {
                navigationController?.pushViewController(wc, animated: true)
            }
        }
        else if tableView == reqTable
        {
            let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MySalesReqAndCancelledViewController") as? MySalesReqAndCancelledViewController
            wc?.getPageFrom = "Request"
            if let wc = wc
            {
                navigationController?.pushViewController(wc, animated: true)
            }
        }
        else if tableView == cancelledTable
        {
            let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MySalesReqAndCancelledViewController") as? MySalesReqAndCancelledViewController
            wc?.getPageFrom = "Cancelled"
            if let wc = wc
            {
                navigationController?.pushViewController(wc, animated: true)
            }
        }
    }
}
