//
//  HomeCell.swift
//  DentalYear
//
//  Created by Globizserve on 08/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PINCache
import AVFoundation
class HomeCell: UITableViewCell {
    @IBOutlet weak var sliderAudio: UISlider!
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var viewAudio: UIView!
    @IBOutlet weak var viewSeprator: UIView!
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    @IBOutlet weak var imgHeight: NSLayoutConstraint!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var videoThumbnailImageView: UIImageView!
    
    var playBtnPressed:((_ videoURL : URL)->Void)?
    var sliderValueChanged:((_ value:Float)->Void)?
    let player:FRadioPlayer = FRadioPlayer.shared
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layoutIfNeeded()
        
        lblTitle.text = ""
        viewContainer.backgroundColor = .clear
        imgArrow.image = UIImage.init(named: "icArrowDownWhite")
        imgView.image = UIImage.init()
        lblDetails.text = ""
        lblDetails.isHidden = true
        sliderAudio.isUserInteractionEnabled = false
        
        //        viewSeprator.isHidden = false
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lblTitle.text = ""
        viewContainer.backgroundColor = .clear
        imgArrow.image = UIImage.init(named: "icArrowDownWhite")
        imgView.image = UIImage.init()
        lblDetails.text = ""
        lblDetails.isHidden = true
        //        viewSeprator.isHidden = false
        self.contentView.layoutIfNeeded()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCellFor(indexPath:IndexPath,type:CellType,data:HomeDataObject)  {
        //        viewSeprator.isHidden = true
        self.layoutIfNeeded()
        shareBtn.isHidden = true
//        imgArrow.isHidden = false
        
        lblTitle.text = type.rawValue
        imgView.image = HomeStaticdata.getUnselectedImageFor(cellType:type)
        self.contentView.backgroundColor = HomeStaticdata.getBackgroundColorFor(index: indexPath.row)
        viewContainer.backgroundColor = HomeStaticdata.getForgroundColorFor(index: indexPath.row)
        lblDetails.isHidden = true
        viewAudio.isHidden  = true
        viewContainer.makeRoundCorner()
//        if type ==  .kAdOfTheMonth{
//            lblTime.text = "00:00"
//            sliderAudio.value = 0.00
//            btnPlay.setImage(UIImage(named: "icPlayAudio"), for: .normal)
//            if player.isPlaying
//            {
//                btnPlay.setImage(UIImage(named: "icPlayAudio"), for: .normal)
//                player.pause()
//                return
//            }
//        }
        if type == .kAdOfTheMonth {
//            imgArrow.isHidden = true
            lblDetails.isHidden = true
            viewAudio.isHidden = false
            let url = APHandler.shared.baseUrl + "Audio"
            let apiHandler:APHandler = APHandler.init()
            apiHandler.makeGetAPIRequest(url: url, isSVProgressHudNeedToDisplay: false)
            apiHandler.didFinishSuccessfullyCallback = { response in
                
                let responseObject = response as? AFDataResponse<Any>
                let audioBaseObject = AudioBaseObject(json: JSON(responseObject?.data as Any))
                guard let dataArray:[AudioObject] = audioBaseObject.dataArray else {return}
                
                if dataArray.count < 1 {
                    return
                }
                let audioObject = dataArray[0]
        //        player.radioURL = URL(string: audioObject.acf.track)
                
                self.videoThumbnailImageView.sd_setImage(with: URL(string: audioObject.acf.videoThumbnail), placeholderImage: UIImage.init())
                
            }

            setupForAudio()
        }else
        {
            if player.isPlaying
            {
                btnPlay.setImage(UIImage(named: "icPlayAudio"), for: .normal)
                player.pause()
                return
            }
        }
        self.layoutIfNeeded()
    }
    
    func setupCellForSelected(indexPath:IndexPath,type:CellType,data:HomeDataObject)  {
        self.layoutIfNeeded()
        
        lblTitle.text = type.rawValue
        lblDetails.isHidden = false
        viewAudio.isHidden = true
        shareBtn.isHidden = true
        
        let img = HomeStaticdata.getSelectedImageFor(cellType:type)
        imgView.image = img
        //        imgHeight.constant = img.size.height
        imgArrow.image = UIImage.init(named: "icArrowUpWhite")
        self.contentView.backgroundColor = HomeStaticdata.getBackgroundColorFor(index: indexPath.row)
        viewContainer.backgroundColor = HomeStaticdata.getForgroundColorFor(index: indexPath.row)
        viewContainer.makeRoundCorner()
        viewAudio.makeAllRoundCorner()
        switch type {
        case .kHowToCelebrate:
            lblDetails.text = data.acf.howToCelebrate
        case .kDailyMarketingTip:
            lblDetails.text = data.acf.dailyMarketingTip
        case .kShareWithTeamMember:
            lblDetails.text = data.acf.sharewithTeamMember
            if !lblDetails.text!.isEmpty{
                shareBtn.isHidden = false
            }
        case .kDailyPost:
            lblDetails.text = data.acf.dailyPost
        case .kHowToMaximizePost:
            lblDetails.text = data.acf.howToMaximizePost
        case .kWeeklyMarketingExercise:
            lblDetails.text = data.acf.weeklyMarketingExercises
        case .kMarketingTrendsNews:
            lblDetails.text = data.acf.marketingTrendsNewsForTheDay
        case .kThisDateInHistory:
            lblDetails.text = data.acf.thisDateInHistory
        case .kIndustryEvents:
            lblDetails.text = data.acf.industryEvents
        case .kLookingAhead:
            lblDetails.text = data.acf.lookingAhead
        default:
            lblDetails.text = ""
        }
//        if type == .kAdOfTheMonth {
//            lblDetails.isHidden = true
//            viewAudio.isHidden = false
//            let url = APHandler.shared.baseUrl + "Audio"
//            let apiHandler:APHandler = APHandler.init()
//            apiHandler.makeGetAPIRequest(url: url)
//            apiHandler.didFinishSuccessfullyCallback = { response in
//
//                let responseObject = response as? AFDataResponse<Any>
//                let audioBaseObject = AudioBaseObject(json: JSON(responseObject?.data as Any))
//                guard let dataArray:[AudioObject] = audioBaseObject.dataArray else {return}
//
//                if dataArray.count < 1 {
//                    return
//                }
//                let audioObject = dataArray[0]
//        //        player.radioURL = URL(string: audioObject.acf.track)
//
//                self.videoThumbnailImageView.sd_setImage(with: URL(string: audioObject.acf.videoThumbnail), placeholderImage: UIImage.init())
//
//            }
//
//            setupForAudio()
//        }else
//        {
//            if player.isPlaying
//            {
//                btnPlay.setImage(UIImage(named: "icPlayAudio"), for: .normal)
//                player.pause()
//                return
//            }
//        }
//        self.layoutIfNeeded()
    }
    func setupForAudio()  {
        btnPlay.setImage(UIImage(named: "icPlayAudio"), for: .normal)

        lblTime.text = "00:00"
        sliderAudio.setThumbImage(UIImage(named: "sliderImage"), for: .normal)
        sliderAudio.setThumbImage(UIImage(named: "sliderImage"), for: .highlighted)
        sliderAudio.value = 0.00
        
    }
    
    @IBAction func shareBtnPressed(_ sender: UIButton) {
        let objectsToShare = [lblDetails.text!] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        if (activityVC.popoverPresentationController != nil){
            activityVC.popoverPresentationController?.sourceView = self.superview
            activityVC.popoverPresentationController?.sourceRect = CGRect(x: self.superview?.frame.midX ?? 0, y: self.superview?.frame.midY ?? 0,width: 0,height: 0)
        }
        self.findViewController()?.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func onBtnPlay(_ sender: Any) {
        
        if player.isPlaying
        {
            sliderAudio.value = 0.00
            btnPlay.setImage(UIImage(named: "icPlayAudio"), for: .normal)
            player.pause()
            return
        }
        loadData()
        
    }
    
    @IBAction func onSliderValueChanged(_ sender: UISlider) {
        sliderValueChanged!(sender.value)
    }
    
    func loadData()  {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: now)
        
//        if ((PINCache.shared().object(forKey: nameOfMonth)) != nil)
//        {
//            guard let audioBaseObject:AudioBaseObject = PINCache.shared().object(forKey: nameOfMonth) as? AudioBaseObject else {return}
//            self.PlayAudio(baseObject: audioBaseObject)
//        }else
//        {
            let url = APHandler.shared.baseUrl + "Audio"
            let apiHandler:APHandler = APHandler.init()
            apiHandler.makeGetAPIRequest(url: url)
            apiHandler.didFinishSuccessfullyCallback = { response in
                
                let responseObject = response as? AFDataResponse<Any>
                let audioBaseObject = AudioBaseObject(json: JSON(responseObject?.data as Any))
                self.PlayAudio(baseObject: audioBaseObject)
                PINCache.shared().setObject(audioBaseObject, forKey: nameOfMonth)
            }
//        }
        
    }
    
    func PlayAudio(baseObject:AudioBaseObject)  {
        
        player.delegate = self
        guard let dataArray:[AudioObject] = baseObject.dataArray else {return}
        
        if dataArray.count < 1 {
            return
        }
        let audioObject = dataArray[0]
//        player.radioURL = URL(string: audioObject.acf.track)
        playBtnPressed!(URL(string: audioObject.acf.videourl)!)
        videoThumbnailImageView.sd_setImage(with: URL(string: audioObject.acf.videoThumbnail), placeholderImage: UIImage.init())
        
//        player.totalAudioDuration = {
//            duration in
//            self.lblTime.text = "\(duration)"
//        }
//        player.currentTimeAudio = {
//            time in
//            self.sliderAudio.setValue(Float(time), animated: true)
//        }
//        player.play()
        btnPlay.setImage(UIImage(named: "icPauseAudio"), for: .normal)
    }
    
    
    
    
}

extension HomeCell:FRadioPlayerDelegate
{
    func radioPlayer(_ player: FRadioPlayer, playerStateDidChange state: FRadioPlayerState) {
        
    }
    
    func radioPlayer(_ player: FRadioPlayer, playbackStateDidChange state: FRadioPlaybackState) {
        
    }
    func radioPlayer(_ player: FRadioPlayer, metadataDidChange rawValue: String?) {
        
    }
    
    
}
