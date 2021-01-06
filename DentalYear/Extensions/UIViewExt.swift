//
//  UIViewExt.swift
//  DentalYear
//
//  Created by Shashank Panwar on 24/10/20.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
