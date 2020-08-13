//
//  ContactUsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 13/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit
import FTPopOverMenu

class ContactUsViewController: UIViewController {

    @IBOutlet weak var txtVw: UITextView!
    @IBOutlet weak var selectLbl: UILabel!
    
    
    override func viewDidLoad()
    {
        self.txtVw.layer.cornerRadius = 10
        self.txtVw.layer.borderColor = UIColor.lightGray.cgColor
        self.txtVw.layer.borderWidth = 1
        super.viewDidLoad()
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func selectBtn(_ sender: Any)
    {
        var arrayVal = ["Home", "Gig Requests", "My Gigs","My Sales","Manage Requests","My Orders","Favourites","Settings","Chat","Withdrawal","Analytics","Others"]
        
        let configuration = FTPopOverMenuConfiguration.default()
        configuration?.allowRoundedArrow = !(configuration?.allowRoundedArrow)!
        configuration?.backgroundColor = UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0)
        configuration?.separatorColor = UIColor.white
        configuration?.textColor = UIColor.white
        configuration?.textFont = UIFont(name: "Geomanist-Book", size: 10)
        configuration?.textAlignment = NSTextAlignment.center
        
        FTPopOverMenu.show(forSender: self.selectLbl, withMenuArray: arrayVal, imageArray: nil, configuration: configuration, doneBlock: { selectedIndex in
            self.selectLbl.text = "\(arrayVal[selectedIndex])"
        }) {
            print("user canceled. do nothing.")
        }
    }
    @IBAction func submitBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}
