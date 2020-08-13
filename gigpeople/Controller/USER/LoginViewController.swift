//
//  LoginViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 04/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit
import LGSideMenuController

class LoginViewController: UIViewController {

    @IBOutlet var scrollObj: UIScrollView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passwrs: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        var sizeOfContent: Float = 0
        var i: Int
        for i in 0..<scrollObj.subviews.count
        {
            let view = scrollObj.subviews[i] as? UIView
            sizeOfContent += Float(view?.frame.size.height ?? 0.0)
        }
        scrollObj.contentSize = CGSize(width: scrollObj.frame.size.width, height: CGFloat(sizeOfContent + 10))
    }
    
    @IBAction func login(_ sender: Any)
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
    
    @IBAction func facebook(_ sender: Any)
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
    @IBAction func google(_ sender: Any)
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
    @IBAction func forgot(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let abcViewController = storyboard.instantiateViewController(withIdentifier: "ForgotViewController") as! ForgotViewController
        navigationController?.pushViewController(abcViewController, animated: true)
    }
    @IBAction func register(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let abcViewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        navigationController?.pushViewController(abcViewController, animated: true)
    }
    
}
