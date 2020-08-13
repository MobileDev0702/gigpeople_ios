//
//  MySalesReqAndCancelledViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 13/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class MySalesReqAndCancelledViewController: UIViewController {

    @IBOutlet weak var scrollObj: UIScrollView!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var rejectBtbn: UIButton!
    var getPageFrom:String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if(getPageFrom == "Request")
        {
            self.acceptBtn.isHidden = false
            self.rejectBtbn.isHidden = false
            
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+240)
        }
        else
        {
            self.acceptBtn.isHidden = true
            self.rejectBtbn.isHidden = true
            
            self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+150)
        }
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func acceptBtn(_ sender: Any)
    {
        UserDefaults.standard.set("Yes", forKey: "ORDER_ACCEPT")
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func rejectBtn(_ sender: Any)
    {
        UserDefaults.standard.set("No", forKey: "ORDER_ACCEPT")
        self.navigationController?.popViewController(animated: true)
    }
}
