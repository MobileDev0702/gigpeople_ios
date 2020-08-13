//
//  EditProfileViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 10/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit
import GooglePlaces
import FCAlertView

class EditProfileViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,GMSAutocompleteViewControllerDelegate,FCAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate
{
    @IBOutlet weak var collectionObj: UICollectionView!
    @IBOutlet var scrollObj: UIScrollView!
    var languageArr = NSMutableArray()
    @IBOutlet weak var languageFld: UITextField!
    @IBOutlet weak var addressFld: UITextField!
    @IBOutlet weak var profileImg: NZCircularImageView!
    
    @IBOutlet weak var descTxt: UITextView!
    @IBOutlet weak var descCountLbl: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if isIphoneX()
        {
            print("X Variant Device")
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+20)
        }
        else
        {
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+200)
        }
        collectionObj.register(UINib(nibName: "LanguageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LanguageCollectionViewCell")
        
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
    @IBAction func updateBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addLanguage(_ sender: Any)
    {
        self.view.endEditing(true)
        languageArr.add(self.languageFld.text as Any)
        self.collectionObj .reloadData()
    }
    @IBAction func addPhotoBtn(_ sender: Any)
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
    func compressImage(_ image: UIImage?) -> UIImage?
    {
        let actualHeight = Float(image?.size.height ?? 0.0)
        let actualWidth = Float(image?.size.width ?? 0.0)
        
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image?.draw(in: rect)
        let img: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        var imageData: Data? = nil
        if let img = img {
            imageData = img.jpegData(compressionQuality: 0.5)
        }
        UIGraphicsEndImageContext()
        if let imageData = imageData {
            return UIImage(data: imageData)
        }
        return nil
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let imgCompressed: UIImage? = compressImage(chosenImage)
        self.profileImg.image = imgCompressed
        self.profileImg.layer.cornerRadius = self.profileImg.frame.size.width / 2
        self.profileImg.clipsToBounds = true
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true)
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return languageArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LanguageCollectionViewCell", for: indexPath as IndexPath) as! LanguageCollectionViewCell
        
        cell.lblObj.text = (languageArr.object(at: indexPath.row) as! String)
        cell.closeBtn.tag = indexPath.row
        cell.closeBtn.addTarget(self, action: #selector(closeClicked), for: .touchUpInside)
        
        return cell
    }
    @IBAction func closeClicked(_ sender: UIButton)
    {
        var strVal = NSString()
        strVal = languageArr.object(at: sender.tag) as! NSString
        languageArr.remove(strVal)
        self.collectionObj .reloadData()
    }
    @IBAction func locationBtn(_ sender: Any)
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
        self.addressFld.text = place.formattedAddress
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
}
