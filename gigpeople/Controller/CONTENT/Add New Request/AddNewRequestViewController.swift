//
//  AddNewRequestViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 13/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit
import FCAlertView
import FTPopOverMenu


class AddNewRequestViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,FCAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,DateTimePickerDelegate
{
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var subCateLbl: UILabel!
    @IBOutlet weak var collectionObj: UICollectionView!
    @IBOutlet weak var headerLbl: UILabel!
    
    @IBOutlet weak var descTxt: UITextView!
    @IBOutlet weak var descCountLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    var getPageFrom:String = ""
    var imgArr = NSMutableArray()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionObj.register(UINib(nibName: "AddReqImgCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddReqImgCollectionViewCell")
        imgArr.add("Add")
        
        self.headerLbl.text = getPageFrom
        
        descTxt.text = "Description"
        descTxt.textColor = UIColor.lightGray
        descTxt.delegate = self
        self.descCountLbl.text = "0/200"
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
            formatter.dateFormat = "dd MMM YYYY hh:mm"
            self.title = formatter.string(from: date)
        }
        picker.delegate = self
        picker.show()
    }
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date)
    {
        self.timeLbl.text = picker.selectedDateString
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func submitBtn(_ sender: Any)
    {
        self.view.endEditing(true)
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyOrdersViewController") as? MyOrdersViewController
        var naviVC: UINavigationController? = nil
        if let homeVC = homeVC
        {
            naviVC = UINavigationController(rootViewController: homeVC)
        }
        sideMenuController!.rootViewController = naviVC
        sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
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
        
        FTPopOverMenu.show(forSender: self.subCateLbl, withMenuArray: arrayVal, imageArray: nil, configuration: configuration, doneBlock: { selectedIndex in
            self.subCateLbl.text = "\(arrayVal[selectedIndex])"
        }) {
            print("user canceled. do nothing.")
        }
    }
    @IBAction func cateBtn(_ sender: Any)
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
        
        FTPopOverMenu.show(forSender: self.categoryLbl, withMenuArray: arrayVal, imageArray: nil, configuration: configuration, doneBlock: { selectedIndex in
            self.categoryLbl.text = "\(arrayVal[selectedIndex])"
        }) {
            print("user canceled. do nothing.")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return imgArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
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
    @IBAction func clearClicked(_ sender: UIButton)
    {
        imgArr.removeObject(at: sender.tag)
        self.collectionObj.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.view.endEditing(true)
        if indexPath.row == 0
        {
            let arrayOfButtonTitles = ["Gallery", "Take Photo"]
            let cusAlert = FCAlertView()
            cusAlert.delegate = self
            cusAlert.showAlert(inView: self, withTitle: "", withSubtitle: "Add Photo", withCustomImage: nil, withDoneButtonTitle: "Cancel", andButtons: arrayOfButtonTitles)
            cusAlert.subtitleFont = UIFont(name: "Geomanist", size: 18)
            cusAlert.subTitleColor = UIColor.white
            cusAlert.doneButtonTitleColor = UIColor.white
            cusAlert.colorScheme = UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0)
            cusAlert.alertBackgroundColor = UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0)
            cusAlert.firstButtonCustomFont = UIFont(name: "Geomanist", size: 16)
            cusAlert.secondButtonCustomFont = UIFont(name: "Geomanist", size: 16)
            cusAlert.firstButtonTitleColor = UIColor.black
            cusAlert.secondButtonTitleColor = UIColor.black
        }
    }
    func fcAlertView(_ alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String)
    {
        if title == "Gallery"
        {
            let customerpickerObj = UIImagePickerController()
            customerpickerObj.delegate = self
            customerpickerObj.sourceType = .photoLibrary
            customerpickerObj.allowsEditing = true
            present(customerpickerObj, animated: true)
        }
        else if title == "Take Photo"
        {
            let customerpickerObj = UIImagePickerController()
            customerpickerObj.delegate = self
            customerpickerObj.sourceType = .camera
            customerpickerObj.allowsEditing = true
            present(customerpickerObj, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imgArr.add(chosenImage as Any)
        self.collectionObj.reloadData()
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true)
    }
}
