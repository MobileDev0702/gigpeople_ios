//
//  RequestDetailsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 13/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class RequestDetailsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,TPFloatRatingViewDelegate
{
    @IBOutlet weak var tableObj: UITableView!
    @IBOutlet weak var bannerVw: UIView!
    @IBOutlet var scrollObj: UIScrollView!
    var objImageSliderView:ImageSliderView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableObj.tableFooterView = UIView()
        
        var tableHeight: CGFloat = 0.0
        for i in 0..<3
        {
            tableHeight += tableView(self.tableObj, heightForRowAt: IndexPath(row: i, section: 0))
        }
        self.tableObj.frame = CGRect(x: self.tableObj.frame.origin.x, y: self.tableObj.frame.origin.y, width: self.tableObj.frame.size.width, height: tableHeight)
        self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:tableHeight+self.scrollObj.frame.size.height)
    }
    override func viewWillAppear(_ animated: Bool)
    {
        setupImageSwipeView()
        super.viewWillAppear(true)
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        if((objImageSliderView) != nil)
        {
            objImageSliderView.TimerStop()
        }
        super.viewWillDisappear(true)
    }
    func setupImageSwipeView()
    {
        let arrEmpty = ["banner_one","banner1","banner2","banner3"]
        let nibContents = Bundle.main.loadNibNamed("ImageSliderView", owner: nil, options: nil)
        objImageSliderView = (nibContents!.last! as! ImageSliderView)
        objImageSliderView.frame = bannerVw.bounds
        bannerVw.addSubview(objImageSliderView)
        let swiftArray = NSArray(array: arrEmpty) as? [String]
        self.objImageSliderView.initialize(arrImages: swiftArray!)
        objImageSliderView.TimerStart()
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func editBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewRequestViewController") as? AddNewRequestViewController
        wc?.getPageFrom = "Edit New Request"
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var nib = Bundle.main.loadNibNamed("OffersReceivedTableViewCell", owner: self, options: nil)
        let cell = nib?[0] as? OffersReceivedTableViewCell
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
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OfferDetailsViewController") as? OfferDetailsViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
}
