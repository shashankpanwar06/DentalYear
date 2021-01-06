//
//  RoundCorners.swift
//  DentalYear
//
//  Created by Globizserve on 08/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import Foundation

import UIKit
extension UIView
{
    func makeRoundCorner()  {
        let path = UIBezierPath(roundedRect:self.bounds, byRoundingCorners:[.bottomLeft], cornerRadii: CGSize(width: 80, height: 10))
        let maskLayer = CAShapeLayer()

        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func makeRoundLeftCorner()  {
        let path = UIBezierPath(roundedRect:self.bounds, byRoundingCorners:[.bottomRight,.topRight], cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    func makeRoundCornerOpposite()  {
        let path = UIBezierPath(roundedRect:self.bounds, byRoundingCorners:[.topRight,.bottomLeft], cornerRadii: CGSize(width: 50, height: 50))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func makeAllRoundCorner()  {
        
        self.layer.cornerRadius = 20

    }
    func makeAllRoundCornerWithHeight()  {
         
        self.layer.cornerRadius = self.frame.size.height/2

     }
    class func fromNib(named: String? = nil) -> Self {
         let name = named ?? "\(Self.self)"
         guard
             let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
             else { fatalError("missing expected nib named: \(name)") }
         guard
             /// we're using `first` here because compact map chokes compiler on
             /// optimized release, so you can't use two views in one nib if you wanted to
             /// and are now looking at this
             let view = nib.first as? Self
             else { fatalError("view of type \(Self.self) not found in \(nib)") }
         return view
     }
}
extension UIButton
{
    func makeButtonAllRoundCorner()  {
        
        self.layer.cornerRadius = self.frame.size.height/2

    }
    
}
