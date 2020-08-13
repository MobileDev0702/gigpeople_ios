//
//  AddNewGigViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 14/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit
import FCAlertView
import FTPopOverMenu
import ZVProgressHUD


class AddNewGigViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,FCAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,DateTimePickerDelegate
{
    @IBOutlet var scrollObj: UIScrollView!
    @IBOutlet weak var categoryFld: UILabel!
    @IBOutlet weak var subCategoryFld: UILabel!
    @IBOutlet weak var imageCollectionObj: UICollectionView!
    @IBOutlet weak var shippingPriceVw: UIView!
    @IBOutlet weak var belowShippingVw: UIView!
    @IBOutlet weak var tagsCollectionObj: UICollectionView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var tagsFld: UITextField!
    @IBOutlet weak var revisionsFld: UITextField!
    
    @IBOutlet weak var draftBtn: UIButton!
    @IBOutlet weak var uodateBtn: UIButton!
    @IBOutlet weak var publishBtn: UIButton!

    @IBOutlet weak var descTxt: UITextView!
    @IBOutlet weak var countTxt: UILabel!
    @IBOutlet weak var timeFld: UILabel!
    
    @IBOutlet var buttonRadioOutLet: [UIButton]!
    
    var getPageFrom:String = ""
    var imgArr = NSMutableArray()
    var languageArr = NSMutableArray()

    @IBAction func timeBtn(_ sender: Any)
    {
        let min = Date()
        let max = Date().addingTimeInterval(60 * 60 * 24 * 10000)
        let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        
        picker.is12HourFormat = true
        picker.isDatePickerOnly = false
        picker.includeMonth = true
        picker.highlightColor = UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0)
        picker.darkColor = UIColor.darkGray
        picker.doneButtonTitle = "DONE"
        picker.dateFormat = "dd MMM YYYY hh:mm"
        picker.doneBackgroundColor = UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0)
        picker.completionHandler = { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM YYYY hh:mm a"
            self.title = formatter.string(from: date)
        }
        picker.delegate = self
        picker.show()
    }
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date)
    {
        self.timeFld.text = picker.selectedDateString
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()

        imageCollectionObj.register(UINib(nibName: "AddReqImgCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddReqImgCollectionViewCell")
        imgArr.add("Add")
        
        tagsCollectionObj.register(UINib(nibName: "LanguageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LanguageCollectionViewCell")
        
        self.headerLbl.text = getPageFrom
        if getPageFrom == "Add New Gig"
        {
            self.uodateBtn.isHidden = true
            self.draftBtn.isHidden = false
            self.publishBtn.isHidden = false
        }
        else
        {
            self.uodateBtn.isHidden = false
            self.draftBtn.isHidden = true
            self.publishBtn.isHidden = true
        }
        
        self.shippingPriceVw.isHidden = true
        self.belowShippingVw.frame = CGRect(x: self.belowShippingVw.frame.origin.x, y: self.shippingPriceVw.frame.origin.y, width: self.shippingPriceVw.frame.size.width, height: self.belowShippingVw.frame.size.height)
        
        self.uodateBtn.frame = CGRect(x: self.uodateBtn.frame.origin.x, y: self.belowShippingVw.frame.origin.y+self.belowShippingVw.frame.size.height, width: self.uodateBtn.frame.size.width, height: self.uodateBtn.frame.size.height)
        self.draftBtn.frame = CGRect(x: self.draftBtn.frame.origin.x, y: self.belowShippingVw.frame.origin.y+self.belowShippingVw.frame.size.height, width: self.draftBtn.frame.size.width, height: self.draftBtn.frame.size.height)
        self.publishBtn.frame = CGRect(x: self.publishBtn.frame.origin.x, y: self.belowShippingVw.frame.origin.y+self.belowShippingVw.frame.size.height, width: self.publishBtn.frame.size.width, height: self.publishBtn.frame.size.height)
        
        if isIphoneX()
        {
            print("X Variant Device")
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+180)
        }
        else
        {
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+150)
        }
        
        descTxt.text = "Description"
        descTxt.textColor = UIColor.lightGray
        descTxt.delegate = self
        self.countTxt.text = "0/200"
    }
    func updateCharacterCount()
    {
        let summaryCount = self.descTxt.text.count
        self.countTxt.text = "\((0) + summaryCount)/200"
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
    @IBAction func buttonRadio(_ sender: UIButton)
    {
        self.view.endEditing(true)
        buttonRadioOutLet.forEach
            { (button) in
                button.isSelected = false
        }
        sender.isSelected = true
        print(sender.currentTitle ?? "Duc")
        if sender.currentTitle == "Yes"
        {
            self.shippingPriceVw.isHidden = false
            self.belowShippingVw.frame = CGRect(x: self.belowShippingVw.frame.origin.x, y: self.shippingPriceVw.frame.origin.y + self.shippingPriceVw.frame.size.height, width: self.shippingPriceVw.frame.size.width, height: self.belowShippingVw.frame.size.height)
            
            self.uodateBtn.frame = CGRect(x: self.uodateBtn.frame.origin.x, y: self.belowShippingVw.frame.origin.y+self.belowShippingVw.frame.size.height, width: self.uodateBtn.frame.size.width, height: self.uodateBtn.frame.size.height)
            self.draftBtn.frame = CGRect(x: self.draftBtn.frame.origin.x, y: self.belowShippingVw.frame.origin.y+self.belowShippingVw.frame.size.height, width: self.draftBtn.frame.size.width, height: self.draftBtn.frame.size.height)
            self.publishBtn.frame = CGRect(x: self.publishBtn.frame.origin.x, y: self.belowShippingVw.frame.origin.y+self.belowShippingVw.frame.size.height, width: self.publishBtn.frame.size.width, height: self.publishBtn.frame.size.height)
            
            if isIphoneX()
            {
                print("X Variant Device")
                self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+230)
            }
            else
            {
                self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+230)
            }
        }
        else
        {
            self.shippingPriceVw.isHidden = true
            self.belowShippingVw.frame = CGRect(x: self.belowShippingVw.frame.origin.x, y: self.shippingPriceVw.frame.origin.y, width: self.shippingPriceVw.frame.size.width, height: self.belowShippingVw.frame.size.height)
        }
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func categoryBtn(_ sender: Any)
    {
        self.view.endEditing(true)
        var arrayVal = ["Graphics", "Digital Marketing", "Writing Translation","Video Animation"]
        
        let configuration = FTPopOverMenuConfiguration.default()
        configuration?.allowRoundedArrow = !(configuration?.allowRoundedArrow)!
        configuration?.backgroundColor = UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0)
        configuration?.separatorColor = UIColor.white
        configuration?.textColor = UIColor.white
        configuration?.textFont = UIFont(name: "Geomanist-Book", size: 10)
        configuration?.textAlignment = NSTextAlignment.center
        
        FTPopOverMenu.show(forSender: self.categoryFld, withMenuArray: arrayVal, imageArray: nil, configuration: configuration, doneBlock: { selectedIndex in
            self.categoryFld.text = "\(arrayVal[selectedIndex])"
        }) {
            print("user canceled. do nothing.")
        }
    }
    @IBAction func subCateBtn(_ sender: Any)
    {
        self.view.endEditing(true)
        var arrayVal = ["SEO", "Social Media Marketing", "Web Traffic","Email Marketing","Local Listings","Domain Research", "Web Analytics"]
        
        let configuration = FTPopOverMenuConfiguration.default()
        configuration?.allowRoundedArrow = !(configuration?.allowRoundedArrow)!
        configuration?.backgroundColor = UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0)
        configuration?.separatorColor = UIColor.white
        configuration?.textColor = UIColor.white
        configuration?.textFont = UIFont(name: "Geomanist-Book", size: 10)
        configuration?.textAlignment = NSTextAlignment.center
        
        FTPopOverMenu.show(forSender: self.subCategoryFld, withMenuArray: arrayVal, imageArray: nil, configuration: configuration, doneBlock: { selectedIndex in
            self.subCategoryFld.text = "\(arrayVal[selectedIndex])"
        }) {
            print("user canceled. do nothing.")
        }
    }
    @IBAction func addTagsBtn(_ sender: Any)
    {
        if self.tagsFld.text?.count == 0
        {
            ZVProgressHUD.showError(with: "Enter Tag Name", in: self.view, delay: 0.0)
        }
        else
        {
            self.view.endEditing(true)
            languageArr.add(self.tagsFld.text as Any)
            self.tagsCollectionObj .reloadData()
            self.tagsFld.text = ""
        }
    }
    @IBAction func draftBtn(_ sender: Any)
    {
        self.view.endEditing(true)
        UserDefaults.standard.set("DRAFT", forKey: "NEW_GIG")
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func publishBtn(_ sender: Any)
    {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == self.imageCollectionObj
        {
            return imgArr.count
        }
        else
        {
            return languageArr.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == self.imageCollectionObj
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddReqImgCollectionViewCell", for: indexPath as IndexPath) as! AddReqImgCollectionViewCell
            cell.layer.cornerRadius =  5
            cell.clipsToBounds = true
            
            if indexPath.row == 0
            {
                cell.imgObj.image = UIImage.init(named: "add_image_2")
                cell.clearBtn.isHidden = true
            }
            else
            {
                cell.contentView.backgroundColor = UIColor.clear
                cell.clearBtn.isHidden = false
                cell.imgObj.image = (imgArr.object(at: indexPath.row) as! UIImage)
                cell.clearBtn.tag = indexPath.row
                cell.clearBtn.addTarget(self, action: #selector(clearClicked), for: .touchUpInside)
            }
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LanguageCollectionViewCell", for: indexPath as IndexPath) as! LanguageCollectionViewCell
            
            cell.lblObj.text = (languageArr.object(at: indexPath.row) as! String)
            cell.closeBtn.tag = indexPath.row
            cell.closeBtn.addTarget(self, action: #selector(closeClicked), for: .touchUpInside)
            
            return cell
        }
    }
    @IBAction func clearClicked(_ sender: UIButton)
    {
        imgArr.removeObject(at: sender.tag)
        self.imageCollectionObj.reloadData()
    }
    @IBAction func closeClicked(_ sender: UIButton)
    {
        var strVal = NSString()
        strVal = languageArr.object(at: sender.tag) as! NSString
        languageArr.remove(strVal)
        self.tagsCollectionObj .reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.row == 0
        {
            let _ = AlertViewBuilder() { (builder) in
                
                let imageView = UIImageView.init(image: UIImage.init(named: "confirm")?.withAlignmentRectInsets(UIEdgeInsets.init(top: 20, left: 5, bottom: 0, right: 5)))
                imageView.contentMode = .scaleAspectFit
                
                builder.addView(with: AlertSubMessageView.init(messageText: "Add Media File Using"), tag: 0, height: 40)
                builder.addButton(with: "Select Photo", backgroundColor: .white, titleColor: .black, font: UIFont(name: "Geomanist", size: 16)!, height: 40, action:
                {
                    let customerpickerObj = UIImagePickerController()
                    customerpickerObj.delegate = self
                    customerpickerObj.sourceType = .photoLibrary
                    customerpickerObj.allowsEditing = true
                    self.present(customerpickerObj, animated: true)
                })
                builder.addButton(with: "Take Photo", backgroundColor: .white, titleColor: .black, font: UIFont(name: "Geomanist", size: 16)!, height: 40, action:
                {
                    let customerpickerObj = UIImagePickerController()
                    customerpickerObj.delegate = self
                    customerpickerObj.sourceType = .camera
                    customerpickerObj.allowsEditing = true
                    self.present(customerpickerObj, animated: true)
                })
                builder.addButton(with: "Select Video", backgroundColor: .white, titleColor: .black, font: UIFont(name: "Geomanist", size: 16)!, height: 40, action:
                {
                    let customerpickerObj = UIImagePickerController()
                    customerpickerObj.delegate = self
                    customerpickerObj.sourceType = .photoLibrary
                    customerpickerObj.allowsEditing = true
                    customerpickerObj.mediaTypes = ["public.movie"]
                    self.present(customerpickerObj, animated: true)
                })
                builder.addButton(with: "Take Video", backgroundColor: .white, titleColor: .black, font: UIFont(name: "Geomanist", size: 16)!, height: 40, action:
                {
                    let customerpickerObj = UIImagePickerController()
                    customerpickerObj.delegate = self
                    customerpickerObj.sourceType = .camera
                    customerpickerObj.allowsEditing = true
                    customerpickerObj.mediaTypes = ["public.movie"]
                    self.present(customerpickerObj, animated: true)
                })
                builder.addButton(with: "Cancel", backgroundColor: UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0), titleColor: .white, font: UIFont(name: "Geomanist", size: 16)!, height: 40, action: {
                    print("Button 3 clicked")
                })
                }.build()
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String
        if (mediaType == "public.movie")
        {
           // let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            let imgObj = UIImage.init(named: "video_player")
            imgArr.add(imgObj as Any)
        }
        else
        {
            let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            imgArr.add(chosenImage as Any)
        }
        self.imageCollectionObj.reloadData()
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true)
    }
    
    @IBAction func revisionsBtn(_ sender: Any)
    {
        self.view.endEditing(true)
        var arrayVal = ["1", "2", "3","4","5"]
        let configuration = FTPopOverMenuConfiguration.default()
        configuration?.allowRoundedArrow = !(configuration?.allowRoundedArrow)!
        configuration?.backgroundColor = UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0)
        configuration?.separatorColor = UIColor.white
        configuration?.textColor = UIColor.white
        configuration?.textFont = UIFont(name: "Geomanist-Book", size: 10)
        configuration?.textAlignment = NSTextAlignment.center
        
        FTPopOverMenu.show(forSender: self.revisionsFld, withMenuArray: arrayVal, imageArray: nil, configuration: configuration, doneBlock: { selectedIndex in
            self.revisionsFld.text = "\(arrayVal[selectedIndex])"
        }) {
            print("user canceled. do nothing.")
        }
    }
    @IBAction func updateBtn(_ sender: Any)
    {
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyGigsViewController") as? MyGigsViewController
        var naviVC: UINavigationController? = nil
        if let homeVC = homeVC
        {
            naviVC = UINavigationController(rootViewController: homeVC)
        }
        sideMenuController!.rootViewController = naviVC
        sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
    }
}
