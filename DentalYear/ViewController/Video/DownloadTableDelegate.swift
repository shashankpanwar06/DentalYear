//
//  DownloadTableDelegate.swift
//  DentalYear
//
//  Created by Globizserve on 20/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import Foundation
import UIKit
extension DownloadViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        if videoToDownload == nil {
            return 1
        }
        if videoToDownload?.localUrl == nil {
            return 2
        }else
        {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if videoToDownload == nil {
            return self.dataArray.count
        }
        
        if videoToDownload?.localUrl == nil {
            if section == 0 {
                return 1
            }else
            {
                return self.dataArray.count
            }
        }else
        {
            return self.dataArray.count
        }


    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if videoToDownload == nil {
            return self.downloadCell(tableView, cellForRowAt: indexPath)
        }
        
        if videoToDownload?.localUrl == nil {
            if indexPath.section == 0 {
                return self.downloadProgressCell(tableView, cellForRowAt: indexPath)
            }else
            {
                  return self.downloadCell(tableView, cellForRowAt: indexPath)
            }
        }else
        {
             return self.downloadCell(tableView, cellForRowAt: indexPath)
        }



    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

            return 100
    }
    
    func downloadCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell:DownloadedCell = tableView.dequeueReusableCell(withIdentifier: "DownloadedCell", for: indexPath) as! DownloadedCell
        aCell.set(video: self.dataArray[indexPath.row])
        aCell.playBtnPressed = {
                      video in
                      self.play(video: video)
                  }
        return aCell
    }
    
    func downloadProgressCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let aCell:DownlaodProgressCell = tableView.dequeueReusableCell(withIdentifier: "DownlaodProgressCell", for: indexPath) as! DownlaodProgressCell
        aCell.set(video: self.videoToDownload!)
        aCell.downloadFinished = {url in
            self.downloadFinished(url: url)
        }
        return aCell
    }
    
}

extension URL {
    func download(to directory: FileManager.SearchPathDirectory, using fileName: String? = nil, overwrite: Bool = false, completion: @escaping (URL?, Error?) -> Void) throws {
        let directory = try FileManager.default.url(for: directory, in: .userDomainMask, appropriateFor: nil, create: true)
        let destination: URL
        if let fileName = fileName {
            destination = directory
                .appendingPathComponent(fileName)
                .appendingPathExtension(self.pathExtension)
        } else {
            destination = directory
            .appendingPathComponent(lastPathComponent)
        }
        if !overwrite, FileManager.default.fileExists(atPath: destination.path) {
            completion(destination, nil)
            return
        }
        URLSession.shared.downloadTask(with: self) { location, _, error in
            guard let location = location else {
                completion(nil, error)
                return
            }
            do {
                if overwrite, FileManager.default.fileExists(atPath: destination.path) {
                    try FileManager.default.removeItem(at: destination)
                }
                try FileManager.default.moveItem(at: location, to: destination)
                completion(destination, nil)
            } catch {
                print(error)
            }
        }.resume()
    }
}
