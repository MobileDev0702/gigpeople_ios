//
//  BrowseRequestsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 14/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit
import SelectionList
import GooglePlaces

class BrowseRequestsViewController: UIViewController,ADPageControlDelegate, UICollectionViewDataSource, UICollectionViewDelegate, GMSAutocompleteViewControllerDelegate
{
    @IBOutlet weak var menuVw: UIView!
    @IBOutlet var nwVw: UIView!
    @IBOutlet weak var nwCollectionObj: UICollectionView!
    @IBOutlet var offerVw: UIView!
    @IBOutlet weak var offerCollectionObj: UICollectionView!
    
    @IBOutlet var filterVw: UIView!
    @IBOutlet weak var filterInVw: UIView!
    @IBOutlet weak var locationFld: UITextField!
    
    @IBOutlet weak var graphicsList: SelectionList!
    @IBOutlet weak var digitalList: SelectionList!
    
    
    var searchpageControl: ADPageControl?

    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true

        nwCollectionObj.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserCollectionViewCell")
        offerCollectionObj.register(UINib(nibName: "UserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserCollectionViewCell")
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        //page 1
        let pageModel1 = ADPageModel()
        pageModel1.strPageTitle = "New"
        pageModel1.iPageNumber = 0
        pageModel1.bShouldLazyLoad = true
        
        //page 2
        let pageModel2 = ADPageModel()
        pageModel2.strPageTitle = "Offers Sent"
        pageModel2.iPageNumber = 1
        pageModel2.bShouldLazyLoad = true
        
        //*** 2. Initialize page control ***
        searchpageControl = ADPageControl()
        searchpageControl!.delegateADPageControl = self
        searchpageControl!.arrPageModel = [pageModel1, pageModel2]
        
        let pageName = UserDefaults.standard.string(forKey: "OFFER_ACCEPT")
        if(pageName == "Yes")
        {
            UserDefaults.standard.removeObject(forKey: "OFFER_ACCEPT")
            searchpageControl!.iFirstVisiblePageNumber = 1
        }
        else
        {
            searchpageControl!.iFirstVisiblePageNumber = 0
        }
        //*** 3. Customize parameters (Optinal, as all have default value set) ***
        
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
        
        graphicsList.items = ["Web Designing", "Logo Design"]
        graphicsList.tableView.separatorStyle = .none
        graphicsList.tableView.isScrollEnabled = false
        graphicsList.setupCell =  { (cell: UITableViewCell, index: Int) in
            cell.textLabel?.font = UIFont(name: "Geomanist", size: 14)
            cell.textLabel?.textColor = UIColor.darkGray
        }
        graphicsList.addTarget(self, action: #selector(selectionChanged), for: .valueChanged)
        
        digitalList.items = ["Email Marketing", "Digital Marketing", "Influencer Marketing"]
        digitalList.tableView.separatorStyle = .none
        digitalList.tableView.isScrollEnabled = false
        digitalList.setupCell =  { (cell: UITableViewCell, index: Int) in
            cell.textLabel?.font = UIFont(name: "Geomanist", size: 14)
            cell.textLabel?.textColor = UIColor.darkGray
        }
        digitalList.addTarget(self, action: #selector(digitalSelectionChanged), for: .valueChanged)
    }
    @objc func selectionChanged()
    {
        print(graphicsList.selectedIndexes)
    }
    @objc func digitalSelectionChanged()
    {
        print(digitalList.selectedIndexes)
    }
    func adPageControlGetViewController(for pageModel: ADPageModel?) -> UIViewController?
    {
        if pageModel!.iPageNumber == 0
        {
            let page1 = UIViewController()
            nwVw.frame = UIScreen.main.bounds
            page1.view.addSubview(nwVw)
            return page1
        }
        else
        {
            let page1 = UIViewController()
            offerVw.frame = UIScreen.main.bounds
            page1.view.addSubview(offerVw)
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
    @IBAction func menuBtn(_ sender: Any)
    {
        sideMenuController?.showLeftView(animated: true, completionHandler: nil)
    }
    @IBAction func filterBtn(_ sender: Any)
    {
        filterVw.frame = UIScreen.main.bounds
        view.addSubview(filterVw)
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
        if collectionView == nwCollectionObj
        {
            let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NwBrowseRequestDetailsViewController") as? NwBrowseRequestDetailsViewController
            if let wc = wc
            {
                navigationController?.pushViewController(wc, animated: true)
            }
        }
        else
        {
            let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OfferRequestDetailsViewController") as? OfferRequestDetailsViewController
            wc?.getPageFrom = "\(indexPath.row)"
            if let wc = wc
            {
                navigationController?.pushViewController(wc, animated: true)
            }
        }
    }
    @IBAction func filterCloseBtn(_ sender: Any)
    {
        filterVw.removeFromSuperview()
    }
    @IBAction func filterSubmitBtn(_ sender: Any)
    {
        filterVw.removeFromSuperview()
    }
    @IBAction func locationBtn(_ sender: Any)
    {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        UINavigationBar.appearance().barTintColor = UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        if #available(iOS 9.0, *)
        {
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        else
        {
            print("Check")
        }
        present(autocompleteController, animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace)
    {
        self.locationFld.text = place.formattedAddress
        dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error)
    {
        print("Error: ", error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController)
    {
        dismiss(animated: true, completion: nil)
    }
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
