//
//  ActiveGigDetailsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 14/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class ActiveGigDetailsViewController: UIViewController,TPFloatRatingViewDelegate,UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var scrollObj: UIScrollView!
    @IBOutlet weak var tableObj: UITableView!
    @IBOutlet weak var ratingVw: TPFloatRatingView!
    @IBOutlet weak var bannerVw: UIView!
    @IBOutlet weak var rvwsBtn: UIButton!
    
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
        self.scrollObj.addSubview(starRatingView)
        
        let arrEmpty = ["banner_one","banner1","banner2","banner3"]
        let nibContents = Bundle.main.loadNibNamed("ImageSliderView", owner: nil, options: nil)
        var objImageSliderView:ImageSliderView!
        objImageSliderView = (nibContents!.last! as! ImageSliderView)
        objImageSliderView.frame = (self.bannerVw.bounds)
        objImageSliderView.pageControl.isHidden = true
        self.bannerVw.addSubview(objImageSliderView)
        let swiftArray = NSArray(array: arrEmpty) as? [String]
        objImageSliderView.initialize(arrImages: swiftArray!)
        objImageSliderView.TimerStart()
        
        var tableHeight: CGFloat = 0.0
        for i in 0..<2
        {
            tableHeight += tableView(self.tableObj, heightForRowAt: IndexPath(row: i, section: 0))
        }
        self.tableObj.frame = CGRect(x: self.tableObj.frame.origin.x, y: self.tableObj.frame.origin.y, width: self.tableObj.frame.size.width, height: tableHeight)
        
        if isIphoneX()
        {
            print("X Variant Device")
            
             rvwsBtn.frame = CGRect(x: self.rvwsBtn.frame.origin.x, y: self.tableObj.frame.origin.y + tableHeight + 20, width: self.rvwsBtn.frame.size.width, height: self.rvwsBtn.frame.size.height+5)
            
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:tableHeight+self.scrollObj.frame.size.height+140)
        }
        else
        {
            rvwsBtn.frame = CGRect(x: self.rvwsBtn.frame.origin.x, y: self.tableObj.frame.origin.y + tableHeight + 30, width: self.rvwsBtn.frame.size.width, height: self.rvwsBtn.frame.size.height+5)
            
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:tableHeight+self.scrollObj.frame.size.height+150)
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
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
    @IBAction func editBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewGigViewController") as? AddNewGigViewController
        wc?.getPageFrom = "Edit New Gig"
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func moreReviewsBtn(_ sender: Any)
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
    @IBAction func shareBtn(_ sender: Any)
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
        if let controller = controller
        {
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
