//
//  MyOrdersDeliveredDetailsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 15/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit
import FCAlertView

class MyOrdersDeliveredDetailsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,TPFloatRatingViewDelegate,UITextViewDelegate,FCAlertViewDelegate
{
    @IBOutlet var scrollObj: UIScrollView!
    @IBOutlet weak var bannerVw: UIView!
    @IBOutlet weak var ratingTopVw: UIView!
    @IBOutlet weak var ratingVw: TPFloatRatingView!
    @IBOutlet weak var historyVw: UIView!
    @IBOutlet weak var rvwsV: UIView!
    @IBOutlet weak var historyFullVw: UIView!
    @IBOutlet weak var rvwsFullVw: UIView!
    @IBOutlet weak var historyTbl: UITableView!
    @IBOutlet weak var rvwsTbl: UITableView!
    @IBOutlet weak var histryBtn: UIButton!
    @IBOutlet weak var rvwBtn: UIButton!
    
    @IBOutlet var gigfeedbackVw: UIView!
    @IBOutlet weak var gigfeedbackInVw: UIView!
    @IBOutlet weak var gigfeedbackTxtVw: UITextView!
    
    @IBOutlet weak var gigfiveStar: UIButton!
    @IBOutlet weak var gigfourStar: UIButton!
    @IBOutlet weak var gigthreeStar: UIButton!
    @IBOutlet weak var gigtwoStar: UIButton!
    @IBOutlet weak var gigoneStar: UIButton!
    
    @IBOutlet weak var rvwsDeliveryBtn: UIButton!
    @IBOutlet weak var historyDeliveryBtn: UIButton!
    
    
    var getPageFrom:String = ""
    var objImageSliderView:ImageSliderView!
    
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
        if textView == gigfeedbackTxtVw
        {
            if textView.text.isEmpty
            {
                textView.text = "Type your Feedback..."
                textView.textColor = UIColor.lightGray
            }
        }
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
    override func viewDidLoad()
    {
        super.viewDidLoad()

        if getPageFrom == "Payment" || getPageFrom == "Cancelled"
        {
            self.rvwsDeliveryBtn.isHidden = true
            self.historyDeliveryBtn.isHidden = true
        }
        
        gigfeedbackTxtVw.text = "Type your Feedback..."
        gigfeedbackTxtVw.textColor = UIColor.lightGray
        gigfeedbackTxtVw.layer.cornerRadius = 10
        gigfeedbackTxtVw.layer.borderColor = UIColor.darkGray.cgColor
        gigfeedbackTxtVw.layer.borderWidth = 1
        
        self.histryBtn.setTitleColor(UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0), for: .normal)
        self.historyVw.isHidden = false
        self.historyFullVw.isHidden = false
        
        self.rvwBtn.setTitleColor(UIColor.black, for: .normal)
        self.rvwsV.isHidden = true
        self.rvwsFullVw.isHidden = true
        
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
        self.ratingTopVw.addSubview(starRatingView)
        
        if isIphoneX()
        {
            print("X Variant Device")
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+self.historyFullVw.frame.size.height + 350)
        }
        else
        {
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+self.historyFullVw.frame.size.height + 300)
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == historyTbl
        {
            return 4
        }
        else
        {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == historyTbl
        {
            var nib = Bundle.main.loadNibNamed("MySalesWorkHistoryTableViewCell", owner: self, options: nil)
            let cell = nib?[0] as? MySalesWorkHistoryTableViewCell
            cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
            
            return cell!
        }
        else
        {
            var nib = Bundle.main.loadNibNamed("MySalesReviewsTableViewCell", owner: self, options: nil)
            let cell = nib?[0] as? MySalesReviewsTableViewCell
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
    }
    @IBAction func shareBtn(_ sender: Any)
    {
        let theMessage = "gigpeople App Invite"
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
    @IBAction func chatBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func historyBtn(_ sender: Any)
    {
        self.histryBtn.setTitleColor(UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0), for: .normal)
        self.historyVw.isHidden = false
        self.historyFullVw.isHidden = false
        
        self.rvwBtn.setTitleColor(UIColor.black, for: .normal)
        self.rvwsV.isHidden = true
        self.rvwsFullVw.isHidden = true
        
        if isIphoneX()
        {
            print("X Variant Device")
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+self.historyFullVw.frame.size.height + 350)
        }
        else
        {
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+self.historyFullVw.frame.size.height + 300)
        }
    }
    @IBAction func rvwsBtn(_ sender: Any)
    {
        self.rvwBtn.setTitleColor(UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0), for: .normal)
        self.rvwsV.isHidden = false
        self.rvwsFullVw.isHidden = false
        
        self.histryBtn.setTitleColor(UIColor.black, for: .normal)
        self.historyVw.isHidden = true
        self.historyFullVw.isHidden = true
        
        if isIphoneX()
        {
            print("X Variant Device")
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+self.rvwsFullVw.frame.size.height + 350)
        }
        else
        {
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+self.rvwsFullVw.frame.size.height + 300)
        }
        
        
    }
    @IBAction func historySatisfiedBtn(_ sender: Any)
    {
        let arrayOfButtonTitles = ["Yes", "No"]
        let cusAlert = FCAlertView()
        cusAlert.delegate = self
        cusAlert.showAlert(inView: self, withTitle: "", withSubtitle: "Delivery Satisfied?", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: arrayOfButtonTitles)
        cusAlert.hideDoneButton = true
        cusAlert.titleFont = UIFont(name: "Geomanist", size: 20)
        cusAlert.titleColor = UIColor.black
        cusAlert.subtitleFont = UIFont(name: "Geomanist", size: 18)
        cusAlert.subTitleColor = UIColor.black
        cusAlert.firstButtonBackgroundColor = UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0)
        cusAlert.secondButtonBackgroundColor = UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0)
        cusAlert.firstButtonCustomFont = UIFont(name: "Geomanist", size: 16)
        cusAlert.secondButtonCustomFont = UIFont(name: "Geomanist", size: 16)
        cusAlert.firstButtonTitleColor = UIColor.white
        cusAlert.secondButtonTitleColor = UIColor.white
    }
    @IBAction func rvwsSatisfiedBtn(_ sender: Any)
    {
        let arrayOfButtonTitles = ["Yes", "No"]
        let cusAlert = FCAlertView()
        cusAlert.delegate = self
        cusAlert.showAlert(inView: self, withTitle: "", withSubtitle: "Delivery Satisfied?", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: arrayOfButtonTitles)
        cusAlert.hideDoneButton = true
        cusAlert.titleFont = UIFont(name: "Geomanist", size: 20)
        cusAlert.titleColor = UIColor.black
        cusAlert.subtitleFont = UIFont(name: "Geomanist", size: 18)
        cusAlert.subTitleColor = UIColor.black
        cusAlert.firstButtonBackgroundColor = UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0)
        cusAlert.secondButtonBackgroundColor = UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0)
        cusAlert.firstButtonCustomFont = UIFont(name: "Geomanist", size: 16)
        cusAlert.secondButtonCustomFont = UIFont(name: "Geomanist", size: 16)
        cusAlert.firstButtonTitleColor = UIColor.white
        cusAlert.secondButtonTitleColor = UIColor.white
    }
    func fcAlertView(_ alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String)
    {
        if title == "Yes"
        {
            gigfeedbackVw.frame = UIScreen.main.bounds
            view.addSubview(gigfeedbackVw)
        }
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func gigfeedbackCloseBtn(_ sender: Any)
    {
        gigfeedbackVw.removeFromSuperview()
    }
    @IBAction func  gigfeedbackSubmitBtn(_ sender: Any)
    {
        gigfeedbackVw.removeFromSuperview()
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyOrdersViewController") as? MyOrdersViewController
        var naviVC: UINavigationController? = nil
        if let homeVC = homeVC
        {
            naviVC = UINavigationController(rootViewController: homeVC)
        }
        sideMenuController!.rootViewController = naviVC
        sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
    }
    @IBAction func gigoneStar(_ sender: Any)
    {
        self.gigoneStar.setImage(UIImage.init(named: "one_star"), for: .normal)
        self.gigtwoStar.setImage(UIImage.init(named: "gray_2star"), for: .normal)
        self.gigthreeStar.setImage(UIImage.init(named: "gray_3star"), for: .normal)
        self.gigfourStar.setImage(UIImage.init(named: "gray_4star"), for: .normal)
        self.gigfiveStar.setImage(UIImage.init(named: "gray_5star"), for: .normal)
    }
    @IBAction func gigtwoStar(_ sender: Any)
    {
        self.gigoneStar.setImage(UIImage.init(named: "gray_1star"), for: .normal)
        self.gigtwoStar.setImage(UIImage.init(named: "two_star"), for: .normal)
        self.gigthreeStar.setImage(UIImage.init(named: "gray_3star"), for: .normal)
        self.gigfourStar.setImage(UIImage.init(named: "gray_4star"), for: .normal)
        self.gigfiveStar.setImage(UIImage.init(named: "gray_5star"), for: .normal)
    }
    @IBAction func gigthreeStar(_ sender: Any)
    {
        self.gigoneStar.setImage(UIImage.init(named: "gray_1star"), for: .normal)
        self.gigtwoStar.setImage(UIImage.init(named: "gray_2star"), for: .normal)
        self.gigthreeStar.setImage(UIImage.init(named: "three_star"), for: .normal)
        self.gigfourStar.setImage(UIImage.init(named: "gray_4star"), for: .normal)
        self.gigfiveStar.setImage(UIImage.init(named: "gray_5star"), for: .normal)
    }
    @IBAction func gigfourStar(_ sender: Any)
    {
        self.gigoneStar.setImage(UIImage.init(named: "gray_1star"), for: .normal)
        self.gigtwoStar.setImage(UIImage.init(named: "gray_2star"), for: .normal)
        self.gigthreeStar.setImage(UIImage.init(named: "gray_3star"), for: .normal)
        self.gigfourStar.setImage(UIImage.init(named: "four_star"), for: .normal)
        self.gigfiveStar.setImage(UIImage.init(named: "gray_5star"), for: .normal)
    }
    @IBAction func gigfiveStar(_ sender: Any)
    {
        self.gigoneStar.setImage(UIImage.init(named: "gray_1star"), for: .normal)
        self.gigtwoStar.setImage(UIImage.init(named: "gray_2star"), for: .normal)
        self.gigthreeStar.setImage(UIImage.init(named: "gray_3star"), for: .normal)
        self.gigfourStar.setImage(UIImage.init(named: "gray_4star"), for: .normal)
        self.gigfiveStar.setImage(UIImage.init(named: "five_star"), for: .normal)
    }
}
