//
//  ViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 04/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,HHPageViewDelegate,UIScrollViewDelegate
{

    @IBOutlet weak var pageController: HHPageView!
    @IBOutlet weak var scrollObj: UIScrollView!
    @IBOutlet weak var skipBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        let numberOfPages: Int = 3
        addNoOfPagesHorizontally(numberOfPages)
        configureHorizontalController(withTotalPages: numberOfPages)
        scrollObj.delegate = self
    }
    func addNoOfPagesHorizontally(_ pages: Int)
    {
        let numberOfPages: Int = pages
        var x: Int = 0
        for i in 0..<numberOfPages
        {
            let image = UIImageView(frame: CGRect(x: CGFloat(x), y: 0, width: scrollObj.frame.size.width, height: scrollObj.frame.size.height))
            let imgName = "slider\(i+1)"
            image.image = UIImage.init(named: imgName)
            scrollObj.addSubview(image)
            
            let xVal = scrollObj.frame.size.width
            x = Int(xVal)+x
        }
        if isIphoneX()
        {
            print("X Variant Device")
            scrollObj.contentSize = CGSize(width: CGFloat(x), height: scrollObj.frame.size.height - 100)
        }
        else
        {
            scrollObj.contentSize = CGSize(width: CGFloat(x), height: scrollObj.frame.size.height - 50)
        }
        scrollObj.isPagingEnabled = true
        scrollObj.bounces = false
        scrollObj.showsHorizontalScrollIndicator = false
        scrollObj.showsVerticalScrollIndicator = false
    }
    func configureHorizontalController(withTotalPages totalPages: Int)
    {
        pageController.delegate = self
        pageController.baseScrollView = scrollObj
        pageController.setImageActiveState(UIImage(named: "selected"), inActiveState: UIImage(named: "notselected"))
        pageController.setNumberOfPages(totalPages)
        pageController.setCurrentPage(1)
        pageController.load()
    }
    func scrollViewDidEndDecelerating(_ scroll: UIScrollView)
    {
        if !scroll.isDragging
        {
            let pageWidth = Int(scroll.frame.size.width)
            let page: Int = Int((floor((scroll.contentOffset.x - CGFloat(pageWidth / 2)) / CGFloat(pageWidth)) + 1) + 1)
            pageController.updateState(forPageNumber: page)
        }
    }
    
    func hhPageView(_ pageView: HHPageView!, currentIndex: Int)
    {
        let baseScroll = pageView.baseScrollView
        if baseScroll != nil
        {
            let xVal = scrollObj.frame.size.width
            baseScroll?.setContentOffset(CGPoint(x: currentIndex * Int(xVal), y: 0), animated: true)
        }
    }
    @IBAction func skipBtn(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let abcViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(abcViewController, animated: true)
    }

}

