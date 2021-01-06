//
//  AppStoreReviewManager.swift
//  DentalYear
//
//  Created by Globizserve on 18/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import Foundation
import StoreKit

enum AppStoreReviewManager {
    static let minimumReviewWorthyActionCount = 7
    
  static func requestReviewIfAppropriate() {
    if #available(iOS 10.3, *) {
        let defaults = UserDefaults.standard
//        let bundle = Bundle.main

        // 2.
        var actionCount = defaults.integer(forKey: "count")

        if defaults.object(forKey: "count") == nil {
          
            actionCount = 0
            // 4.
            defaults.set(actionCount, forKey: "count")
//            SKStoreReviewController.requestReview()

            return
        }
        // 3.
        actionCount += 1

        // 4.
        defaults.set(actionCount, forKey: "count")

        // 5.
        guard actionCount >= minimumReviewWorthyActionCount else {
          return
        }

        // 6.
//        let bundleVersionKey = kCFBundleVersionKey as String
//        let currentVersion = bundle.object(forInfoDictionaryKey: bundleVersionKey) as? String
//        let lastVersion = defaults.string(forKey: "lastReview")

        // 7.
//        guard lastVersion == nil || lastVersion != currentVersion else {
//          return
//        }

        // 8.
        SKStoreReviewController.requestReview()

        // 9.
        defaults.set(0, forKey: "count")
//        defaults.set(currentVersion, forKey: "lastReview")
        
    } else {
        // Fallback on earlier versions
    }
  }
}
