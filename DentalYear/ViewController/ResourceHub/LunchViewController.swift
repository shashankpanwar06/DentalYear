//
//  LunchViewController.swift
//  DentalYear
//
//  Created by Kirti Ahlawat on 18/07/21.
//  Copyright © 2021 Globizserve. All rights reserved.
//

import UIKit
import AVKit

class LunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/dentalyear-vcl.appspot.com/o/Lunch%26Learn%2FVideo%2FDentalYearLunchAndLearnWithOutSponsorPlug_v01%20(1)%20(1)%20(1).mp4?alt=media&token=c2ad975e-0f98-43e5-afbd-67254f646867")
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func LunchLearnBtnPressed(_ sender: UIButton) {
        guard let url = URL(string: "https://dentainment.zoom.us/s/85647327877#success") else { return }
        UIApplication.shared.open(url)
    }
    
}
