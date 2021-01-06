//
//  SplashViewController.swift
//  DentalYear
//
//  Created by Globizserve on 13/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit

import Gifu

class SplashViewController: UIViewController {

    @IBOutlet weak var imgGif: GIFImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadGif()
//        MoveTotabBar()
    }
    
    func loadGif()  {
//        imgGif.prepareForAnimation(withGIFNamed: "splashlogo") {
//            self.imgGif
//            self.imgGif.startAnimatingGIF()
//        }
        
        imgGif.animate(withGIFNamed: "splashlogo", loopCount: 1) {
            print("Image Load")
        }
        self.checkPendigTrasnaction()

 
    }
    
    func checkPendigTrasnaction()  {
//        self.moveTotabbarAfter(delay: self.imgGif.gifLoopDuration)
//
//        return

        SubscriptionManager.shared.validateSubscription()
        SubscriptionManager.shared.subscriptionOk = {
            self.moveTotabbarAfter(delay: self.imgGif.gifLoopDuration)
        }
        SubscriptionManager.shared.subscriptionExpired = {
            self.moveTosubscription(delay: self.imgGif.gifLoopDuration)
        }
    }
    
    func moveTosubscription(delay:Double)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.MoveToSubscription()
        }
    }
    func moveTotabbarAfter(delay:Double)
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.MoveTotabBar()
        }
    }
    
    func MoveTotabBar()  {
         let storyBoard:UIStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        guard let tabBarController:DYTabBarViewController = storyBoard.instantiateViewController(withIdentifier: "DYTabBarViewController") as? DYTabBarViewController else {return}
        AppDelegate().sharedInstance().window?.rootViewController = tabBarController
        AppDelegate().sharedInstance().window!.makeKeyAndVisible()

    }
    
    func MoveToSubscription()  {
        
         let storyBoard:UIStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        guard let tabBarController:SubscriptionViewController = storyBoard.instantiateViewController(withIdentifier: "SubscriptionViewController") as? SubscriptionViewController else {return}
        AppDelegate().sharedInstance().window?.rootViewController = tabBarController
        AppDelegate().sharedInstance().window!.makeKeyAndVisible()

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
