//
//  AppDelegate.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 04/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
       // TestFairy.begin("d9696e9f531d2cbd02b10b9d2f6b4958630fde10")
        GMSServices.provideAPIKey(ConfigUrl.googleApiKey)
        GMSPlacesClient.provideAPIKey(ConfigUrl.googleApiKey)
        
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let rootViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
//        let leftViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController")
//        let navigationController = UINavigationController(rootViewController: rootViewController)
//        let sideMenuController = LGSideMenuController(rootViewController: navigationController, leftViewController: leftViewController, rightViewController: nil)
//        let screenRect: CGRect = UIScreen.main.bounds
//        let screenWidth: CGFloat = screenRect.size.width / 3
//        sideMenuController.leftViewWidth = screenWidth * 2.4
//        sideMenuController.leftViewPresentationStyle = .slideAbove
//        window!.rootViewController = sideMenuController
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

