//
//  MySalesCurrentAndCompletedViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 13/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class MySalesCurrentAndCompletedViewController: UIViewController,ADPageControlDelegate,UITableViewDelegate, UITableViewDataSource,TPFloatRatingViewDelegate,UITextViewDelegate
{

    @IBOutlet var workHistoryVw: UIView!
    @IBOutlet weak var workHistoryTable: UITableView!
    
    @IBOutlet var rvwsVw: UIView!
    @IBOutlet weak var rvwsTable: UITableView!
    
    @IBOutlet var scrollObj: UIScrollView!
    
    @IBOutlet weak var historyBtn: UIButton!
    @IBOutlet weak var rvwsBtn: UIButton!
    @IBOutlet weak var rvwsBottomVw: UIView!
    @IBOutlet weak var historyBottomVw: UIView!
    
    var searchpageControl: ADPageControl?
    @IBOutlet weak var rvwsDeliveryBtn: UIButton!
    @IBOutlet weak var workDeliveryBtn: UIButton!
    
    @IBOutlet var contactVw: UIView!
    @IBOutlet weak var contactInVw: UIView!
    @IBOutlet weak var contactTxt: UITextView!
    
    @IBOutlet var feedbackVw: UIView!
    @IBOutlet weak var feedbackInVw: UIView!
    @IBOutlet weak var feedbackTxtVw: UITextView!
    
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

    
    @IBOutlet weak var ocntactAdminImg: UIImageView!
    @IBOutlet weak var contactAdminBtn: UIButton!
    
    
    var getPageFrom:String = ""
    
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
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        contactTxt.text = "Leave a message"
        contactTxt.textColor = UIColor.lightGray
        contactTxt.layer.cornerRadius = 10
        contactTxt.layer.borderColor = UIColor.darkGray.cgColor
        contactTxt.layer.borderWidth = 1
        
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
        
        
        if(getPageFrom == "Current")
        {
            self.workDeliveryBtn.isHidden = false
            self.rvwsDeliveryBtn.isHidden = false
            self.contactAdminBtn.isHidden = false
            self.ocntactAdminImg.isHidden = false
        }
        else
        {
            self.workDeliveryBtn.isHidden = true
            self.rvwsDeliveryBtn.isHidden = true
            self.contactAdminBtn.isHidden = true
            self.ocntactAdminImg.isHidden = true
        }
        
        self.historyBtn.setTitleColor(UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0), for: .normal)
        self.historyBottomVw.isHidden = false
        self.workHistoryVw.isHidden = false
        
        self.rvwsBtn.setTitleColor(UIColor.black, for: .normal)
        self.rvwsVw.isHidden = true
        self.rvwsBottomVw.isHidden = true
        
        self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+self.workHistoryVw.frame.size.height + 230)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == workHistoryTable
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
        if tableView == workHistoryTable
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
    
    @IBAction func workDeliveryBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DeliveryViewController") as? DeliveryViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func rvwsDeliveryNowBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DeliveryViewController") as? DeliveryViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func historyBtn(_ sender: Any)
    {
        self.historyBtn.setTitleColor(UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0), for: .normal)
        self.historyBottomVw.isHidden = false
        self.workHistoryVw.isHidden = false
        
        self.rvwsBtn.setTitleColor(UIColor.black, for: .normal)
        self.rvwsVw.isHidden = true
        self.rvwsBottomVw.isHidden = true
        
       self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+self.workHistoryVw.frame.size.height + 230)
    }
    @IBAction func reviewsBtn(_ sender: Any)
    {
        self.rvwsBtn.setTitleColor(UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0), for: .normal)
        self.rvwsVw.isHidden = false
        self.rvwsBottomVw.isHidden = false
        
        self.historyBtn.setTitleColor(UIColor.black, for: .normal)
        self.workHistoryVw.isHidden = true
        self.historyBottomVw.isHidden = true
        
        self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+self.rvwsVw.frame.size.height + 200)
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
}
