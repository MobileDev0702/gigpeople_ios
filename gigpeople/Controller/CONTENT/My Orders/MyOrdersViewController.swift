//
//  MyOrdersViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 15/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class MyOrdersViewController: UIViewController,ADPageControlDelegate,UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var activeVw: UIView!
    @IBOutlet weak var activeTable: UITableView!
    
    @IBOutlet var deliveredVw: UIView!
    @IBOutlet weak var deliveredTable: UITableView!
    
    @IBOutlet var cancelledVw: UIView!
    @IBOutlet weak var cancelledTable: UITableView!
    
    @IBOutlet weak var menuVw: UIView!
    
    var searchpageControl: ADPageControl?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillAppear(_ animated: Bool)
    {
        UserDefaults.standard.set("Yes", forKey: "BADGE_BUTTON")
        super.viewWillAppear(true)
        
        //page 1
        let pageModel1 = ADPageModel()
        pageModel1.strPageTitle = "Active"
        pageModel1.iPageNumber = 0
        pageModel1.bShouldLazyLoad = true
        
        //page 2
        let pageModel2 = ADPageModel()
        pageModel2.strPageTitle = "Delivered"
        pageModel2.iPageNumber = 1
        pageModel2.bShouldLazyLoad = true
        
        //page 3
        let pageModel3 = ADPageModel()
        pageModel3.strPageTitle = "Cancelled"
        pageModel3.iPageNumber = 2
        pageModel3.bShouldLazyLoad = true
        
        //*** 2. Initialize page control ***
        searchpageControl = ADPageControl()
        searchpageControl!.delegateADPageControl = self
        searchpageControl!.arrPageModel = [pageModel1, pageModel2,pageModel3]
        
        //*** 3. Customize parameters (Optinal, as all have default value set) ***
        searchpageControl!.iFirstVisiblePageNumber = 0
        searchpageControl!.iTitleViewHeight = 40
        searchpageControl!.iPageIndicatorHeight = 4
        searchpageControl!.iCustomFixedTabWidth = Int32(view.bounds.size.width / 3)
        searchpageControl!.fontTitleTabText = UIFont(name: "Geomanist", size: 14)
        searchpageControl!.bEnablePagesEndBounceEffect = true
        searchpageControl!.bEnableTitlesEndBounceEffect = true
        searchpageControl!.colorTabText = UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0)
        searchpageControl!.colorTitleBarBackground = UIColor.white
        searchpageControl!.colorPageIndicator = UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0)
        searchpageControl!.bShowMoreTabAvailableIndicator = false
        searchpageControl!.view.frame = menuVw.frame
        view.addSubview(searchpageControl!.view)
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        UserDefaults.standard.removeObject(forKey: "BADGE_BUTTON")
        super.viewWillDisappear(true)
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
            activeVw.frame = UIScreen.main.bounds
            page1.view.addSubview(activeVw)
            return page1
        }
        else if pageModel!.iPageNumber == 1
        {
            let page1 = UIViewController()
            deliveredVw.frame = UIScreen.main.bounds
            page1.view.addSubview(deliveredVw)
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
        var nib = Bundle.main.loadNibNamed("MyOrdersTableViewCell", owner: self, options: nil)
        let cell = nib?[0] as? MyOrdersTableViewCell
        cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
        cell?.shareBtn.tag = indexPath.row
        cell?.shareBtn.addTarget(self, action: #selector(shareClicked), for: .touchUpInside)
        if indexPath.row == 0
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
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == self.activeTable
        {
            let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyOrderActiveDetailsViewController") as? MyOrderActiveDetailsViewController
            if let wc = wc
            {
                navigationController?.pushViewController(wc, animated: true)
            }
        }
        else if tableView == self.deliveredTable
        {
            let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyOrdersDeliveredDetailsViewController") as? MyOrdersDeliveredDetailsViewController
            if let wc = wc
            {
                navigationController?.pushViewController(wc, animated: true)
            }
        }
        else
        {
            let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyOrdersDeliveredDetailsViewController") as? MyOrdersDeliveredDetailsViewController
            wc?.getPageFrom = "Cancelled"
            if let wc = wc
            {
                navigationController?.pushViewController(wc, animated: true)
            }
        }
    }
    @IBAction func shareClicked(_ sender: UIButton)
    {
        print("Invite Friends")
        let theMessage = "gigpeople App Invite"
        let items = [theMessage]
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        presentActivityController(controller)
    }
    func presentActivityController(_ controller: UIActivityViewController?)
    {
        controller?.modalPresentationStyle = .popover
        if let controller = controller {
            present(controller, animated: true)
        }
        let popController: UIPopoverPresentationController? = controller?.popoverPresentationController
        popController?.permittedArrowDirections = .any
        popController?.barButtonItem = navigationItem.leftBarButtonItem
        controller?.completionWithItemsHandler =
            { activityType, completed, returnedItems, error in
                if completed
                {
                    print("Shared")
                }
                else
                {
                    print("We didn't want to share anything after all.")
                }
                if error != nil {
                    print("An Error occured: \(error?.localizedDescription ?? ""), \((error as NSError?)?.localizedFailureReason ?? "")")
                }
        }
    }
}
