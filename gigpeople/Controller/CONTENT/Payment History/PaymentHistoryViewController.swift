//
//  PaymentHistoryViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 12/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class PaymentHistoryViewController: UIViewController,ADPageControlDelegate,UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var menuVw: UIView!
    @IBOutlet weak var spentVw: UIView!
    @IBOutlet weak var earnedVw: UIView!
    @IBOutlet weak var spentTable: UITableView!
    @IBOutlet weak var earnedTable: UITableView!
    
    var searchpageControl: ADPageControl?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //page 1
        let pageModel1 = ADPageModel()
        pageModel1.strPageTitle = "Amount Spent"
        pageModel1.iPageNumber = 0
        pageModel1.bShouldLazyLoad = true
        
        //page 2
        let pageModel2 = ADPageModel()
        pageModel2.strPageTitle = "Amount Earned"
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
            spentVw.frame = UIScreen.main.bounds
            page1.view.addSubview(spentVw)
            return page1
        }
        else
        {
            let page1 = UIViewController()
            earnedVw.frame = UIScreen.main.bounds
            page1.view.addSubview(earnedVw)
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
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var nib = Bundle.main.loadNibNamed("PaymentHistoryTableViewCell", owner: self, options: nil)
        let cell = nib?[0] as? PaymentHistoryTableViewCell
        cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == self.earnedTable
        {
            let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MySalesCurrentAndCompletedViewController") as? MySalesCurrentAndCompletedViewController
            wc?.getPageFrom = "Completed"
            if let wc = wc
            {
                navigationController?.pushViewController(wc, animated: true)
            }
        }
        else
        {
            let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyOrdersDeliveredDetailsViewController") as? MyOrdersDeliveredDetailsViewController
            wc?.getPageFrom = "Payment"
            if let wc = wc
            {
                navigationController?.pushViewController(wc, animated: true)
            }
        }
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
