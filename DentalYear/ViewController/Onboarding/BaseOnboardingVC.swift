//
//  BaseOnboardingVC.swift
//  DentalYear
//
//  Created by Shashank Panwar on 20/01/22.
//  Copyright © 2022 Globizserve. All rights reserved.
//

import UIKit

class BaseOnboardingVC: UIViewController {
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextBtn: UIButton!{
        didSet{
            nextBtn.layer.cornerRadius = 25
            nextBtn.layer.masksToBounds = true
        }
    }
    
    var pageViewController : PageVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        if let index = pageViewController?.currentIndex{
            switch index{
            case 0...1:
                pageViewController?.forwardPage()
            case 2:
                //Proceed to subscription Screen
                print("Proceed to next one")
                let storyBoard:UIStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
               guard let tabBarController:SubscriptionViewController = storyBoard.instantiateViewController(withIdentifier: "SubscriptionViewController") as? SubscriptionViewController else {return}
               AppDelegate().sharedInstance().window?.rootViewController = tabBarController
               AppDelegate().sharedInstance().window!.makeKeyAndVisible()
            default:
                break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PageVC{
            pageViewController = destination
            pageViewController?.pageVCDelegate = self
        }
        
    }

}
extension BaseOnboardingVC : PageVCDelegate{
    func didUpdatePageIndex(currentIndex: Int) {
        pageControl.currentPage = currentIndex
        switch currentIndex {
        case 0...1:
            nextBtn.setTitle("Next", for: .normal)
        case 2:
            nextBtn.setTitle("Get Started", for: .normal)
        default:
            break
        }
    }
}
