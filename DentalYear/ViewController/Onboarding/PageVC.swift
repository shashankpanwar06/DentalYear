//
//  PageVCViewController.swift
//  DentalYear
//
//  Created by Shashank Panwar on 20/01/22.
//  Copyright © 2022 Globizserve. All rights reserved.
//

import UIKit

protocol PageVCDelegate : AnyObject{
    func didUpdatePageIndex(currentIndex : Int)
}

class PageVC : UIPageViewController {
    
    lazy var viewControllerList : [UIViewController] = {
       let storyboard = UIStoryboard(name: "Onboading", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "FirstOnboardingVC")
        let vc2 = storyboard.instantiateViewController(withIdentifier: "SecondOnboardingVC")
        let vc3 = storyboard.instantiateViewController(withIdentifier: "ThirdOnboardingVC")
        return [vc1,vc2,vc3]
    }()
    
    var currentIndex = 0
    
    weak var pageVCDelegate : PageVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
        
        
        if let firstViewController = viewControllerList.first{
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func forwardPage(){
        self.currentIndex += 1
        let nextViewController = viewControllerList[currentIndex]
        self.setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        pageVCDelegate?.didUpdatePageIndex(currentIndex: self.currentIndex)
    }
}

extension PageVC : UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.firstIndex(of: viewController) else{return nil}
        print("Current VC Index for Before: \(vcIndex)")
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard viewControllerList.count > previousIndex else {return nil}
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.firstIndex(of: viewController) else {return nil}
        print("Current VC Index for After: \(vcIndex)")
        let nextIndex = vcIndex + 1
        guard nextIndex != viewControllerList.count else {return nil}
        guard viewControllerList.count > nextIndex else {return nil}
        return viewControllerList[nextIndex]
    }
}

extension PageVC : UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed{
            guard let vcIndex = viewControllerList.firstIndex(of: (pageViewController.viewControllers?.first)!) else {return}
            currentIndex = vcIndex
            pageVCDelegate?.didUpdatePageIndex(currentIndex: vcIndex)
        }
    }
}
