//
//  OfferRequestDetailsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 14/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class OfferRequestDetailsViewController: UIViewController,TPFloatRatingViewDelegate
{

    @IBOutlet var scrollObj: UIScrollView!
    @IBOutlet weak var ratingVw: TPFloatRatingView!
    @IBOutlet weak var userDetailVw: UIView!
    @IBOutlet weak var updateBtn: UIButton!
    var getPageFrom: String = ""
    @IBOutlet weak var statusLbl: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        
        
        
        
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
        self.userDetailVw.addSubview(starRatingView)
        
        if getPageFrom == "0"
        {
            updateBtn.isHidden = false
            
            if isIphoneX()
            {
                print("X Variant Device")
                self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height + 800)
            }
            else
            {
                self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height + 650)
            }
        }
        else if getPageFrom == "1"
        {
            updateBtn.isHidden = true
            self.statusLbl.text = "Accepted"
            self.statusLbl.backgroundColor = UIColor(red:0.00, green:0.62, blue:0.00, alpha:1.0)
            
            if isIphoneX()
            {
                print("X Variant Device")
                self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height + 700)
            }
            else
            {
                self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height + 600)
            }
        }
        else if getPageFrom == "2"
        {
            updateBtn.isHidden = true
            self.statusLbl.text = "Rejected"
            self.statusLbl.backgroundColor = UIColor.red
            
            if isIphoneX()
            {
                print("X Variant Device")
                self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height + 700)
            }
            else
            {
                self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height + 600)
            }
        }
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func moreRvws(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReviewsViewController") as? ReviewsViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func updateBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SendOfferViewController") as? SendOfferViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
}
