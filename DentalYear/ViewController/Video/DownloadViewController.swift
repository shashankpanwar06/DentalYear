//
//  DownloadViewController.swift
//  DentalYear
//
//  Created by Globizserve on 20/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit
import PINCache
import Photos

class DownloadViewController: UIViewController {

    var playBtnPressed:((_ video: VideoObject)->Void)?

    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var innerHeader: UIView!
    @IBOutlet weak var viewheader: UIView!
    var dataArray:[VideoObject] = [VideoObject]()
    
    var videoToDownload:VideoObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loadData()
        configureTable()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()

    }
    func configure()  {
        innerHeader.makeRoundCorner()
        
    }
    func loadData()  {
        dataArray = [VideoObject]()
        let videoObject:VideoBaseObject = (PINCache.shared().object(forKey: "video") as? VideoBaseObject)!
        let anArray:[VideoObject] = videoObject.dataArray!
        for video in anArray
        {
            if video.localUrl != nil {
                dataArray.append(video)
            }
        }
        tblList.reloadData()
    }
    func downloadFinished(url:String)  {
 
        videoToDownload?.localUrl = url
        loadData()
    }
    func configureTable()  {
        tblList.register(UINib.init(nibName: "DownlaodProgressCell", bundle: Bundle.main), forCellReuseIdentifier: "DownlaodProgressCell")
        tblList.register(UINib.init(nibName: "DownloadedCell", bundle: Bundle.main), forCellReuseIdentifier: "DownloadedCell")

        
        tblList.delegate = self
        tblList.dataSource = self
        tblList.reloadData()
        
    }
    @IBAction func onBtnback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func play(video:VideoObject)  {
        playBtnPressed!(video)
        self.navigationController?.popViewController(animated: true)
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
