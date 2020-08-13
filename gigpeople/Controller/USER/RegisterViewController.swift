//
//  RegisterViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 04/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var scrollObj: UIScrollView!
    override func viewDidLoad()
    {
        super.viewDidLoad()

        var sizeOfContent: Float = 0
        var i: Int
        for i in 0..<scrollObj.subviews.count
        {
            let view = scrollObj.subviews[i] as? UIView
            sizeOfContent += Float(view?.frame.size.height ?? 0.0)
        }
        scrollObj.contentSize = CGSize(width: scrollObj.frame.size.width, height: CGFloat(sizeOfContent-120))
       // scrollObj.contentSize = CGSize(width: scrollObj.frame.size.width, height: scrollObj.frame.size.height + 50)
    }
    @IBAction func register(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let rootViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        let leftViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController")
        let navigationController = UINavigationController(rootViewController: rootViewController)
        let sideMenuController = LGSideMenuController(rootViewController: navigationController, leftViewController: leftViewController, rightViewController: nil)
        let screenRect: CGRect = UIScreen.main.bounds
        let screenWidth: CGFloat = screenRect.size.width / 3
        sideMenuController.leftViewWidth = screenWidth * 2.4
        sideMenuController.leftViewPresentationStyle = .slideAbove
        UIApplication.shared.keyWindow?.rootViewController = sideMenuController
    }
    @IBAction func back(_ sender: Any)
    {
         self.navigationController?.popViewController(animated: true)
    }
    @IBAction func terms(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TermsViewController") as? TermsViewController
        wc?.getPageFrom = "Terms & Conditions"
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func privacy(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TermsViewController") as? TermsViewController
        wc?.getPageFrom = "Privacy Policy"
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    
}
