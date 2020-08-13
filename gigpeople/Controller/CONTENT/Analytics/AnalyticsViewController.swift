//
//  AnalyticsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 12/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit
import PieCharts

class AnalyticsViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var chartView: PieChart!
    @IBOutlet weak var scrollObj: UIScrollView!
    
    override func viewDidLoad()
    {
        chartView.models = [
            PieSliceModel(value: 2.1, color: UIColor(red:0.98, green:0.84, blue:0.00, alpha:1.0)),
            PieSliceModel(value: 3, color: UIColor(red:0.20, green:0.62, blue:0.82, alpha:1.0)),
            PieSliceModel(value: 1, color: UIColor(red:0.00, green:0.62, blue:0.00, alpha:1.0)),
            PieSliceModel(value: 2.1, color: UIColor(red:0.99, green:0.49, blue:0.00, alpha:1.0)),
            PieSliceModel(value: 3, color: UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)),
        ]
        super.viewDidLoad()
        self.scrollObj.contentSize = CGSize(width: self.scrollObj.frame.size.width, height:self.scrollObj.frame.size.height+450)
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
