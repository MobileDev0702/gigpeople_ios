//
//  ImageSliderView.swift
//  iMotors
//
//  Created by Administrator on 4/11/17.
//  Copyright © 2017 Differenz System Pvt. Ltd. All rights reserved.
//

import UIKit
import SDWebImage

class ImageSliderView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var cvImageSlider: UICollectionView!
    @IBOutlet weak var imgBanners: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnLeftArrow: UIButton!
    @IBOutlet weak var btnRightArrow: UIButton!
    
    public var currentImageIndex: Int = 0
    var arrBannerImages = [String]()
    
    var timer:Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initialize(arrImages: [String]) {
        self.arrBannerImages = arrImages
        self.pageControl.numberOfPages = arrImages.count
        self.pageControl.currentPage = currentImageIndex
        self.pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor(red:1.00, green:0.31, blue:0.30, alpha:1.0)
        
        self.cvImageSlider.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        self.cvImageSlider.delegate = self
        self.cvImageSlider.dataSource = self
        self.cvImageSlider.reloadData()
    }
    
    @IBAction func LeftArrow_Clicked(_ sender: Any) {
        //swipeLeft()
        
        let prevIndex = currentImageIndex - 1
        if(prevIndex >= 0){
            let indexPath = IndexPath(item: prevIndex, section: 0)
            self.cvImageSlider.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            currentImageIndex = prevIndex
            pageControl.currentPage = currentImageIndex
        }
    }
    
    @IBAction func RightArrow_Clicked(_ sender: Any) {
        //swipeRight()
        
        var nextIndex = currentImageIndex + 1
        if(nextIndex < self.arrBannerImages.count){
            let indexPath = IndexPath(item: nextIndex, section: 0)
            self.cvImageSlider.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            currentImageIndex = nextIndex
            pageControl.currentPage = currentImageIndex
        }else if self.arrBannerImages.count > 0
        {
            nextIndex = 0
            let indexPath = IndexPath(item: nextIndex, section: 0)
            self.cvImageSlider.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            currentImageIndex = nextIndex
            pageControl.currentPage = currentImageIndex
        }
    }
    
    func TimerStart()
    {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(RightArrow_Clicked(_:)), userInfo: nil, repeats: true)
    }
    
    func TimerStop()
    {
        timer?.invalidate()
        timer = nil
    }
    
    //MARK: CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrBannerImages.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell
        
        let strUrl = self.arrBannerImages[indexPath.row]
      //  cell?.img.sd_setImage(with: URL(string: strUrl), placeholderImage: UIImage(named: "noimg"))
        cell?.img.image = UIImage.init(named: strUrl)
        cell?.img.contentMode = .scaleToFill
        
         return cell!
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cvImageSlider.bounds.size
     }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    }
    
    //MARK: Scrollview Method
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        let pageWidth: CGFloat = scrollView.frame.size.width
        let page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        self.pageControl.currentPage = Int(page)
        self.currentImageIndex = Int(page)
    }
}
