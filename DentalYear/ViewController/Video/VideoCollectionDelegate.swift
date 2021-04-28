//
//  VideoCOllectionDelegate.swift
//  DentalYear
//
//  Created by Globizserve on 11/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import Foundation
import UIKit
extension VideoViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let aCell:VideoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
        aCell.set(video: self.dataArray[indexPath.item])
        aCell.downloadBtnPressed = {
            video in
            self.downloadFor(video: video)
        }
        return aCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 150 height: self.colList.frame.height - 10)
        return CGSize(width: self.colList.frame.width/2.5, height: self.colList.frame.height * 0.85 )
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selected(index: indexPath.item)
    }
    
}
