//
//  GigDetailsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 08/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit
import ZVProgressHUD

class GigDetailsViewController: UIViewController,TPFloatRatingViewDelegate,UITableViewDelegate, UITableViewDataSource,UITextViewDelegate
{
    @IBOutlet var scrollObj: UIScrollView!
    @IBOutlet weak var sliderVw: UIView!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var ratingVw: TPFloatRatingView!
    @IBOutlet weak var rvwsTableObj: UITableView!
    @IBOutlet weak var frstRvwVw: TPFloatRatingView!
    @IBOutlet weak var rvwsBtn: UIButton!
    
    @IBOutlet var orderDescriptionVw: UIView!
    @IBOutlet weak var descriptionInVw: UIView!
    @IBOutlet weak var descBorderVw: UIView!
   
    @IBOutlet weak var descTxt: UITextView!
    @IBOutlet weak var descCountLbl: UILabel!
    
    var isFavSelected = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        descriptionInVw.layer.cornerRadius = 10
        descriptionInVw.clipsToBounds = true
        descBorderVw.layer.cornerRadius = 5
        descBorderVw.clipsToBounds = true
        descBorderVw.layer.borderColor = UIColor.gray.cgColor
        descBorderVw.layer.borderWidth = 1
        descTxt.text = "Description"
        descTxt.textColor = UIColor.lightGray
        descTxt.delegate = self
        self.descCountLbl.text = "0/200"
        
        let starRatingView = TPFloatRatingView(frame: (self.frstRvwVw.frame))
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
        
        let scndstarRatingView = TPFloatRatingView(frame: (self.ratingVw.frame))
        scndstarRatingView.delegate = self
        scndstarRatingView.emptySelectedImage = UIImage(named: "foregroundStar")
        scndstarRatingView.fullSelectedImage = UIImage(named: "backgroundStar")
        scndstarRatingView.contentMode = UIView.ContentMode.scaleAspectFill
        scndstarRatingView.maxRating = 5
        scndstarRatingView.minRating = 0
        scndstarRatingView.rating = 3.0
        scndstarRatingView.editable = false
        scndstarRatingView.halfRatings = true
        scndstarRatingView.floatRatings = false
        self.scrollObj.addSubview(scndstarRatingView)
        
        let arrEmpty = ["banner_one","banner1","banner2","banner3"]
        let nibContents = Bundle.main.loadNibNamed("ImageSliderView", owner: nil, options: nil)
        var objImageSliderView:ImageSliderView!
        objImageSliderView = (nibContents!.last! as! ImageSliderView)
        objImageSliderView.frame = (self.sliderVw.bounds)
        objImageSliderView.pageControl.isHidden = true
        self.sliderVw.addSubview(objImageSliderView)
        let swiftArray = NSArray(array: arrEmpty) as? [String]
        objImageSliderView.initialize(arrImages: swiftArray!)
        objImageSliderView.TimerStart()
        
        var tableHeight: CGFloat = 0.0
        for i in 0..<2
        {
            tableHeight += tableView(self.rvwsTableObj, heightForRowAt: IndexPath(row: i, section: 0))
        }
        self.rvwsTableObj.frame = CGRect(x: self.rvwsTableObj.frame.origin.x, y: self.rvwsTableObj.frame.origin.y, width: self.rvwsTableObj.frame.size.width, height: tableHeight)
        var sizeOfContent: CGFloat = 0
        var i: Int
        for i in 0..<scrollObj.subviews.count
        {
            let view = scrollObj.subviews[i] as? UIView
            sizeOfContent += CGFloat(view?.frame.size.height ?? 0.0)
        }
        if isIphoneX()
        {
            print("X Variant Device")
            
            rvwsBtn.frame = CGRect(x: self.rvwsBtn.frame.origin.x, y: self.rvwsTableObj.frame.origin.y + self.rvwsTableObj.frame.size.height+40 , width: self.rvwsBtn.frame.size.width, height: self.rvwsBtn.frame.size.height)
            
            scrollObj.contentSize = CGSize(width: scrollObj.frame.size.width, height: CGFloat(sizeOfContent+tableHeight + 320))
        }
        else
        {
            scrollObj.contentSize = CGSize(width: scrollObj.frame.size.width, height: CGFloat(sizeOfContent+tableHeight+200))
        }
        
        
        /*
        var tableHeight: CGFloat = 0.0
        for i in 0..<2
        {
            tableHeight += tableView(self.rvwsTableObj, heightForRowAt: IndexPath(row: i, section: 0))
        }
        self.rvwsTableObj.frame = CGRect(x: self.rvwsTableObj.frame.origin.x, y: self.rvwsTableObj.frame.origin.y, width: self.rvwsTableObj.frame.size.width, height: tableHeight)
        if isIphoneX()
        {
            print("X Variant Device")
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:tableHeight+self.scrollObj.frame.size.height+600)
        }
        else
        {
            rvwsBtn.frame = CGRect(x: self.rvwsBtn.frame.origin.x, y: self.rvwsTableObj.frame.origin.y + self.rvwsTableObj.frame.size.height+10 , width: self.rvwsBtn.frame.size.width, height: self.rvwsBtn.frame.size.height+5)
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:tableHeight+self.scrollObj.frame.size.height+450)
        }
         */
    }
    func updateCharacterCount()
    {
        let summaryCount = self.descTxt.text.count
        self.descCountLbl.text = "\((0) + summaryCount)/200"
    }
    func textViewDidChange(_ textView: UITextView)
    {
        self.updateCharacterCount()
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if(textView == descTxt)
        {
            return textView.text.count +  (text.count - range.length) <= 200
        }
        return false
    }
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if textView.textColor == UIColor.lightGray
        {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if textView.text.isEmpty
        {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let cellDefaultHeight: CGFloat = 100
        let screenDefaultHeight: CGFloat = UIScreen.main.bounds.size.height
        var finalHeight: CGFloat = 0
        finalHeight = cellDefaultHeight / screenDefaultHeight
        finalHeight = finalHeight * UIScreen.main.bounds.size.height
        return finalHeight
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
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cartBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CartItemsViewController") as? CartItemsViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
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
    @IBAction func chatBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func orderNowBtn(_ sender: Any)
    {
        orderDescriptionVw.frame = UIScreen.main.bounds
        view.addSubview(orderDescriptionVw)
    }
    @IBAction func userGigsBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchUserDetailsViewController") as? SearchUserDetailsViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    
    
    @IBAction func addToCartBtn(_ sender: Any)
    {
        ZVProgressHUD.showText("Gig added to cart successfully")
    }
    @IBAction func moreRvwsBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReviewsViewController") as? ReviewsViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func descriptionSubmit(_ sender: Any)
    {
        orderDescriptionVw.removeFromSuperview()
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CartItemsViewController") as? CartItemsViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func descriptionCloseBtn(_ sender: Any)
    {
        orderDescriptionVw.removeFromSuperview()
    }
}
