//
//  MyOrderActiveDetailsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 15/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit
import ZVProgressHUD

class MyOrderActiveDetailsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,TPFloatRatingViewDelegate,UITextViewDelegate
{
    @IBOutlet var scrollObj: UIScrollView!
    @IBOutlet weak var bannerVw: UIView!
    @IBOutlet weak var ratingVw: TPFloatRatingView!
    @IBOutlet weak var tableObj: UITableView!
    @IBOutlet weak var workHistoryVw: UIView!
    @IBOutlet weak var ratingOuterVw: UIView!
    
    var objImageSliderView:ImageSliderView!
    
    @IBOutlet var contactVw: UIView!
    @IBOutlet weak var contactInVw: UIView!
    @IBOutlet weak var contactTxt: UITextView!
    
    @IBOutlet var feedbackVw: UIView!
    @IBOutlet weak var feedbackInVw: UIView!
    @IBOutlet weak var feedbackTxtVw: UITextView!
    
    @IBOutlet var gigfeedbackVw: UIView!
    @IBOutlet weak var gigfeedbackInVw: UIView!
    @IBOutlet weak var gigfeedbackTxtVw: UITextView!
    
    @IBOutlet var msgVw: UIView!
    @IBOutlet weak var msgInVw: UIView!
    @IBOutlet weak var msgTxtVw: UITextView!
    
    @IBOutlet var revisionVw: UIView!
    @IBOutlet weak var revisionInVw: UIView!
    @IBOutlet weak var revisonTxtVw: UITextView!
    
    @IBOutlet var cancelVw: UIView!
    @IBOutlet weak var cancelInVw: UIView!
    @IBOutlet weak var cancelInTxt: UITextView!
    
    @IBOutlet var disputeVw: UIView!
    @IBOutlet weak var disputeInVw: UIView!
    @IBOutlet weak var disputeTxtVw: UITextView!
    
    
    @IBOutlet weak var fiveStar: UIButton!
    @IBOutlet weak var fourStar: UIButton!
    @IBOutlet weak var threeStar: UIButton!
    @IBOutlet weak var twoStar: UIButton!
    @IBOutlet weak var oneStar: UIButton!
    
    @IBOutlet weak var gigfiveStar: UIButton!
    @IBOutlet weak var gigfourStar: UIButton!
    @IBOutlet weak var gigthreeStar: UIButton!
    @IBOutlet weak var gigtwoStar: UIButton!
    @IBOutlet weak var gigoneStar: UIButton!
    
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
        if textView == contactTxt
        {
            if textView.text.isEmpty
            {
                textView.text = "Leave a message"
                textView.textColor = UIColor.lightGray
            }
        }
        else if textView == feedbackTxtVw
        {
            if textView.text.isEmpty
            {
                textView.text = "Type your Feedback..."
                textView.textColor = UIColor.lightGray
            }
        }
        else if textView == msgTxtVw
        {
            if textView.text.isEmpty
            {
                textView.text = "Reply"
                textView.textColor = UIColor.lightGray
            }
        }
        else if textView == revisonTxtVw
        {
            if textView.text.isEmpty
            {
                textView.text = "Type your text here..."
                textView.textColor = UIColor.lightGray
            }
        }
        else if textView == cancelInTxt
        {
            if textView.text.isEmpty
            {
                textView.text = "Type your text here..."
                textView.textColor = UIColor.lightGray
            }
        }
        else if textView == disputeTxtVw
        {
            if textView.text.isEmpty
            {
                textView.text = "Enter Comments"
                textView.textColor = UIColor.lightGray
            }
        }
        else if textView == gigfeedbackTxtVw
        {
            if textView.text.isEmpty
            {
                textView.text = "Type your feedback..."
                textView.textColor = UIColor.lightGray
            }
        }
    }
    
    override func viewDidLoad()
    {
        contactTxt.text = "Leave a message"
        contactTxt.textColor = UIColor.lightGray
        contactTxt.layer.cornerRadius = 10
        contactTxt.layer.borderColor = UIColor.darkGray.cgColor
        contactTxt.layer.borderWidth = 1
        
        gigfeedbackTxtVw.text = "Type your Feedback..."
        gigfeedbackTxtVw.textColor = UIColor.lightGray
        gigfeedbackTxtVw.layer.cornerRadius = 10
        gigfeedbackTxtVw.layer.borderColor = UIColor.darkGray.cgColor
        gigfeedbackTxtVw.layer.borderWidth = 1
        
        feedbackTxtVw.text = "Type your Feedback..."
        feedbackTxtVw.textColor = UIColor.lightGray
        feedbackTxtVw.layer.cornerRadius = 10
        feedbackTxtVw.layer.borderColor = UIColor.darkGray.cgColor
        feedbackTxtVw.layer.borderWidth = 1
        
        msgTxtVw.text = "Reply"
        msgTxtVw.textColor = UIColor.lightGray
        msgTxtVw.layer.cornerRadius = 10
        msgTxtVw.layer.borderColor = UIColor.darkGray.cgColor
        msgTxtVw.layer.borderWidth = 1
        
        revisonTxtVw.text = "Type your text here..."
        revisonTxtVw.textColor = UIColor.lightGray
        revisonTxtVw.layer.cornerRadius = 10
        revisonTxtVw.layer.borderColor = UIColor.darkGray.cgColor
        revisonTxtVw.layer.borderWidth = 1
        
        cancelInTxt.text = "Type your text here..."
        cancelInTxt.textColor = UIColor.lightGray
        cancelInTxt.layer.cornerRadius = 10
        cancelInTxt.layer.borderColor = UIColor.darkGray.cgColor
        cancelInTxt.layer.borderWidth = 1
        
        disputeTxtVw.text = "Enter Comments"
        disputeTxtVw.textColor = UIColor.lightGray
        disputeTxtVw.layer.cornerRadius = 10
        disputeTxtVw.layer.borderColor = UIColor.darkGray.cgColor
        disputeTxtVw.layer.borderWidth = 1
        
        super.viewDidLoad()
        self.tableObj.tableFooterView = UIView()
        self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+self.workHistoryVw.frame.size.height + 350)
        
    
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
        self.ratingOuterVw.addSubview(starRatingView)
    }
    @IBAction func gigFeedbackBtn(_ sender: Any)
    {
        gigfeedbackVw.frame = UIScreen.main.bounds
        view.addSubview(gigfeedbackVw)
    }
    @IBAction func userFeedbackBtn(_ sender: Any)
    {
        feedbackVw.frame = UIScreen.main.bounds
        view.addSubview(feedbackVw)
    }
    @IBAction func msgBtn(_ sender: Any)
    {
        msgVw.frame = UIScreen.main.bounds
        view.addSubview(msgVw)
    }
    @IBAction func revisionBtn(_ sender: Any)
    {
        revisionVw.frame = UIScreen.main.bounds
        view.addSubview(revisionVw)
    }
    @IBAction func cancelBtn(_ sender: Any)
    {
        cancelVw.frame = UIScreen.main.bounds
        view.addSubview(cancelVw)
    }
    @IBAction func disputeBtn(_ sender: Any)
    {
        disputeVw.frame = UIScreen.main.bounds
        view.addSubview(disputeVw)
    }
    @IBAction func contactAdminBtn(_ sender: Any)
    {
        contactVw.frame = UIScreen.main.bounds
        view.addSubview(contactVw)
    }
    @IBAction func disputeCloseBtn(_ sender: Any)
    {
        disputeVw.removeFromSuperview()
    }
    @IBAction func disputeSubmitBtn(_ sender: Any)
    {
        disputeVw.removeFromSuperview()
    }
    
    @IBAction func cancellationCloseBtn(_ sender: Any)
    {
        cancelVw.removeFromSuperview()
    }
    @IBAction func cancellationSubmitBtn(_ sender: Any)
    {
        cancelVw.removeFromSuperview()
    }
    
    @IBAction func revisionCloseBtn(_ sender: Any)
    {
        revisionVw.removeFromSuperview()
    }
    @IBAction func revisionSubmitBtn(_ sender: Any)
    {
        revisionVw.removeFromSuperview()
    }
    
    @IBAction func msgCloseBtn(_ sender: Any)
    {
        msgVw.removeFromSuperview()
    }
    @IBAction func msgSubmitBtn(_ sender: Any)
    {
        msgVw.removeFromSuperview()
    }
    
    @IBAction func feedbackCloseBtn(_ sender: Any)
    {
        feedbackVw.removeFromSuperview()
    }
    @IBAction func feedbackSubmitBtn(_ sender: Any)
    {
        feedbackVw.removeFromSuperview()
    }
    
    @IBAction func gigfeedbackCloseBtn(_ sender: Any)
    {
         gigfeedbackVw.removeFromSuperview()
    }
    @IBAction func  gigfeedbackSubmitBtn(_ sender: Any)
    {
         gigfeedbackVw.removeFromSuperview()
    }
    
    @IBAction func contactCloseBtn(_ sender: Any)
    {
        contactVw.removeFromSuperview()
    }
    @IBAction func contactSubmitBtn(_ sender: Any)
    {
        contactVw.removeFromSuperview()
    }
    @IBAction func oneStar(_ sender: Any)
    {
        self.oneStar.setImage(UIImage.init(named: "one_star"), for: .normal)
        self.twoStar.setImage(UIImage.init(named: "gray_2star"), for: .normal)
        self.threeStar.setImage(UIImage.init(named: "gray_3star"), for: .normal)
        self.fourStar.setImage(UIImage.init(named: "gray_4star"), for: .normal)
        self.fiveStar.setImage(UIImage.init(named: "gray_5star"), for: .normal)
    }
    @IBAction func twoStar(_ sender: Any)
    {
        self.oneStar.setImage(UIImage.init(named: "gray_1star"), for: .normal)
        self.twoStar.setImage(UIImage.init(named: "two_star"), for: .normal)
        self.threeStar.setImage(UIImage.init(named: "gray_3star"), for: .normal)
        self.fourStar.setImage(UIImage.init(named: "gray_4star"), for: .normal)
        self.fiveStar.setImage(UIImage.init(named: "gray_5star"), for: .normal)
    }
    @IBAction func threeStar(_ sender: Any)
    {
        self.oneStar.setImage(UIImage.init(named: "gray_1star"), for: .normal)
        self.twoStar.setImage(UIImage.init(named: "gray_2star"), for: .normal)
        self.threeStar.setImage(UIImage.init(named: "three_star"), for: .normal)
        self.fourStar.setImage(UIImage.init(named: "gray_4star"), for: .normal)
        self.fiveStar.setImage(UIImage.init(named: "gray_5star"), for: .normal)
    }
    @IBAction func fourStar(_ sender: Any)
    {
        self.oneStar.setImage(UIImage.init(named: "gray_1star"), for: .normal)
        self.twoStar.setImage(UIImage.init(named: "gray_2star"), for: .normal)
        self.threeStar.setImage(UIImage.init(named: "gray_3star"), for: .normal)
        self.fourStar.setImage(UIImage.init(named: "four_star"), for: .normal)
        self.fiveStar.setImage(UIImage.init(named: "gray_5star"), for: .normal)
    }
    @IBAction func fiveStar(_ sender: Any)
    {
        self.oneStar.setImage(UIImage.init(named: "gray_1star"), for: .normal)
        self.twoStar.setImage(UIImage.init(named: "gray_2star"), for: .normal)
        self.threeStar.setImage(UIImage.init(named: "gray_3star"), for: .normal)
        self.fourStar.setImage(UIImage.init(named: "gray_4star"), for: .normal)
        self.fiveStar.setImage(UIImage.init(named: "five_star"), for: .normal)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == 1 || indexPath.row == 3
        {
            return 200
        }
        else
        {
            return 100
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 1
        {
            var nib = Bundle.main.loadNibNamed("MyOrdersActiveTableViewCell", owner: self, options: nil)
            let cell = nib?[0] as? MyOrdersActiveTableViewCell
            cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
            cell?.deliveryVw.isHidden = false
            cell?.revisionVw.isHidden = true
            return cell!
        }
        if indexPath.row == 3
        {
            var nib = Bundle.main.loadNibNamed("MyOrdersActiveTableViewCell", owner: self, options: nil)
            let cell = nib?[0] as? MyOrdersActiveTableViewCell
            cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
            cell?.revisionVw.isHidden = false
            cell?.deliveryVw.isHidden = true
            return cell!
        }
        else
        {
            var nib = Bundle.main.loadNibNamed("MySalesWorkHistoryTableViewCell", owner: self, options: nil)
            let cell = nib?[0] as? MySalesWorkHistoryTableViewCell
            cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
            return cell!
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
    @IBAction func acceptBtn(_ sender: Any)
    {
        ZVProgressHUD.showText("Your revision was accepted successfully")
    }
    @IBAction func declineBtn(_ sender: Any)
    {
        ZVProgressHUD.showText("Your revision was declined successfully")
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
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
}
