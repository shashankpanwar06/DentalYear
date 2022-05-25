//
//  VideoViewController.swift
//  DentalYear
//
//  Created by Globizserve on 11/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit
import PINCache
import Alamofire
import SwiftyJSON
import EzPopup
import SwiftyStoreKit
import StoreKit
import SVProgressHUD


class VideoViewController: UIViewController {

    
    var timerForShowScrollIndicator: Timer?
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var btnDownlaod: UIButton!
    @IBOutlet weak var viewVideoContainer: UIView!
    @IBOutlet weak var colList: UICollectionView!
    @IBOutlet weak var btnSMileQuotes: UIButton!
    @IBOutlet weak var fullScreenbackgroundView: UIView!
    @IBOutlet weak var btnOralHealth: UIButton!
    @IBOutlet weak var btnFunVibes: UIButton!
    @IBOutlet weak var premiumVideoBtn: UIButton!
    var dataArray:[VideoObject] = [VideoObject]()
    var videoCatType:kVideoCategory = .Fun
    
    var videoObject:VideoBaseObject?
    
    var selectedVideo:VideoObject?
    var videoPlayer:BMPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForInitial()
        configureCollectionView()
        setUpPlayer()
        loadData()
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        colList.flashScrollIndicators()
        startTimerForShowScrollIndicator()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timerForShowScrollIndicator?.invalidate()
        if self.videoPlayer?.isPlaying ?? false
        {
            self.videoPlayer?.pause()
        }
        
    }
    
    @objc func showScrollIndicatorsInContacts() {
        
        UIView.animate(withDuration: 0.00001) {
            self.colList.flashScrollIndicators()
            
        }
    }
    func startTimerForShowScrollIndicator() {
        self.timerForShowScrollIndicator = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.showScrollIndicatorsInContacts), userInfo: nil, repeats: true)
    }
    
    func configureCollectionView()  {
        colList.register(UINib.init(nibName: "VideoCell", bundle: Bundle.main), forCellWithReuseIdentifier: "VideoCell")
        colList.delegate = self
        colList.dataSource = self
        let cellWidth : CGFloat = 150
        let cellheight : CGFloat = self.colList.frame.size.height - 10.0
        let cellSize = CGSize(width: cellWidth , height:cellheight)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        self.colList.setCollectionViewLayout(layout, animated: true)
        
    }
    
    
    func configure()  {
        btnSMileQuotes.makeButtonAllRoundCorner()
        btnOralHealth.makeButtonAllRoundCorner()
        btnFunVibes.makeButtonAllRoundCorner()
        premiumVideoBtn.makeButtonAllRoundCorner()
        colList.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: colList.frame.size.height - 8, right: 0)
        
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            print(CGFloat.pi)
            print(CGFloat.pi * 2.0)
            sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        } completion: { (status) in
            UIView.animate(withDuration: 0.5) {
                sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
            } completion: { (status) in
                sender.transform = .identity
            }
        }
        
        fetchDataFromAPI()
    }
    
    
    @IBAction func onBtnDownlaod(_ sender: Any) {
        
        guard let aDownloadViewController:DownloadViewController = self.storyboard?.instantiateViewController(withIdentifier: "DownloadViewController") as? DownloadViewController else {return}
        aDownloadViewController.playBtnPressed = {
            video in
            self.selectedVideo = video
            self.configurePlayer(video: self.selectedVideo!)
        }
        self.navigationController?.pushViewController(aDownloadViewController, animated: true)
        
        
    }
    func downloadFor(video:VideoObject)  {
        navigateToDownloadViewController(video: video)
//        if videoCatType == .premium{
//            if let purchasedId = video.acf.purchaseId{
//                if UserDefaults.standard.bool(forKey: purchasedId){
//                    print("Video is already purchased.")
//                    self.navigateToDownloadViewController(video: video)
//                }else{
//                    productInfo(productId: purchasedId)
//                }
//            }
//        }else{
//            navigateToDownloadViewController(video: video)
//        }
    }
    
    private  func navigateToDownloadViewController(video : VideoObject){
        guard let aDownloadViewController:DownloadViewController = self.storyboard?.instantiateViewController(withIdentifier: "DownloadViewController") as? DownloadViewController else {return}
        aDownloadViewController.videoToDownload = video
        aDownloadViewController.playBtnPressed = {
            video in
            self.selectedVideo = video
            self.configurePlayer(video: self.selectedVideo!)
        }
        self.navigationController?.pushViewController(aDownloadViewController, animated: true)
    }
    
    
    @IBAction func onBtnFunVibes(_ sender: Any) {
        
        if btnFunVibes.isSelected {
            return
        }
        setupForFun()
    }
    @IBAction func onBtnOralHealth(_ sender: Any) {
        if btnOralHealth.isSelected {
            return
        }
        setupForOral()
    }
    
    @IBAction func onBtnSmiles(_ sender: Any) {
        if btnSMileQuotes.isSelected {
            return
        }
        setupForSmile()
    }
    
    
    @IBAction func premiumBtnPressed(_ sender: UIButton) {
        if premiumVideoBtn.isSelected{
            return
        }
        setupForPremium()
    }
    

    
    func setUpPlayer()  {
        
        BMPlayerConf.allowLog = false
        // should auto play, default true
        BMPlayerConf.shouldAutoPlay = true
        // main tint color, default whiteColor
        BMPlayerConf.tintColor = UIColor.textGrey
        // options to show header view (which include the back button, title and definition change button) , default .Always，options: .Always, .HorizantalOnly and .None
        BMPlayerConf.topBarShowInCase = .none
        // loader type, see detail：https://github.com/ninjaprox/NVActivityIndicatorView
        BMPlayerConf.loaderType  = .ballPulse
        // enable setting the brightness by touch gesture in the player
        BMPlayerConf.enableBrightnessGestures = true
        // enable setting the volume by touch gesture in the player
        BMPlayerConf.enableVolumeGestures = true
        // enable setting the playtime by touch gesture in the player
        BMPlayerConf.enablePlaytimeGestures = true
        BMPlayerConf.shouldAutoPlay = false
        
    }
    
    func setupForInitial()
    {
        self.btnFunVibes.isSelected = true
        self.btnFunVibes.backgroundColor = UIColor.hexStringToUIColor(hex: "#3cbdeb")
        
        self.btnOralHealth.isSelected = false
        self.btnOralHealth.backgroundColor = UIColor.clear
        self.btnSMileQuotes.isSelected = false
        self.btnSMileQuotes.backgroundColor = UIColor.clear
        premiumVideoBtn.isSelected = false
        premiumVideoBtn.backgroundColor = UIColor.clear
        videoCatType = .Fun
    }
    func setupForFun()
    {
        self.btnFunVibes.isSelected = true
        self.btnFunVibes.backgroundColor = UIColor.hexStringToUIColor(hex: "#3cbdeb")
        
        self.btnOralHealth.isSelected = false
        self.btnOralHealth.backgroundColor = UIColor.clear
        self.btnSMileQuotes.isSelected = false
        self.btnSMileQuotes.backgroundColor = UIColor.clear
        premiumVideoBtn.isSelected = false
        premiumVideoBtn.backgroundColor = UIColor.clear
        videoCatType = .Fun
        reloadDataOnSlecetionChange()
        
    }
    func setupForOral()
    {
        self.btnOralHealth.isSelected = true
        self.btnOralHealth.backgroundColor = UIColor.hexStringToUIColor(hex: "#3cbdeb")
        
        self.btnFunVibes.isSelected = false
        self.btnFunVibes.backgroundColor = UIColor.clear
        self.btnSMileQuotes.isSelected = false
        self.btnSMileQuotes.backgroundColor = UIColor.clear
        premiumVideoBtn.isSelected = false
        premiumVideoBtn.backgroundColor = UIColor.clear
        videoCatType = .Oral
        reloadDataOnSlecetionChange()
        
        
    }
    func setupForSmile()
    {
        self.btnSMileQuotes.isSelected = true
        self.btnSMileQuotes.backgroundColor = UIColor.hexStringToUIColor(hex: "#3cbdeb")
        
        self.btnOralHealth.isSelected = false
        self.btnOralHealth.backgroundColor = UIColor.clear
        self.btnFunVibes.isSelected = false
        self.btnFunVibes.backgroundColor = UIColor.clear
        premiumVideoBtn.isSelected = false
        premiumVideoBtn.backgroundColor = UIColor.clear
        videoCatType = .smile
        reloadDataOnSlecetionChange()
        
    }
    
    func setupForPremium(){
        premiumVideoBtn.isSelected = true
        premiumVideoBtn.backgroundColor = UIColor.hexStringToUIColor(hex: "#3cbdeb")
        
        self.btnSMileQuotes.isSelected = false
        self.btnSMileQuotes.backgroundColor = UIColor.clear
        
        self.btnOralHealth.isSelected = false
        self.btnOralHealth.backgroundColor = UIColor.clear
        self.btnFunVibes.isSelected = false
        self.btnFunVibes.backgroundColor = UIColor.clear
        
        videoCatType = .premium
        reloadDataOnSlecetionChange()
    }
    
    func reloadDataOnSlecetionChange()  {
        self.dataArray = videoObject!.getDataFor(category: self.videoCatType)
        if self.dataArray.count > 0
        {
            self.selectedVideo = self.dataArray[0]
            self.configurePlayer(video: self.selectedVideo!)
            print("Selected Video PurchaseId : \(self.selectedVideo?.acf.purchaseId)")
//            if videoCatType == .premium{
//                if let productId = self.selectedVideo?.acf.purchaseId{
//                    productInfo(productId: productId)
//                }
//            }
        }
        self.colList.reloadData()
        
    }
    
    func productInfo(productId : String){
        SVProgressHUD.show()
        SwiftyStoreKit.retrieveProductsInfo([productId]) { (result) in
            SVProgressHUD.dismiss()
            if let product = result.retrievedProducts.first{
                let productPricing = product.localizedPrice
                let productDescription = product.localizedDescription
                let productTitle = product.localizedTitle
                
                let alertVC = UIAlertController(title: productTitle, message: "\(productDescription) - \(productPricing!)", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                let okAction = UIAlertAction(title: "Buy", style: .default) { (action) in
                    self.purchaseProduct(productId: productId)
                }
                alertVC.addAction(cancelAction)
                alertVC.addAction(okAction)
                self.present(alertVC, animated: true, completion: nil)
               
//                self.validateSubscription()
            }
            else if let invalidProductId = result.invalidProductIDs.first{
                print("Invalid Product Id : \(invalidProductId)")
            }else{
                print("Error : \(result.error?.localizedDescription)")
            }
        }
    }
    
    
    func purchaseProduct(productId : String){
        SVProgressHUD.show()
        SwiftyStoreKit.purchaseProduct(productId) { (result) in
            SVProgressHUD.dismiss()
            switch result{
            case .success(let product):
                print("Purchase Successfull : \(product.productId)")
                UserDefaults.standard.set(true, forKey: product.productId)
            case .error(let error):
                print("Purchase Failed : \(error)")
            }
        }
        
//        SwiftyStoreKit.purchaseProduct(productId, quantity: 1, atomically: true) { (result) in
//            switch result{
//            case .success(let product):
//                print("Purchase Successfull : \(product.productId)")
//            case .error(let error):
//                print("Purchase Failed : \(error)")
//            }
//        }
    }
    
    func validateSubscription() {
        let appleValidator = AppleReceiptValidator(service: .sandbox, sharedSecret: "8e24def45fd249f29db28c77e4b1df35")
        SwiftyStoreKit.verifyReceipt(using: appleValidator , forceRefresh: false) { result in
            switch result {
            case .success(let receipt):
//                 Verify the purchase of a Subscription
                let purchaseResult = SwiftyStoreKit.verifyPurchase(productId: "com.dentalyear.testNonConsumable", inReceipt: receipt)
                switch purchaseResult {
                case .purchased(let receiptItem):
                    print("\("com.dentalyear.video42") is purchased: \(receiptItem)")
                case .notPurchased:
                    print("The user has never purchased \("com.dentalyear.video42")")
                }
                
//                let purchaseResult = SwiftyStoreKit.verifySubscriptions(ofType: .autoRenewable, productIds: self.productIds, inReceipt: receipt, validUntil: Date())
//
//                switch purchaseResult {
//                case .purchased(let expiryDate, let items):
//                    print(" is valid until \(expiryDate)\n\(items)\n")
//                    if let aSubscriptionOk = self.subscriptionOk
//                    {
//                        aSubscriptionOk()
//                    }
//                case .expired(let expiryDate, let items):
//                    print(" is expired since \(expiryDate)\n\(items)\n")
//                    if let aSubscriptionExpired = self.subscriptionExpired
//                      {
//                          aSubscriptionExpired()
//                      }
//                case .notPurchased:
//                    print("The user has never purchased ")
//                    if let aSubscriptionExpired = self.subscriptionExpired
//                    {
//                        aSubscriptionExpired()
//                    }
//                }

            case .error(let error):
                    print("Receipt verification failed: \(error)")
            }
        }
    }
    
    func loadData()  {
        if ((PINCache.shared().object(forKey: "video")) != nil)
        {
            videoObject = PINCache.shared().object(forKey: "video") as? VideoBaseObject
            self.dataArray = videoObject!.getDataFor(category: self.videoCatType)
            self.selectedVideo = self.dataArray[0]
            self.configurePlayer(video: self.selectedVideo!)
            self.colList.reloadData()
        }else
        {
            fetchDataFromAPI()
        }
        
    }
    
    func fetchDataFromAPI(){
        let url = APHandler.shared.baseUrl + "video?per_page=100"
        let apiHandler:APHandler = APHandler.init()
        apiHandler.makeGetAPIRequest(url: url)
        apiHandler.didFinishSuccessfullyCallback = { response in
            let responseObject = response as? AFDataResponse<Any>
            self.videoObject = VideoBaseObject(json: JSON(responseObject?.data as Any))
            self.dataArray = self.videoObject!.getDataFor(category: self.videoCatType)
            if (self.dataArray.count == 0) {
                return
            }
            PINCache.shared().setObject(self.videoObject!, forKey: "video")
            self.selectedVideo = self.dataArray[0]
            self.configurePlayer(video: self.selectedVideo!)
            self.colList.reloadData()
        }
    }
    
    
    func selected(index:Int)  {
        self.selectedVideo = self.dataArray[index]
        print("Selected Video Url : \(self.selectedVideo?.videoLink)")
        configurePlayer(video: self.selectedVideo!)
    }
    
    func switchToFullScreen(isFullScreen:Bool)  {
        DispatchQueue.main.async {
            
            if (isFullScreen)
            {
                self.videoPlayer?.removeFromSuperview()
                self.view.addSubview(self.videoPlayer!)
                self.fullScreenbackgroundView.isHidden = false
                self.navigationController?.tabBarController?.tabBar.isHidden = true
                self.view.backgroundColor = UIColor.black
                self.view.bringSubviewToFront(self.fullScreenbackgroundView)
                self.view.bringSubviewToFront(self.videoPlayer!)
                self.videoPlayer!.snp.makeConstraints { (make) in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview()
                    make.left.equalTo(self.view).offset(0)
                    make.right.equalTo(self.view).offset(0)
                    make.height.equalTo(self.videoPlayer!.snp.width).multipliedBy(9.0/16.0).priority(750)
                }
            }else
            {
                self.videoPlayer?.removeFromSuperview()
                self.view.backgroundColor = UIColor.hexStringToUIColor(hex: "#65D5FF")

                self.viewVideoContainer.addSubview(self.videoPlayer!)
                self.fullScreenbackgroundView.isHidden = true
                self.navigationController?.tabBarController?.tabBar.isHidden = false

                self.view.sendSubviewToBack(self.fullScreenbackgroundView)
                self.videoPlayer!.snp.makeConstraints { (make) in
                    make.top.equalTo(self.viewVideoContainer).offset(0)
                    make.left.equalTo(self.viewVideoContainer).offset(5)
                    make.right.equalTo(self.viewVideoContainer).offset(-5)
                    make.height.equalTo(self.videoPlayer!.snp.width).multipliedBy(9.0/16.0).priority(750)
                }
            }
            
        }
    }
    
    
    func configurePlayer(video:VideoObject)
    {
        DispatchQueue.main.async {
            if self.videoPlayer != nil
            {
                self.videoPlayer?.prepareToDealloc()
            }
            let controlView:BMPlayerControlView = BMPlayerControlView()
            //        controlView.fullscreenButton.isHidden = true
            controlView.mainMaskView.backgroundColor = UIColor.clear
            controlView.fullScreenButtonPressed = {
                isFullScreen in
                self.switchToFullScreen(isFullScreen: isFullScreen)
            }
            self.videoPlayer = BMPlayer(customControllView: controlView)
            
            
            self.videoPlayer?.delegate = self
            //        self.videoPlayer!.playbackDelegate = self
            self.viewVideoContainer.addSubview(self.videoPlayer!)
             
            self.videoPlayer!.snp.makeConstraints { (make) in
                make.top.equalTo(self.viewVideoContainer).offset(0)
                make.left.equalTo(self.viewVideoContainer).offset(5)
                make.right.equalTo(self.viewVideoContainer).offset(-5)
                make.height.equalTo(self.videoPlayer!.snp.width).multipliedBy(9.0/16.0).priority(750)
            }
            self.videoPlayer?.layer.cornerRadius = 10
            self.videoPlayer?.layer.masksToBounds = true
            self.videoPlayer?.clipsToBounds = true
            var videoUrl: URL = URL(string: video.acf.videoLink)!
            let coverUrl: URL = URL(string: video.acf.thumbImage)!
            if video.localUrl != nil {
                videoUrl = URL(string: video.localUrl)!
            }
            let asset = BMPlayerResource(url: videoUrl,
                                         name: video.acf.videoTitle,cover: coverUrl )
            self.videoPlayer!.setVideo(resource: asset)
            
            self.lblTitle.text = video.videoTitle!
            self.lblDuration.text = "Duration: \(video.videoDuration!)"
        }
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension VideoViewController : BMPlayerDelegate{
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        print("Player State Did Change, Playing Status : \(state)")
        if videoCatType == .premium{
            if state == .playedToTheEnd{
                if let purchasedId = self.selectedVideo?.acf.purchaseId{
                    if UserDefaults.standard.bool(forKey: purchasedId){
                        print("Video is already purchased.")
                    }else{
                        player.pause()
//                        productInfo(productId: purchasedId)
                    }
                }
            }
        }
    }
    
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        
    }
    
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        
    }
    
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
//        if videoCatType == .premium{
//            if playing == true{
//                if let purchasedId = self.selectedVideo?.acf.purchaseId{
//                    if UserDefaults.standard.bool(forKey: purchasedId){
//                        print("Video is already purchased.")
//                    }else{
//                        player.pause()
//                        productInfo(productId: purchasedId)
//                    }
//                }
//            }
//        }
    }
    
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        
    }
}
