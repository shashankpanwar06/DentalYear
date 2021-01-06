//
//  DVideoPlayer.swift
//  DentalYear
//
//  Created by Globizserve on 11/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit

class DVideoPlayer: BMPlayer {
    
    override func storyBoardCustomControl() -> BMPlayerControlView? {
        let controlView:BMPlayerControlView = BMPlayerControlView()
        
        controlView.fullscreenButton.isHidden = true


        
        return controlView

    }

}
