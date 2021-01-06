//
//  SponsorTableDelegate.swift
//  DentalYear
//
//  Created by Globizserve on 11/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import Foundation
import UIKit

extension SponsorsViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < self.dataArray.count  {
            let aCell:SposorCell = tableView.dequeueReusableCell(withIdentifier: "SposorCell", for: indexPath) as! SposorCell
            aCell.set(sponsor: self.dataArray[indexPath.row])
            return aCell
        }else
        {
            let aCell:WantHereCell = tableView.dequeueReusableCell(withIdentifier: "WantHereCell", for: indexPath) as! WantHereCell
            aCell.setUp()
            aCell.wantHereBtnPressed = {
                self.onBtnWantHere()
            }
            return aCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < self.dataArray.count  {
            return 120
        }else
        {
            return 155
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < self.dataArray.count  {
            self.selected(index: indexPath.row)

        }
    }
    
}
