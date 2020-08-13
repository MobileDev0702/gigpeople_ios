//
//  SearchUserDetailsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 07/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class SearchUserDetailsViewController: UIViewController,TPFloatRatingViewDelegate,UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var scrollObj: UIScrollView!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var ratingVw: TPFloatRatingView!
    @IBOutlet weak var rvwsTable: UITableView!
    
    var isFavSelected = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.rvwsTable.tableFooterView = UIView()
        
        let starRatingView = TPFloatRatingView(frame: ratingVw.frame)
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

        var tableHeight: CGFloat = 0.0
        for i in 0..<3
        {
            tableHeight += tableView(self.rvwsTable, heightForRowAt: IndexPath(row: i, section: 0))
        }
        self.rvwsTable.frame = CGRect(x: self.rvwsTable.frame.origin.x, y: self.rvwsTable.frame.origin.y, width: self.rvwsTable.frame.size.width, height: tableHeight)
        
        var sizeOfContent: CGFloat = 0
        var i: Int
        for i in 0..<scrollObj.subviews.count
        {
            let view = scrollObj.subviews[i] as? UIView
            sizeOfContent += CGFloat(view?.frame.size.height ?? 0.0)
        }
        scrollObj.contentSize = CGSize(width: scrollObj.frame.size.width, height: CGFloat(sizeOfContent+tableHeight)-280)
    }
    @IBAction func favBtn(_ sender: Any)
    {
        if isFavSelected
        {
            isFavSelected = false
            self.favBtn.setImage(UIImage.init(named: "fav_line"), for: .normal)
        }
        else
        {
            isFavSelected = true
            self.favBtn.setImage(UIImage.init(named: "fav_icon"), for: .normal)
        }
    }
    @IBAction func allRvwsBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReviewsViewController") as? ReviewsViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func chatBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 184
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var nib = Bundle.main.loadNibNamed("UserDetailsGigsTableViewCell", owner: self, options: nil)
        let cell = nib?[0] as? UserDetailsGigsTableViewCell
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
        
        let arrEmpty = ["banner_one","banner1","banner2","banner3"]
        let nibContents = Bundle.main.loadNibNamed("ImageSliderView", owner: nil, options: nil)
        var objImageSliderView:ImageSliderView!
        objImageSliderView = (nibContents!.last! as! ImageSliderView)
        objImageSliderView.frame = (cell?.sliderVw.bounds)!
        objImageSliderView.isUserInteractionEnabled = false
        objImageSliderView.pageControl.isHidden = true
        cell?.sliderVw.addSubview(objImageSliderView)
        let swiftArray = NSArray(array: arrEmpty) as? [String]
        objImageSliderView.initialize(arrImages: swiftArray!)
        objImageSliderView.TimerStart()
        
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
}
