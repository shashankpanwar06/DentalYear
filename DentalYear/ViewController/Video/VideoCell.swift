//
//  VideoCell.swift
//  DentalYear
//
//  Created by Globizserve on 11/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit
import SDWebImage

class VideoCell: UICollectionViewCell {
    
    var downloadBtnPressed:((_ video: VideoObject)->Void)?


    var aVideoObject:VideoObject?
    @IBOutlet weak var btnDownLoad: UIButton!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgBottome: UIImageView!
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var viewContainer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.text = ""
        lblDuration.text = ""
        imgThumbnail.image = UIImage.init()
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        lblTitle.text = ""
        lblDuration.text = ""
        imgThumbnail.image = UIImage.init()
    }
    
    func set(video:VideoObject)  {
        self.layoutIfNeeded()
        self.aVideoObject = video
        viewContainer.layer.cornerRadius = 25
        viewContainer.layer.masksToBounds = true
        viewContainer.clipsToBounds = true
        imgThumbnail.sd_setImage(with: URL(string: video.acf.thumbImage), placeholderImage: UIImage.init())
        lblTitle.text = video.acf.videoTitle
        lblDuration.text = "Duration: \(video.acf.duration ?? "")"

    }

    @IBAction func onBtnDownlaod(_ sender: Any)
    {
        downloadBtnPressed!(self.aVideoObject!)
    }
}
