//
//  SubscriptionViewController.swift
//  DentalYear
//
//  Created by Globizserve on 21/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit
import EzPopup

class SubscriptionViewController: UIViewController {
    @IBOutlet weak var btnSubscribe: UIButton!
    
    @IBOutlet weak var btnRestorePurchase: UIButton!
    @IBOutlet weak var btnSubscriptionDetails: UIButton!
    @IBOutlet weak var controllerPage: UIPageControl!
    @IBOutlet weak var colList: UICollectionView!
    
    var selectedSubscribtion : Int?{
        didSet{
            subscriptionPlanSlected()
        }
    }
    var dataArray:[item] = [item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCallBacks()
        configure()
        configureCollectionView()
        loadData()
        getInAppPurchaseProducts()
        subscriptionPlanSlected()
        self.MoveTotabBar()
    }

    func subscriptionPlanSlected(){
        let anitem = self.dataArray[self.controllerPage.currentPage]
        if anitem.title == "MONTHLY PLAN"{
            btnSubscribe.setTitle("Subscribe for \(anitem.title)", for: .normal)
//            if anitem.product != nil {
//                lblPrice.text = "First Month Free, then \(anitem.product?.localizedPrice ?? anitem.price)/month"
//            }else
//            {
//                lblPrice.text = "First Month Free, then \(anitem.price)/month"
//            }
        }else if anitem.title == "ANNUAL PLAN"{
            btnSubscribe.setTitle("Subscribe for \(anitem.title)", for: .normal)
//            if anitem.product != nil {
//                lblPrice.text = "\(anitem.product?.localizedPrice ?? anitem.price)"
//            }else
//            {
//                lblPrice.text = "\(anitem.price)"
//            }
//            lblDuration.text = anitem.Duration
        }
    }
    
    func configureCallBacks()  {
        SubscriptionManager.shared.pendingTransactionCompleted = {
            isSubscribed in
            if isSubscribed {
                self.MoveTotabBar()
            }
        }
        SubscriptionManager.shared.productsFetched = {
            products in
            self.dataArray = SubscriptionManager.shared.mapData(products: products, items: self.dataArray)
            self.colList.reloadData()
        }
        
        SubscriptionManager.shared.subscriptionSuccess = {
            purchase in
            self.MoveTotabBar()
        }
        
        SubscriptionManager.shared.subscriptionOk = {
            self.MoveTotabBar()
        }
        SubscriptionManager.shared.subscriptionError = { error in
            switch error.code {
            case .unknown: self.showError(string: "Unknown error. Please contact support")
            case .clientInvalid: self.showError(string:"Not allowed to make the payment")
            case .paymentCancelled: break
            case .paymentInvalid: self.showError(string:"The purchase identifier was invalid")
            case .paymentNotAllowed: self.showError(string:"The device is not allowed to make the payment")
            case .storeProductNotAvailable: self.showError(string:"The product is not available in the current storefront")
            case .cloudServicePermissionDenied: self.showError(string:"Access to cloud service information is not allowed")
            case .cloudServiceNetworkConnectionFailed: self.showError(string:"Could not connect to the network")
            case .cloudServiceRevoked: self.showError(string:"User has revoked permission to use this cloud service")
            default: self.showError(string:(error as NSError).localizedDescription)
            }
            
        }
        SubscriptionManager.shared.subscriptionRestored = {
            self.MoveTotabBar()
        }
        
        SubscriptionManager.shared.subscriptionRestoredFailed = {
            DispatchQueue.main.async {
                self.showError(string: "Failed to restore product please try again")
            }
        }
        SubscriptionManager.shared.subscriptionRestoredNotFound = {
            DispatchQueue.main.async {
                self.showError(string: "Nothing to restore please subscribe")
            }
        }
        SubscriptionManager.shared.subscriptionExpired = {
            self.showError(string: "Subscription expired")
         }

    }
    
    @IBAction func pageControlEvent(_ sender: UIPageControl) {
        let item = self.dataArray[self.controllerPage.currentPage]
        print("Item : \(item)")
    }
    
    
    func loadData()  {
        dataArray = SubscriptionData.getSubscriptionDataArray()
        colList.reloadData()
    }
    func configure()  {
        btnSubscribe.makeButtonAllRoundCorner()
        btnRestorePurchase.makeButtonAllRoundCorner()
        btnSubscriptionDetails.makeButtonAllRoundCorner()
        
    }
    func getInAppPurchaseProducts()  {
        SubscriptionManager.shared.finsihPendingTransaction()

        SubscriptionManager.shared.getProducts()

    }
    func configureCollectionView()
    {
        
        colList.register(UINib.init(nibName: "SubscriptionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SubscriptionCell")
        colList.delegate = self
        colList.dataSource = self
        colList.reloadData()
        
    }
    
    
    @IBAction func onBtnSubscribe(_ sender: Any) {
        //        MoveTotabBar()
        SubscriptionManager.shared.subscribe(anItem: self.dataArray[self.controllerPage.currentPage])
    }
    
    func showError(string:String)  {
        
        DispatchQueue.main.async {
            let customPopUp:CustomPopUp = CustomPopUp.init(nibName: "CustomPopUp", bundle: Bundle.main)
            let popupVC = PopupViewController(contentController: customPopUp, popupWidth: self.view.frame.width - 30, popupHeight: 250)
            customPopUp.set(title: "Subscription Failed", description: string, affermativeText: "Exit", cancelText: "Cancel", showCancel: false, showaffermative: false, selfHide: true)
                       
            customPopUp.affirmativeBtnBtnPressed = {
                popupVC.dismiss(animated: true) {
                }
            }
                       
            customPopUp.cancelBtnBtnPressed = {
                popupVC.dismiss(animated: true) {
                    
                }
            }
            self.present(popupVC, animated: true) {
            }
        }
    }
    @IBAction func onBtnRestorePurchase(_ sender: Any) {
        SubscriptionManager.shared.restorePurchase()

    }
    @IBAction func onBtnSuscriptionDetails(_ sender: Any) {
        
        let aSubscriptionDetails:SubscriptionDetails = SubscriptionDetails.init(nibName: "SubscriptionDetails", bundle: Bundle.main)
        let popupVC = PopupViewController(contentController: aSubscriptionDetails, popupWidth: self.view.frame.width - 50, popupHeight: 302)
                   
        aSubscriptionDetails.closeBtnBtnPressed = {
            popupVC.dismiss(animated: true) {
            }
        }
                   
        aSubscriptionDetails.termsBtnBtnPressed = {
           let termsUrl:URL = URL(string: "https://dentalyear.com/terms-of-use")!
                 if (UIApplication.shared.canOpenURL(termsUrl))
                 {
                     UIApplication.shared.open(termsUrl, options: [:]) { (true) in
                         
                     }
                 }
        }
        aSubscriptionDetails.privacyBtnBtnPressed = {
            let privacyUrl:URL = URL(string: "https://dentalyear.com/privacy")!
            if (UIApplication.shared.canOpenURL(privacyUrl))
            {
                UIApplication.shared.open(privacyUrl, options: [:]) { (true) in
                    
                }
            }
      
           }
        self.present(popupVC, animated: true) {
        }
    }
    


    func MoveTotabBar()  {
        DispatchQueue.main.async {
             let storyBoard:UIStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)

            guard let tabBarController:DYTabBarViewController = storyBoard.instantiateViewController(withIdentifier: "DYTabBarViewController") as? DYTabBarViewController else {return}
            AppDelegate().sharedInstance().window?.rootViewController = tabBarController
            AppDelegate().sharedInstance().window!.makeKeyAndVisible()
        }


    }

}
