//
//  DownlaodProgressCell.swift
//  DentalYear
//
//  Created by Globizserve on 20/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit
import PINCache
import Photos
class DownlaodProgressCell: UITableViewCell {
    
    lazy var session : URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.allowsCellularAccess = false
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        return session
    }()
    
    @IBOutlet weak var innerView: UIView!
    var task : URLSessionTask!
    var aVideo :VideoObject?
    @IBOutlet weak var lblDownloading: UILabel!
    @IBOutlet weak var progressDownload: UIProgressView!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    var downloadFinished:((_ url: String)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.text = ""
        lblDuration.text = ""
        lblDownloading.text = ""
        progressDownload.progress = 0
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        lblTitle.text = ""
        lblDuration.text = ""
        lblDownloading.text = ""
        progressDownload.progress = 0
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func set(video:VideoObject)  {
        aVideo = video
        innerView.layer.cornerRadius = 10
        lblTitle.text = video.videoTitle!
        lblDuration.text = video.videoDuration!
        downloadVideo(video: video)
    }
    func downloadVideo(video:VideoObject)  {
        
        
        lblDownloading.text = "0 %"
        progressDownload.setProgress(0, animated: true)
        if self.task != nil {
            return
        }
        let s = video.downloadVideoLink!
        let url = URL(string: s)!
        let req = URLRequest(url: url)
        let task = self.session.downloadTask(with: req)
        self.task = task
        task.resume()
        
        //        do {
        //
        //
        //            let downloadUrl:URL = URL(string: )!
        //            try downloadUrl.download(to: .documentDirectory, using: video.videoTitle!.trimmingCharacters(in: .whitespacesAndNewlines), overwrite: false, completion: { url, error in
        //                guard let url = url else { return }
        //
        //
        
        //
        //            })
        //
        //        } catch {
        //            print(error)
        //        }
        
    }
    
}
extension DownlaodProgressCell:URLSessionDownloadDelegate
{
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func checkAuthrization(url: URL)  {
        if  PHPhotoLibrary.authorizationStatus() == .notDetermined
        {
            PHPhotoLibrary.requestAuthorization { (status) in
                
                if status == .authorized
                {
                    self.saveTolocalPhoneStorageFrom(url: url)

                }else
                {
                    self.downloadFinished!(url.absoluteString)
                }
            
            }
        }else if (PHPhotoLibrary.authorizationStatus() == .restricted || PHPhotoLibrary.authorizationStatus() == .denied)
        {
            self.downloadFinished!(url.absoluteString)

            
        }else
        {
            saveTolocalPhoneStorageFrom(url: url)
            
        }
    }
    func saveTolocalPhoneStorageFrom(url: URL)  {
        
        DispatchQueue.global(qos: .background).async {
            if let urlData = NSData(contentsOf: url) {
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
                let filePath="\(documentsPath)/\(self.aVideo?.acf.videoTitle ?? "video").mp4"
                DispatchQueue.main.async {
                    urlData.write(toFile: filePath, atomically: true)
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
                    }) { completed, error in
                        if completed {
                            print("Video is saved!")
                            DispatchQueue.main.async {
                                self.downloadFinished!(url.absoluteString)
                            }

                        }else
                        {
                            DispatchQueue.main.async {
                                self.downloadFinished!(url.absoluteString)
                            }
                        }
                    }
                }
            }
        }
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        
        print("File Downloaded Location- ",  location)
        
        guard let url = downloadTask.originalRequest?.url else {
            return
        }
        let docsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        
        let videoName = "\(self.aVideo?.videoTitle.replacingOccurrences(of: " ", with: "") ?? self.randomString(length: 30)).mp4" 
        let destinationPath = docsPath.appendingPathComponent(videoName)
        
        try? FileManager.default.removeItem(at: destinationPath)
        
        do{
            try FileManager.default.copyItem(at: location, to: destinationPath)
            
            let videoObject:VideoBaseObject = (PINCache.shared().object(forKey: "video") as? VideoBaseObject)!
            var aDataArray:[VideoObject] = videoObject.dataArray!
            for (index,aVideo) in aDataArray.enumerated()
            {
                if aVideo.downloadVideoLink! == self.aVideo!.downloadVideoLink!
                {
                    aVideo.localUrl  = destinationPath.absoluteString
                    aDataArray[index] = aVideo
                    videoObject.dataArray = aDataArray
                    PINCache.shared().setObject(videoObject, forKey: "video")
                }
            }
            self.checkAuthrization(url: destinationPath)
            
        }catch let error {
            self.lblDownloading.text = error.localizedDescription
            print("Copy Error: \(error.localizedDescription)")
        }
        
        
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        if totalBytesExpectedToWrite > 0 {
            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            
            DispatchQueue.main.async {
                let currentProgress = progress * 100
                self.lblDownloading.text = String(format: "%.2f %", currentProgress)
                
                self.progressDownload.setProgress(progress, animated: true)
                
            }
        }
        
    }
    
}
