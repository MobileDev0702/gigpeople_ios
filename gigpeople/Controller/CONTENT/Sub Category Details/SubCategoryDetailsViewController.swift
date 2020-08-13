//
//  SubCategoryDetailsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 10/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit
import SelectionList
import TTRangeSlider
import FTPopOverMenu
import GooglePlaces

class SubCategoryDetailsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,TPFloatRatingViewDelegate,TTRangeSliderDelegate,GMSAutocompleteViewControllerDelegate
{
    @IBOutlet var filterscrolObj: UIScrollView!
    @IBOutlet var filterVw: UIView!
    @IBOutlet var filterInVw: UIView!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var subCategoryLbl: UILabel!
    @IBOutlet weak var deliveryTimeList: SelectionList!
    
    @IBOutlet weak var languageEnglishImg: UIImageView!
    @IBOutlet weak var languageChineseImg: UIImageView!
    @IBOutlet weak var languageArabicImg: UIImageView!
    @IBOutlet weak var frontEndImg: UIImageView!
    @IBOutlet weak var angularImg: UIImageView!
    @IBOutlet weak var reactImg: UIImageView!
    
    @IBOutlet weak var languageEnglishBtn: UIButton!
    @IBOutlet weak var languageChineseBtn: UIButton!
    @IBOutlet weak var languageArabicBtn: UIButton!
    @IBOutlet weak var frontEndBtn: UIButton!
    @IBOutlet weak var angularBtn: UIButton!
    @IBOutlet weak var reactBtn: UIButton!
    @IBOutlet weak var rangeSlider: TTRangeSlider!
    
    @IBOutlet weak var tableObj: UITableView!
    @IBOutlet weak var headerLbl: UILabel!
    var getPageFrom:String = ""
    
    var isEnglishSelected = false
    var isArabicSelected = false
    var isChineseSelected = false
    var isFrontendSelected = false
    var isAngularSelected = false
    var isReactSelected = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        filterInVw.layer.cornerRadius = 10
        filterInVw.clipsToBounds = true
        
        self.headerLbl.text = getPageFrom
        self.tableObj.tableFooterView = UIView()
        
        var sizeOfContent: CGFloat = 0
        var i: Int
        for i in 0..<filterscrolObj.subviews.count
        {
            let view = filterscrolObj.subviews[i] as? UIView
            sizeOfContent += CGFloat(view?.frame.size.height ?? 0.0)
        }
        if isIphoneX()
        {
            print("X Variant Device")
            filterscrolObj.contentSize = CGSize(width: filterscrolObj.frame.size.width, height: CGFloat(sizeOfContent-540))
        }
        else
        {
            filterscrolObj.contentSize = CGSize(width: filterscrolObj.frame.size.width, height: CGFloat(sizeOfContent-650))
        }
        
        /*
        if isIphoneX()
        {
            print("X Variant Device")
            self.filterscrolObj.contentSize = CGSize(width: self.filterscrolObj.frame.size.width, height:self.filterscrolObj.frame.size.height+300)
        }
        else
        {
            self.filterscrolObj.contentSize = CGSize(width: self.filterscrolObj.frame.size.width, height:self.filterscrolObj.frame.size.height+50)
        }
        */
        rangeSlider.delegate = self
        rangeSlider.minLabelFont = UIFont(name: "Geomanist", size: 12.0)
        rangeSlider.maxLabelFont = UIFont(name: "Geomanist", size: 12.0)
        rangeSlider.maxLabelColour = UIColor.black
        rangeSlider.minLabelColour = UIColor.black
        rangeSlider.minValue = 10
        rangeSlider.maxValue = 1000
        rangeSlider.selectedMinimum = 10
        rangeSlider.selectedMaximum = 1000
        rangeSlider.handleImage = UIImage(named: "sliderThumb")
        rangeSlider.handleDiameter = 28.0
        rangeSlider.selectedHandleDiameterMultiplier = 1
        rangeSlider.tintColorBetweenHandles = UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0)
        rangeSlider.tintColor = UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0)
        rangeSlider.lineBorderWidth = 40
        rangeSlider.lineBorderColor = UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        rangeSlider.numberFormatterOverride = formatter
        
        deliveryTimeList.items = ["Upto 24 hours", "Upto 3 days", "Upto 7 days","Any"]
        deliveryTimeList.tableView.separatorStyle = .none
        deliveryTimeList.setupCell =  { (cell: UITableViewCell, index: Int) in
            cell.textLabel?.font = UIFont(name: "Geomanist", size: 14)
            cell.textLabel?.textColor = UIColor.black
        }
        deliveryTimeList.addTarget(self, action: #selector(selectionChanged), for: .valueChanged)
    }
    @objc func selectionChanged()
    {
        print(deliveryTimeList.selectedIndexes)
    }
    @IBAction func fronEndBtn(_ sender: Any)
    {
        if isFrontendSelected
        {
            isFrontendSelected = false
            self.frontEndImg.image = UIImage.init(named: "languageNotSelected")
            self.frontEndBtn .setTitleColor(UIColor.darkGray, for: .normal)
        }
        else
        {
            isFrontendSelected = true
            self.frontEndImg.image = UIImage.init(named: "languageSelected")
            self.frontEndBtn .setTitleColor(UIColor.white, for: .normal)
        }
    }
    @IBAction func angularBtn(_ sender: Any)
    {
        if isAngularSelected
        {
            isAngularSelected = false
            self.angularImg.image = UIImage.init(named: "languageNotSelected")
            self.angularBtn .setTitleColor(UIColor.darkGray, for: .normal)
        }
        else
        {
            isAngularSelected = true
            self.angularImg.image = UIImage.init(named: "languageSelected")
            self.angularBtn .setTitleColor(UIColor.white, for: .normal)
        }
    }
    @IBAction func reactBtn(_ sender: Any)
    {
        if isReactSelected
        {
            isReactSelected = false
            self.reactImg.image = UIImage.init(named: "languageNotSelected")
            self.reactBtn .setTitleColor(UIColor.darkGray, for: .normal)
        }
        else
        {
            isReactSelected = true
            self.reactImg.image = UIImage.init(named: "languageSelected")
            self.reactBtn .setTitleColor(UIColor.white, for: .normal)
        }
    }
    @IBAction func chineseBtn(_ sender: Any)
    {
        if isChineseSelected
        {
            isChineseSelected = false
            self.languageChineseImg.image = UIImage.init(named: "languageNotSelected")
            self.languageChineseBtn .setTitleColor(UIColor.darkGray, for: .normal)
        }
        else
        {
            isChineseSelected = true
            self.languageChineseImg.image = UIImage.init(named: "languageSelected")
            self.languageChineseBtn .setTitleColor(UIColor.white, for: .normal)
        }
    }
    @IBAction func englishBtn(_ sender: Any)
    {
        if isEnglishSelected
        {
            isEnglishSelected = false
            self.languageEnglishImg.image = UIImage.init(named: "languageNotSelected")
            self.languageEnglishBtn .setTitleColor(UIColor.darkGray, for: .normal)
        }
        else
        {
            isEnglishSelected = true
            self.languageEnglishImg.image = UIImage.init(named: "languageSelected")
            self.languageEnglishBtn .setTitleColor(UIColor.white, for: .normal)
        }
    }
    @IBAction func arabicBtn(_ sender: Any)
    {
        if isArabicSelected
        {
            isArabicSelected = false
            self.languageArabicImg.image = UIImage.init(named: "languageNotSelected")
            self.languageArabicBtn .setTitleColor(UIColor.darkGray, for: .normal)
        }
        else
        {
            isArabicSelected = true
            self.languageArabicImg.image = UIImage.init(named: "languageSelected")
            self.languageArabicBtn .setTitleColor(UIColor.white, for: .normal)
        }
    }
    @IBAction func filterLocationClearBtn(_ sender: Any)
    {
        self.locationLbl.text = "Seller Location"
    }
    @IBAction func filterLocationBtn(_ sender: Any)
    {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        UINavigationBar.appearance().barTintColor = UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        if #available(iOS 9.0, *)
        {
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        else
        {
            print("Check")
        }
        present(autocompleteController, animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace)
    {
        self.locationLbl.text = place.formattedAddress
        dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error)
    {
        print("Error: ", error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController)
    {
        dismiss(animated: true, completion: nil)
    }
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    @IBAction func categoryBtn(_ sender: Any)
    {
        var arrayVal = ["Graphics", "Digital Marketing", "Writing Translation","Video Animation"]
        
        let configuration = FTPopOverMenuConfiguration.default()
        configuration?.allowRoundedArrow = !(configuration?.allowRoundedArrow)!
        configuration?.backgroundColor = UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0)
        configuration?.separatorColor = UIColor.white
        configuration?.textColor = UIColor.white
        configuration?.textFont = UIFont(name: "Geomanist-Book", size: 10)
        configuration?.textAlignment = NSTextAlignment.center
        
        FTPopOverMenu.show(forSender: self.categoryLbl, withMenuArray: arrayVal, imageArray: nil, configuration: configuration, doneBlock: { selectedIndex in
            self.categoryLbl.text = "\(arrayVal[selectedIndex])"
        }) {
            print("user canceled. do nothing.")
        }
    }
    @IBAction func subCategoryBtn(_ sender: Any)
    {
        var arrayVal = ["SEO", "Social Media Marketing", "Web Traffic","Email Marketing","Local Listings","Domain Research", "Web Analytics"]
        
        let configuration = FTPopOverMenuConfiguration.default()
        configuration?.allowRoundedArrow = !(configuration?.allowRoundedArrow)!
        configuration?.backgroundColor = UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0)
        configuration?.separatorColor = UIColor.white
        configuration?.textColor = UIColor.white
        configuration?.textFont = UIFont(name: "Geomanist-Book", size: 10)
        configuration?.textAlignment = NSTextAlignment.center
        
        FTPopOverMenu.show(forSender: self.subCategoryLbl, withMenuArray: arrayVal, imageArray: nil, configuration: configuration, doneBlock: { selectedIndex in
            self.subCategoryLbl.text = "\(arrayVal[selectedIndex])"
        }) {
            print("user canceled. do nothing.")
        }
    }
    
    @IBAction func filterCloseBtn(_ sender: Any)
    {
        filterVw.removeFromSuperview()
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func filterBtn(_ sender: Any)
    {
        filterVw.frame = UIScreen.main.bounds
        view.addSubview(filterVw)
    }
    @IBAction func searchBtn(_ sender: Any)
    {
        filterVw.removeFromSuperview()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var nib = Bundle.main.loadNibNamed("SubCategoryDetailsTableViewCell", owner: self, options: nil)
        let cell = nib?[0] as? SubCategoryDetailsTableViewCell
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
        
        cell?.favBtn.tag = indexPath.row
        cell?.favBtn.addTarget(self, action: #selector(favClicked), for: .touchUpInside)
        
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
    @IBAction func favClicked(_ sender: UIButton)
    {
        let myIndexPath = NSIndexPath(row: sender.tag, section: 0)
        let cell = self.tableObj.cellForRow(at: myIndexPath as IndexPath) as? SubCategoryDetailsTableViewCell
        
        if (cell?.favBtn.currentImage?.isEqual(UIImage(named: "fav_line")))!
        {
            cell?.favBtn.setImage(UIImage.init(named: "fav_icon"), for: .normal)
        }
        else
        {
            cell?.favBtn.setImage(UIImage.init(named: "fav_line"), for: .normal)
        }
    }
}

