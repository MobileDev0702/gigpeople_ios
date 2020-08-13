//
//  MyGigsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 14/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class MyGigsViewController: UIViewController,ADPageControlDelegate,UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var allVw: UIView!
    @IBOutlet weak var allTable: UITableView!
    
    @IBOutlet var activeCw: UIView!
    @IBOutlet weak var activeTable: UITableView!
    
    @IBOutlet var draftVw: UIView!
    @IBOutlet weak var draftTable: UITableView!
    
    @IBOutlet var deniedVw: UIView!
    @IBOutlet weak var deniedTable: UITableView!
    
    @IBOutlet weak var menuVw: UIView!
    
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
        pageModel1.strPageTitle = "All"
        pageModel1.iPageNumber = 0
        pageModel1.bShouldLazyLoad = true
        
        //page 2
        let pageModel2 = ADPageModel()
        pageModel2.strPageTitle = "Active"
        pageModel2.iPageNumber = 1
        pageModel2.bShouldLazyLoad = true
        
        //page 3
        let pageModel3 = ADPageModel()
        pageModel3.strPageTitle = "Draft/Paused"
        pageModel3.iPageNumber = 2
        pageModel3.bShouldLazyLoad = true
        
        //page 4
        let pageModel4 = ADPageModel()
        pageModel4.strPageTitle = "Denied"
        pageModel4.iPageNumber = 3
        pageModel4.bShouldLazyLoad = true
        
        //*** 2. Initialize page control ***
        searchpageControl = ADPageControl()
        searchpageControl!.delegateADPageControl = self
        searchpageControl!.arrPageModel = [pageModel1, pageModel2,pageModel3,pageModel4]
        
        let pageName = UserDefaults.standard.string(forKey: "NEW_GIG")
        if(pageName == "DRAFT")
        {
            UserDefaults.standard.removeObject(forKey: "NEW_GIG")
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
    @IBAction func menuBtn(_ sender: Any)
    {
        sideMenuController?.showLeftView(animated: true, completionHandler: nil)
    }
    @IBAction func addBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewGigViewController") as? AddNewGigViewController
        wc?.getPageFrom = "Add New Gig"
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    func adPageControlGetViewController(for pageModel: ADPageModel?) -> UIViewController?
    {
        if pageModel!.iPageNumber == 0
        {
            let page1 = UIViewController()
            allVw.frame = UIScreen.main.bounds
            page1.view.addSubview(allVw)
            return page1
        }
        else if pageModel!.iPageNumber == 1
        {
            let page1 = UIViewController()
            activeCw.frame = UIScreen.main.bounds
            page1.view.addSubview(activeCw)
            return page1
        }
        else if pageModel!.iPageNumber == 2
        {
            let page1 = UIViewController()
            draftVw.frame = UIScreen.main.bounds
            page1.view.addSubview(draftVw)
            return page1
        }
        else
        {
            let page1 = UIViewController()
            deniedVw.frame = UIScreen.main.bounds
            page1.view.addSubview(deniedVw)
            return page1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == allTable
        {
            return 4
        }
        else
        {
            return 2
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var nib = Bundle.main.loadNibNamed("SearchGigTableViewCell", owner: self, options: nil)
        let cell = nib?[0] as? SearchGigTableViewCell
        cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
        cell?.shareBtn.tag = indexPath.row
        cell?.shareBtn.addTarget(self, action: #selector(shareClicked), for: .touchUpInside)
        if tableView == allTable
        {
            if indexPath.row == 0
            {
                cell?.statusVw.backgroundColor = UIColor(red:0.00, green:0.62, blue:0.00, alpha:1.0)
                cell?.statusLbl.textColor = UIColor(red:0.00, green:0.62, blue:0.00, alpha:1.0)
                cell?.statusLbl.text = "Active"
            }
            else if indexPath.row == 1
            {
                cell?.statusVw.backgroundColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
                cell?.statusLbl.textColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
                cell?.statusLbl.text = "Denied"
            }
            else if indexPath.row == 2
            {
                cell?.statusVw.backgroundColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
                cell?.statusLbl.textColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
                cell?.statusLbl.text = "Draft/Paused"
            }
            else
            {
                cell?.statusVw.backgroundColor = UIColor(red:0.98, green:0.84, blue:0.00, alpha:1.0)
                cell?.statusLbl.textColor = UIColor(red:0.98, green:0.84, blue:0.00, alpha:1.0)
                cell?.statusLbl.text = "Waiting for Approval"
            }
        }
        else if tableView == activeTable
        {
            cell?.statusVw.backgroundColor = UIColor(red:0.00, green:0.62, blue:0.00, alpha:1.0)
            cell?.statusLbl.textColor = UIColor(red:0.00, green:0.62, blue:0.00, alpha:1.0)
            cell?.statusLbl.text = "Active"
        }
        else if tableView == draftTable
        {
            cell?.statusVw.backgroundColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
            cell?.statusLbl.textColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
            cell?.statusLbl.text = "Draft/Paused"
        }
        else
        {
            cell?.statusVw.backgroundColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
            cell?.statusLbl.textColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
            cell?.statusLbl.text = "Denied"
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == allTable
        {
            if indexPath.row == 0
            {
                let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ActiveGigDetailsViewController") as? ActiveGigDetailsViewController
                if let wc = wc
                {
                    navigationController?.pushViewController(wc, animated: true)
                }
            }
            else if indexPath.row == 2
            {
                let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DraftGigDetailsViewController") as? DraftGigDetailsViewController
                if let wc = wc
                {
                    navigationController?.pushViewController(wc, animated: true)
                }
            }
        }
        else if tableView == activeTable
        {
            let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ActiveGigDetailsViewController") as? ActiveGigDetailsViewController
            if let wc = wc
            {
                navigationController?.pushViewController(wc, animated: true)
            }
        }
        else if tableView == draftTable
        {
            let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DraftGigDetailsViewController") as? DraftGigDetailsViewController
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
