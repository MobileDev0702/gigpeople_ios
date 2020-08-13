//
//  OfferDetailsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 13/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class OfferDetailsViewController: UIViewController,TPFloatRatingViewDelegate {

    @IBOutlet var scrollObj: UIScrollView!
    @IBOutlet weak var ratingVw: TPFloatRatingView!

    @IBOutlet weak var paymentInVw: UIView!
    @IBOutlet var paymentVw: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        paymentInVw.layer.cornerRadius = 10
        paymentInVw.clipsToBounds = true
        
        let starRatingView = TPFloatRatingView(frame: (self.ratingVw.frame))
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
        self.scrollObj.addSubview(starRatingView)
        
        if isIphoneX()
        {
            print("X Variant Device")
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+180)
        }
        else
        {
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+180)
        }
        
        
        paymentInVw.layer.cornerRadius = 10
        paymentInVw.clipsToBounds = true
    }
    @IBAction func paypalBtn(_ sender: Any)
    {
        paymentVw.removeFromSuperview()
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyOrdersViewController") as? MyOrdersViewController
        var naviVC: UINavigationController? = nil
        if let homeVC = homeVC
        {
            naviVC = UINavigationController(rootViewController: homeVC)
        }
        sideMenuController!.rootViewController = naviVC
        sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
    }
    @IBAction func weChatBtn(_ sender: Any)
    {
        paymentVw.removeFromSuperview()
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyOrdersViewController") as? MyOrdersViewController
        var naviVC: UINavigationController? = nil
        if let homeVC = homeVC
        {
            naviVC = UINavigationController(rootViewController: homeVC)
        }
        sideMenuController!.rootViewController = naviVC
        sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
    }
    @IBAction func creditCardBtn(_ sender: Any)
    {
        paymentVw.removeFromSuperview()
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyOrdersViewController") as? MyOrdersViewController
        var naviVC: UINavigationController? = nil
        if let homeVC = homeVC
        {
            naviVC = UINavigationController(rootViewController: homeVC)
        }
        sideMenuController!.rootViewController = naviVC
        sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
    }
    @IBAction func paymentCloseBtn(_ sender: Any)
    {
        paymentVw.removeFromSuperview()
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func acceptBtn(_ sender: Any)
    {
        paymentVw.frame = UIScreen.main.bounds
        view.addSubview(paymentVw)
    }
    @IBAction func rejectBtn(_ sender: Any)
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
    @IBAction func chatBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func profileBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchUserDetailsViewController") as? SearchUserDetailsViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    
}
