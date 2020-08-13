//
//  BillingViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 12/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit
import GooglePlaces

class BillingViewController: UIViewController,GMSAutocompleteViewControllerDelegate
{
    
    @IBOutlet weak var addressFld: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addressBtn(_ sender: Any)
    {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        UINavigationBar.appearance().barTintColor = UIColor(red:1.00, green:0.46, blue:0.00, alpha:1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        if #available(iOS 9.0, *)
        {
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        else
        {
            print("Check")
        }
        present(autocompleteController, animated: true, completion: nil)
    }
    @IBAction func submitBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace)
    {
        self.addressFld.text = place.formattedAddress
        dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error)
    {
        print("Error: ", error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController)
    {
        dismiss(animated: true, completion: nil)
    }
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
