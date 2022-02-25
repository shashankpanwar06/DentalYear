//
//  ThirdOnboardingVC.swift
//  DentalYear
//
//  Created by Shashank Panwar on 20/01/22.
//  Copyright © 2022 Globizserve. All rights reserved.
//

import UIKit
import Gifu

class ThirdOnboardingVC: UIViewController {
    @IBOutlet weak var mainImageView: GIFImageView!
    
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    @IBOutlet weak var rightBtn: UIButton!
    
    var currentdisplayIndex = 0
    
    var reviews = [Reviewer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGif()
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self
        reviews = [Reviewer(reviewTitle: "Essential!", reviewDescription: "This App is a must have for Dentists and Team Members! It's an essential marketing too to help you stand out. Highly recommended!.", reviewer: ""),
        Reviewer(reviewTitle: "Cool Features, Amazing Content!", reviewDescription: "DentalYear delivers fun content that makes it easier to manage our Social Media pages.  Our entire office LOVES this APP!!", reviewer: ""),
        Reviewer(reviewTitle: "Genius Dental App", reviewDescription: "Such a resourceful App and highly recommended.  This has become an essential tool in marketing our Dental Practice successfully.  We check it constantly for inspiration and resources.", reviewer: "")]
    }
    
    func loadGif(){
        mainImageView.animate(withGIFNamed: "screen-3_1", animationBlock:  {
            print("Image Load")
        })
    }
    
    @IBAction func leftBtnPressed(_ sender: UIButton) {
        if sender.isSelected{
            self.reviewCollectionView.scrollToItem(at: IndexPath(item: currentdisplayIndex - 1, section: 0), at: .left, animated: true)
        }
    }
    
    @IBAction func rightBtnPressed(_ sender: UIButton) {
        if sender.isSelected{
            self.reviewCollectionView.scrollToItem(at: IndexPath(item: currentdisplayIndex + 1, section: 0), at: .right, animated: true)
        }
    }
    
}

extension ThirdOnboardingVC : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCellId", for: indexPath) as? ReviewCell{
            cell.review = reviews[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentdisplayIndex = indexPath.item
        switch indexPath.item{
        case 0:
            leftBtn.isSelected = false
            rightBtn.isSelected = true
        case 1:
            leftBtn.isSelected = true
            rightBtn.isSelected = true
        case 2:
            leftBtn.isSelected = true
            rightBtn.isSelected = false
        default:
            break
        }
    }
    
    
}

extension ThirdOnboardingVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 10, height: collectionView.frame.height)
    }
}


