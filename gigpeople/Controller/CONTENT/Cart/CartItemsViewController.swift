//
//  CartItemsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 09/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class CartItemsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var cartTableObj: UITableView!
    @IBOutlet var footerVw: UIView!
    
    @IBOutlet weak var paymentInVw: UIView!
    @IBOutlet var paymentVw: UIView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        paymentInVw.layer.cornerRadius = 10
        paymentInVw.clipsToBounds = true
        
        self.cartTableObj.allowsMultipleSelectionDuringEditing = false
        self.cartTableObj.tableFooterView = UIView()
    }
    @IBAction func paypalBtn(_ sender: Any)
    {
        paymentVw.removeFromSuperview()
        
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyOrdersViewController") as? MyOrdersViewController
        var naviVC: UINavigationController? = nil
        if let homeVC = homeVC
        {
            naviVC = UINavigationController(rootViewController: homeVC)
        }
        sideMenuController!.rootViewController = naviVC
        sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
    }
    @IBAction func weChatBtn(_ sender: Any)
    {
        paymentVw.removeFromSuperview()
        
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyOrdersViewController") as? MyOrdersViewController
        var naviVC: UINavigationController? = nil
        if let homeVC = homeVC
        {
            naviVC = UINavigationController(rootViewController: homeVC)
        }
        sideMenuController!.rootViewController = naviVC
        sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
    }
    @IBAction func creditCardBtn(_ sender: Any)
    {
        paymentVw.removeFromSuperview()
        
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyOrdersViewController") as? MyOrdersViewController
        var naviVC: UINavigationController? = nil
        if let homeVC = homeVC
        {
            naviVC = UINavigationController(rootViewController: homeVC)
        }
        sideMenuController!.rootViewController = naviVC
        sideMenuController!.hideLeftView(animated: true, completionHandler: nil)
    }
    @IBAction func paymentCloseBtn(_ sender: Any)
    {
        paymentVw.removeFromSuperview()
    }
    @IBAction func proceedPaymentBtn(_ sender: Any)
    {
        paymentVw.frame = UIScreen.main.bounds
        view.addSubview(paymentVw)
    }
    @IBAction func cancelBtn(_ sender: Any)
    {
        self.backBtn(self)
    }
    
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return self.footerVw
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var nib = Bundle.main.loadNibNamed("CartTableViewCell", owner: self, options: nil)
        let cell = nib?[0] as? CartTableViewCell
        cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
        
        cell?.numberFld.tag = indexPath.row
        
        cell?.plusBtn.tag = indexPath.row
        cell?.plusBtn.addTarget(self, action: #selector(plusClicked), for: .touchUpInside)
        
        cell?.minusBtn.tag = indexPath.row
        cell?.minusBtn.addTarget(self, action: #selector(minusClicked), for: .touchUpInside)
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let remove = UITableViewRowAction(style: .default, title: "      ")
        { action, indexPath in
            print("delete button tapped")
        }
        remove.backgroundColor = UIColor(patternImage: UIImage(named: "deleteSmall")!)
        return [remove]
    }
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let editAction = UIContextualAction(style: .normal, title: "", handler: { action, sourceView, completionHandler in
            print("Do editing")
            completionHandler(true)
        })
        editAction.image = UIImage(named: "deleteSmall")
        editAction.backgroundColor = UIColor.orange
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    @IBAction func plusClicked(_ sender: UIButton)
    {
        print("Plus Clicked")
        let myIndexPath = NSIndexPath(row: sender.tag, section: 0)
        let cell = self.cartTableObj.cellForRow(at: myIndexPath as IndexPath) as? CartTableViewCell
        
        var countVal:Int? = Int((cell?.numberFld.text)!)
        countVal = countVal! + 1
        cell?.numberFld.text = "\(countVal!)"
    }
    @IBAction func minusClicked(_ sender: UIButton)
    {
        print("Minus Clicked")
        let myIndexPath = NSIndexPath(row: sender.tag, section: 0)
        let cell = self.cartTableObj.cellForRow(at: myIndexPath as IndexPath) as? CartTableViewCell
        
        var countVal:Int? = Int((cell?.numberFld.text)!)
        countVal = countVal! - 1
        if (countVal! < 1)
        {
             cell?.numberFld.text = "1"
        }
        else
        {
          cell?.numberFld.text = "\(countVal!)"
        }
    }
}
