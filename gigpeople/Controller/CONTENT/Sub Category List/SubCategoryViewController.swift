//
//  SubCategoryViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 10/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class SubCategoryViewController: UIViewController {

    @IBOutlet weak var headerLbl: UILabel!
    var getPageFrom:String = ""

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.headerLbl.text = getPageFrom
    }
    @IBAction func searchBtn(_ sender: Any) {
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func seo(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubCategoryDetailsViewController") as? SubCategoryDetailsViewController
        wc?.getPageFrom = "SEO"
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func emailMarketing(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubCategoryDetailsViewController") as? SubCategoryDetailsViewController
        wc?.getPageFrom = "Email Marketing"
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func localListings(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubCategoryDetailsViewController") as? SubCategoryDetailsViewController
        wc?.getPageFrom = "Local Listings"
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func domainResearch(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubCategoryDetailsViewController") as? SubCategoryDetailsViewController
        wc?.getPageFrom = "Domain Research"
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func webAnalytics(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubCategoryDetailsViewController") as? SubCategoryDetailsViewController
        wc?.getPageFrom = "Web Analytics"
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func marketingStrategy(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubCategoryDetailsViewController") as? SubCategoryDetailsViewController
        wc?.getPageFrom = "Marketing Strategy"
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func sem(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubCategoryDetailsViewController") as? SubCategoryDetailsViewController
        wc?.getPageFrom = "SEM"
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func mobileAdvertising(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubCategoryDetailsViewController") as? SubCategoryDetailsViewController
        wc?.getPageFrom = "Mobile Advertising"
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func influencerMarketing(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubCategoryDetailsViewController") as? SubCategoryDetailsViewController
        wc?.getPageFrom = "Influence Marketing"
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func socialMediaMarketing(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubCategoryDetailsViewController") as? SubCategoryDetailsViewController
        wc?.getPageFrom = "Social Media Marketing"
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func webTraffic(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubCategoryDetailsViewController") as? SubCategoryDetailsViewController
        wc?.getPageFrom = "Web Traffic"
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    
}
