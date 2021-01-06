//
//  SubscriptionManager.swift
//  DentalYear
//
//  Created by Globizserve on 22/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import Foundation
import SwiftyStoreKit
import StoreKit
import SVProgressHUD

class SubscriptionManager
{
    let productIds:Set<String> = ["com.dentalyear.monthly30FREE","com.dyear.dentalyear.yr365"]
    
    static let shared = SubscriptionManager()
    init(){}
    
    var purchases:[Purchase] = [Purchase]()
    var products:Set<SKProduct> = []
    
    var pendingTransactionCompleted:((_ isSubscribed:Bool)->Void)?
    var productsFetched:((_ products:Set<SKProduct>)->Void)?
    
    var subscriptionError:((_ error:SKError)->Void)?
    var subscriptionSuccess:((_ purchase:PurchaseDetails)->Void)?
    var subscriptionOk:(()->Void)?
    var subscriptionExpired:(()->Void)?
    var subscriptionRestored:(()->Void)?
    var subscriptionRestoredFailed:(()->Void)?
    var subscriptionRestoredNotFound:(()->Void)?
    
    
    func finsihPendingTransaction()  {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            self.purchases = purchases
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                        if self.pendingTransactionCompleted != nil {
                            self.pendingTransactionCompleted!(true)
                        }
                    }
                    // Unlock content
                case .failed, .purchasing, .deferred:
                    if self.pendingTransactionCompleted != nil {
                        self.pendingTransactionCompleted!(false)
                    }
                    break // do nothing
                @unknown default:
                    if self.pendingTransactionCompleted != nil {
                        self.pendingTransactionCompleted!(false)
                    }
                    break
                }
            }
        }
    }
    
    
    func getProducts()  {
        SwiftyStoreKit.retrieveProductsInfo(productIds) { result in
            let products = result.retrievedProducts
            if let error = result.error
            {
                print("Error in IAP \(error.localizedDescription)")
                return
            }
            if products.count > 0
            {
                self.products = products
                if self.productsFetched != nil {
                    self.productsFetched!(self.products)
                }
            }
            let invalidProductId = result.invalidProductIDs
            if invalidProductId.count > 0
            {
                print("products not fetched  \(result.invalidProductIDs)")
                return
            }

        }
    }
    
    func mapData(products:Set<SKProduct>,items:[item]) -> [item] {
        
        var tempItems:[item] = [item]()
        for var item in items
        {
             for product in products
              {
                self.productInfo(shouldPrint: false, product: product)
                if item.productId == product.productIdentifier
                {
                    item.product = product
                    tempItems.append(item)
                }
              }
        }
        return tempItems
    }
    func productInfo(shouldPrint:Bool,product:SKProduct)  {
        if !shouldPrint {
            return
        }
        print("*******************************\n\(product.productIdentifier)")
        print("\(product.localizedDescription)")
        print("\(product.localizedTitle)")
        print("\(product.price)")
        if #available(iOS 11.2, *) {
            print("\(String(describing: product.subscriptionPeriod))")
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 11.2, *) {
            print("\(String(describing: product.introductoryPrice?.localizedPrice))")
        } else {
            // Fallback on earlier versions
        }
        print("*******************************")

    }
    
    
    func subscribe(anItem:item)  {
        guard let product = anItem.product else {
            return
        }
        SVProgressHUD.show()
        SwiftyStoreKit.purchaseProduct(product.productIdentifier, quantity: 1, atomically: true) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let purchase):
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
                if let successCallback = self.subscriptionSuccess
                {
                    successCallback(purchase)
                }
            case .error(let error):
                if let errCallback = self.subscriptionError
                {
                    errCallback(error)
                }
            }
        }
    }
    
    func restorePurchase()  {
        SVProgressHUD.show()
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            SVProgressHUD.dismiss()
            if results.restoreFailedPurchases.count > 0 {
                if let aSubscriptionRestoredFailed = self.subscriptionRestoredFailed {
                        aSubscriptionRestoredFailed()
                }
            }
            else if results.restoredPurchases.count > 0 {
                if let aSubscriptionRestored = self.subscriptionRestored {
                        aSubscriptionRestored()
                }
            }
            else {
                if let asubscriptionRestoredNotFound = self.subscriptionRestoredNotFound {
                            asubscriptionRestoredNotFound()
                    }
            }
        }
    }
    
    func validateSubscription() {
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "8e24def45fd249f29db28c77e4b1df35")
        SwiftyStoreKit.verifyReceipt(using: appleValidator , forceRefresh: false) { result in
            switch result {
            case .success(let receipt):
//                 Verify the purchase of a Subscription
                let purchaseResult = SwiftyStoreKit.verifySubscriptions(ofType: .autoRenewable, productIds: self.productIds, inReceipt: receipt, validUntil: Date())
                    
                switch purchaseResult {
                case .purchased(let expiryDate, let items):
                    print(" is valid until \(expiryDate)\n\(items)\n")
                    if let aSubscriptionOk = self.subscriptionOk
                    {
                        aSubscriptionOk()
                    }
                case .expired(let expiryDate, let items):
                    print(" is expired since \(expiryDate)\n\(items)\n")
                    if let aSubscriptionExpired = self.subscriptionExpired
                      {
                          aSubscriptionExpired()
                      }
                case .notPurchased:
                    print("The user has never purchased ")
                    if let aSubscriptionExpired = self.subscriptionExpired
                    {
                        aSubscriptionExpired()
                    }
                }

            case .error(let error):
                print("Receipt verification failed: \(error)")
                print("The user has never purchased ")
                if let aSubscriptionExpired = self.subscriptionExpired
                {
                          aSubscriptionExpired()
                }
            }
        }
    }
}
