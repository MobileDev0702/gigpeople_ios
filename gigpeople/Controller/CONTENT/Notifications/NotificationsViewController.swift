//
//  NotificationsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 05/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var tableObj: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableObj.tableFooterView = UIView()
    }
    
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var nib = Bundle.main.loadNibNamed("NotificationsTableViewCell", owner: self, options: nil)
        let cell = nib?[0] as? NotificationsTableViewCell
        cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
        if(indexPath.row % 2 == 0)
        {
            cell?.contentView.backgroundColor = UIColor.white
        }
        else
        {
            cell?.contentView.backgroundColor = UIColor.groupTableViewBackground
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }

}
