//
//  SubscriptionCollectionDelegate.swift
//  DentalYear
//
//  Created by Globizserve on 21/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import Foundation
import UIKit

extension SubscriptionViewController :UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let aCell:SubscriptionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubscriptionCell", for: indexPath) as! SubscriptionCell
        aCell.set(anitem: self.dataArray[indexPath.item])
        return aCell
        
    }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
    //        return CGSize(width: 150 height: self.colList.frame.height - 10)
            return CGSize(width: self.colList.frame.width, height: self.colList.frame.height )
        }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.controllerPage.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        self.selectedSubscribtion = self.controllerPage.currentPage
    }
    
}
