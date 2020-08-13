//
//  NwBrowseRequestDetailsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 14/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class NwBrowseRequestDetailsViewController: UIViewController,TPFloatRatingViewDelegate
{

    @IBOutlet var scrollObj: UIScrollView!
    @IBOutlet weak var ratingVw: TPFloatRatingView!
    @IBOutlet weak var userDetailVw: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if isIphoneX()
        {
            print("X Variant Device")
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height + 350)
        }
        else
        {
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height + 300)
        }
        
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
    @IBAction func offersBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SendOfferViewController") as? SendOfferViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
}
