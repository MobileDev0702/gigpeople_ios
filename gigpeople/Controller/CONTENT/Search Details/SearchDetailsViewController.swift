//
//  SearchDetailsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 05/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class SearchDetailsViewController: UIViewController,ADPageControlDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var menuVw: UIView!
    @IBOutlet weak var userVw: UIView!
    @IBOutlet weak var gigVw: UIView!
    @IBOutlet weak var userCollectionObj: UICollectionView!
    @IBOutlet weak var gigTable: UITableView!
    
    var searchpageControl: ADPageControl?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        userCollectionObj.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserCollectionViewCell")


        //page 1
        let pageModel1 = ADPageModel()
        pageModel1.strPageTitle = "User"
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
            userVw.frame = UIScreen.main.bounds
            page1.view.addSubview(userVw)
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
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath as IndexPath) as! UserCollectionViewCell
        cell.layer.cornerRadius =  5
        cell.clipsToBounds = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchUserDetailsViewController") as? SearchUserDetailsViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var nib = Bundle.main.loadNibNamed("SearchGigTableViewCell", owner: self, options: nil)
        let cell = nib?[0] as? SearchGigTableViewCell
        cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
        cell?.shareBtn.tag = indexPath.row
        cell?.shareBtn.addTarget(self, action: #selector(shareClicked), for: .touchUpInside)
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GigDetailsViewController") as? GigDetailsViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func shareClicked(_ sender: UIButton)
    {
        print("Invite Friends")
        let theMessage = "Gigpeople App Invite"
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
