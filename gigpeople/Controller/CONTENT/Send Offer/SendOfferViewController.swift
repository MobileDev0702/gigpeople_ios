//
//  SendOfferViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 14/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit


class SendOfferViewController: UIViewController,UITextViewDelegate,DateTimePickerDelegate
{
    @IBOutlet weak var descTxt: UITextView!
    @IBOutlet weak var countTxt: UILabel!
    @IBOutlet weak var timeFld: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func submitBtn(_ sender: Any)
    {
        UserDefaults.standard.set("Yes", forKey: "OFFER_ACCEPT")
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BrowseRequestsViewController") as? BrowseRequestsViewController
        var naviVC: UINavigationController? = nil
        if let homeVC = homeVC
        {
            naviVC = UINavigationController(rootViewController: homeVC)
        }
        sideMenuController!.rootViewController = naviVC
        sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
    }
}
