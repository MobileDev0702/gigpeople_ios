//
//  MyProfileViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 10/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit
import SVPinView

class MyProfileViewController: UIViewController,ADPageControlDelegate, UITableViewDelegate, UITableViewDataSource,TPFloatRatingViewDelegate
{
    @IBOutlet var scrollObj: UIScrollView!
    @IBOutlet weak var reviewsVw: UIView!
    @IBOutlet weak var rvwsTable: UITableView!
    @IBOutlet var rvwsTableVw: UIView!
    
    @IBOutlet var buyerRvwVw: UIView!
    @IBOutlet weak var buyerRvwTable: UITableView!
    
    @IBOutlet var pinView:SVPinView!
    @IBOutlet var otpVw: UIView!
    @IBOutlet weak var otpInVw: UIView!
    @IBOutlet weak var otpLbl: UILabel!
    @IBOutlet weak var rvwsBtn: UIButton!
    
    var searchpageControl: ADPageControl?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true

        self.otpVw.frame = UIScreen.main.bounds
        self.otpInVw.layer.cornerRadius = 10
        self.otpInVw.clipsToBounds = true
        
        if isIphoneX()
        {
            print("X Variant Device")
            self.reviewsVw.frame = CGRect(x: self.reviewsVw.frame.origin.x, y:self.reviewsVw.frame.origin.y, width: self.reviewsVw.frame.size.width, height: 250)
            rvwsBtn.frame = CGRect(x: self.rvwsBtn.frame.origin.x, y: self.reviewsVw.frame.origin.y + 260, width: self.rvwsBtn.frame.size.width, height: self.rvwsBtn.frame.size.height+5)
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+320)
        }
        else
        {
            self.reviewsVw.frame = CGRect(x: self.reviewsVw.frame.origin.x, y:self.reviewsVw.frame.origin.y, width: self.reviewsVw.frame.size.width, height: 250)
            rvwsBtn.frame = CGRect(x: self.rvwsBtn.frame.origin.x, y: self.reviewsVw.frame.origin.y + 260, width: self.rvwsBtn.frame.size.width, height: self.rvwsBtn.frame.size.height+5)
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+350)
        }
        
        //page 1
        let pageModel1 = ADPageModel()
        pageModel1.strPageTitle = "As a Buyer"
        pageModel1.iPageNumber = 0
        pageModel1.bShouldLazyLoad = true
        
        //page 2
        let pageModel2 = ADPageModel()
        pageModel2.strPageTitle = "As a Seller"
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
        searchpageControl!.fontTitleTabText = UIFont(name: "Geomanist-Book", size: 16)
        searchpageControl!.bEnablePagesEndBounceEffect = true
        searchpageControl!.bEnableTitlesEndBounceEffect = true
        searchpageControl!.colorTabText = UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0)
        searchpageControl!.colorTitleBarBackground = UIColor.white
        searchpageControl!.colorPageIndicator = UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0)
        searchpageControl!.bShowMoreTabAvailableIndicator = false
        searchpageControl!.view.frame = self.reviewsVw.frame
        self.scrollObj.addSubview(searchpageControl!.view)
    }
    func adPageControlGetViewController(for pageModel: ADPageModel?) -> UIViewController?
    {
        if pageModel!.iPageNumber == 0
        {
            let page1 = UIViewController()
            rvwsTableVw.frame = UIScreen.main.bounds
            page1.view.addSubview(self.rvwsTableVw)
            return page1
        }
        else
        {
            let page1 = UIViewController()
            buyerRvwVw.frame = UIScreen.main.bounds
            page1.view.addSubview(self.buyerRvwVw)
            return page1
        }
    }
    @IBAction func resendBtn(_ sender: Any)
    {
        self.otpVw.removeFromSuperview()
    }
    @IBAction func submitPinBtn(_ sender: Any)
    {
        self.otpVw.removeFromSuperview()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var nib = Bundle.main.loadNibNamed("ReviewsTableViewCell", owner: self, options: nil)
        let cell = nib?[0] as? ReviewsTableViewCell
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    @IBAction func menuBtn(_ sender: Any)
    {
        sideMenuController?.showLeftView(animated: true, completionHandler: nil)
    }
    @IBAction func editProfileBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func emailVerifyBtn(_ sender: Any)
    {
        self.view .addSubview(self.otpVw)
        otpLbl.text = "peter@gmail.com"
        pinView.becomeFirstResponderAtIndex = 0
        pinView.pinLength = 4
        pinView.borderLineThickness = 1
        pinView.activeBorderLineThickness = 2
        pinView.font = UIFont(name: "Geomanist-Book", size: 20)!
        pinView.keyboardType = .phonePad
    }
    @IBAction func phoneVerifyBtn(_ sender: Any)
    {
        self.view .addSubview(self.otpVw)
        otpLbl.text = "+1 4564 765 878"
        pinView.becomeFirstResponderAtIndex = 0
        pinView.pinLength = 4
        pinView.borderLineThickness = 1
        pinView.activeBorderLineThickness = 2
        pinView.font = UIFont(name: "Geomanist-Book", size: 20)!
        pinView.keyboardType = .phonePad
    }
    @IBAction func moreRvwsBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReviewsViewController") as? ReviewsViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func otpCloseBtn(_ sender: Any)
    {
        otpVw.removeFromSuperview()
    }
}
