//
//  HelpSupportViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 13/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit


class HelpSupportViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {

    var menuName = NSArray()
    var menu2Name = NSArray()
    var menu3Name = NSArray()
    
    
    @IBOutlet weak var tableObj: UITableView!
    @IBOutlet var footerVw: UIView!
    
    @IBOutlet var SearchTxt: UITextField!
    @IBOutlet weak var searchTable: UITableView!
    var search:String=""
    
    var menuAll = NSMutableArray()
    var menuSearched = NSMutableArray()

    override func viewDidLoad()
    {
        menuName = ["How do I reset my password?","How to change my profile picture?","Cancel payment that I've already sent?","What are the fees for accounts?","How do I receive payments?"]
        
        menu2Name = ["How to select graphic design category?","How do I submit a gig?","How can I view reviews?"]
        
        menu3Name = ["How to select a best provider?","How to withdraw wallet amount?","How to view status of my gig?"]
        
        menuAll.addObjects(from: menuName as! [Any])
        menuAll.addObjects(from: menu2Name as! [Any])
        menuAll.addObjects(from: menu3Name as! [Any])
        menuSearched = menuAll
        
        self.tableObj.tableFooterView = UIView()
        self.searchTable.tableFooterView = UIView()
        
        super.viewDidLoad()
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func searchBtn(_ sender: Any)
    {
        self.SearchTxt.resignFirstResponder()
        if SearchTxt.text?.count == 0
        {
            search = String(search.dropLast())
        }
        else
        {
            search = SearchTxt.text!
        }
        
        let predicate = NSPredicate(format: "SELF contains[c] %@", search)
        let arr=(menuAll as NSArray).filtered(using: predicate)
        if arr.count > 0
        {
            menuSearched.removeAllObjects()
            menuSearched.addObjects(from: arr)
        }
        else
        {
            menuSearched = menuAll
        }
        print(menuSearched)
        if menuSearched.count != 0
        {
            self.searchTable.isHidden = false
            self.searchTable.reloadData()
        }
    }
    @IBAction func contactBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContactUsViewController") as? ContactUsViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if string.isEmpty
        {
            search = String(search.dropLast())
        }
        else
        {
            search = textField.text!+string
        }
    
        let predicate = NSPredicate(format: "SELF contains[c] %@", search)
        let arr=(menuAll as NSArray).filtered(using: predicate)
        if arr.count > 0
        {
            menuSearched.removeAllObjects()
            menuSearched.addObjects(from: arr)
        }
        else
        {
            menuSearched = menuAll
        }
        print(menuSearched)
        if menuSearched.count != 0
        {
            self.searchTable.isHidden = false
            self.searchTable.reloadData()
        }
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if tableView == self.tableObj
        {
            return 3
        }
        else
        {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if tableView == self.tableObj
        {
            return 30
        }
        else
        {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        if tableView == self.tableObj
        {
            let headerLabel = UILabel(frame: CGRect(x: 20, y: 10, width: 200, height: 30))
            headerLabel.font = UIFont(name: "Geomanist-Book", size: 16)
            headerLabel.textColor = UIColor(red:0.99, green:0.49, blue:0.00, alpha:1.0)
            if section == 0
            {
                headerLabel.text = "Category 1"
            }
            else if section == 1
            {
                headerLabel.text = "Category 2"
            }
            else
            {
                headerLabel.text = "Category 3"
            }
            headerLabel.sizeToFit()
            headerView.addSubview(headerLabel)
            return headerView
        }
        else
        {
            return headerView
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if tableView == self.tableObj
        {
            if section == 2
            {
                return 40
            }
            else
            {
                return 10
            }
        }
        else
        {
           return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        if tableView == self.tableObj
        {
            if section == 2
            {
                return footerVw
            }
            else
            {
                return headerView
            }
        }
        else
        {
            return headerView
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == self.tableObj
        {
            if section == 0
            {
                return self.menuName.count
            }
            else if section == 1
            {
                return self.menu2Name.count
            }
            else
            {
                return self.menu3Name.count
            }
        }
        else
        {
            return menuSearched.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var nib = Bundle.main.loadNibNamed("HelpTableViewCell", owner: self, options: nil)
        let cell = nib?[0] as? HelpTableViewCell
        cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
    
        if tableView == self.tableObj
        {
            cell?.contentView.backgroundColor = UIColor.white
            if indexPath.section == 0
            {
                cell?.lblObj.text = menuName.object(at: indexPath.row) as? String
            }
            else if indexPath.section == 1
            {
                cell?.lblObj.text = menu2Name.object(at: indexPath.row) as? String
            }
            else if indexPath.section == 2
            {
                cell?.lblObj.text = menu3Name.object(at: indexPath.row) as? String
            }
        }
        else
        {
            cell?.contentView.backgroundColor = UIColor.groupTableViewBackground
            cell?.lblObj.text = menuSearched.object(at: indexPath.row) as? String
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.searchTable.isHidden = true
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HelpDetailsViewController") as? HelpDetailsViewController
        if tableView == self.tableObj
        {
            if indexPath.section == 0
            {
                wc?.getPageFrom = (menuName.object(at: indexPath.row) as? String)!
            }
            else if indexPath.section == 1
            {
                wc?.getPageFrom = (menu2Name.object(at: indexPath.row) as? String)!
            }
            else if indexPath.section == 2
            {
                wc?.getPageFrom = (menu3Name.object(at: indexPath.row) as? String)!
            }
        }
        else
        {
            wc?.getPageFrom = (menuSearched.object(at: indexPath.row) as? String)!
        }
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
}
