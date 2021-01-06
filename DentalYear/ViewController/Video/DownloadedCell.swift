//
//  DownloadedCell.swift
//  DentalYear
//
//  Created by Globizserve on 20/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit

class DownloadedCell: UITableViewCell {
    var playBtnPressed:((_ video: VideoObject)->Void)?

    @IBOutlet weak var viewInner: UIView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    var aVideoObject:VideoObject?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.text = ""
        lblDuration.text = ""
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        lblTitle.text = ""
        lblDuration.text = ""
        
    }
    func set(video:VideoObject)  {
        
        viewInner.layer.cornerRadius = 10

        self.aVideoObject = video

        lblTitle.text = video.videoTitle!
        lblDuration.text = "Duration: \(video.videoDuration!)"
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onBtnPlay(_ sender: Any) {
        playBtnPressed!(self.aVideoObject!)

    }
    
}
