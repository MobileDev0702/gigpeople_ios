//
//  DeliveryViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 14/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit
import FCAlertView

class DeliveryViewController: UIViewController,UITextViewDelegate,FCAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    @IBOutlet weak var txtVw: UITextView!
    
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
    override func viewDidLoad()
    {
        txtVw.text = "Description"
        txtVw.textColor = UIColor.lightGray
        super.viewDidLoad()
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func attachmentBtn(_ sender: Any)
    {
        let arrayOfButtonTitles = ["Select Photo", "Take Photo"]
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true)
    }
    func fcAlertView(_ alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String)
    {
        if title == "Select Photo"
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
        else if title == "Select Video"
        {
            let customerpickerObj = UIImagePickerController()
            customerpickerObj.delegate = self
            customerpickerObj.sourceType = .camera
            customerpickerObj.mediaTypes = ["public.image", "public.movie"]
            customerpickerObj.videoQuality = .typeMedium
            present(customerpickerObj, animated: true)
        }
        else if title == "Take Video"
        {
            let customerpickerObj = UIImagePickerController()
            customerpickerObj.delegate = self
            customerpickerObj.sourceType = .camera
            customerpickerObj.mediaTypes = ["public.image", "public.movie"]
            customerpickerObj.videoQuality = .typeMedium
            present(customerpickerObj, animated: true)
        }
    }
    @IBAction func submitBtn(_ sender: Any)
    {
        UserDefaults.standard.set("Completed", forKey: "ORDER_ACCEPT")
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MySalesViewController") as? MySalesViewController
        var naviVC: UINavigationController? = nil
        if let homeVC = homeVC
        {
            naviVC = UINavigationController(rootViewController: homeVC)
        }
        sideMenuController!.rootViewController = naviVC
        sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
    }
}
