//
//  SubscriptionCell.swift
//  DentalYear
//
//  Created by Globizserve on 21/08/2020.
//  Copyright © 2020 Globizserve. All rights reserved.
//

import UIKit

class SubscriptionCell: UICollectionViewCell {
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var imgTooth: UIImageView!
    
    @IBOutlet weak var lblDiscount: UILabel!
    var items:[String] = [String]()
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.text = ""
        lblPrice.text = ""
        lblDuration.text = ""
        lblSubTitle.text = ""
        lblDiscount.text = ""
        innerView.layer.cornerRadius = 20
        innerView.layer.borderWidth = 3
        innerView.layer.borderColor = UIColor.hexStringToUIColor(hex: "#00a9ec").cgColor
        innerView.layer.masksToBounds = true
        innerView.clipsToBounds = true
        configureTable()
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        lblTitle.text = ""
        lblPrice.text = ""
        lblDuration.text = ""
        lblSubTitle.text = ""
        lblDiscount.text = ""
        items = [String]()
        tblList.reloadData()
        
    }
    func configureTable()
    {
        tblList.register(UINib.init(nibName: "SubscriptionListCell", bundle: Bundle.main), forCellReuseIdentifier: "SubscriptionListCell")
        tblList.delegate = self
        tblList.dataSource = self
        
    }
    func set(anitem:item)  {
        
        lblTitle.text = anitem.title
        if anitem.title == "MONTHLY PLAN"{
            if anitem.product != nil {
                lblPrice.text = "First Month Free, then \(anitem.product?.localizedPrice ?? anitem.price)/month"
            }else
            {
                lblPrice.text = "First Month Free, then \(anitem.price)/month"
            }
        }else if anitem.title == "ANNUAL PLAN"{
            if anitem.product != nil {
                lblPrice.text = "Two Months Free, then \(anitem.product?.localizedPrice ?? anitem.price)/month"
            }else
            {
                lblPrice.text = "Two Months Free, then \(anitem.price)/month"
            }
            
        }

//        lblDuration.text = anitem.Duration
        
        lblSubTitle.text = anitem.subtitle
        items = anitem.items
        imgTooth.image = UIImage(named: anitem.imageTooth)
        
        if anitem.discount != "" {
                    
            let attributedText : NSMutableAttributedString =  NSMutableAttributedString(string: anitem.discount)
            attributedText.addAttributes([
                NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.strikethroughColor: UIColor.hexStringToUIColor(hex: "#007AFF"),
                NSAttributedString.Key.font : UIFont(name: "MontserratBold", size: 17) ?? UIFont.systemFont(ofSize: 17)
                            ], range: NSMakeRange(0, attributedText.length))
            lblDiscount.attributedText = attributedText
        }else
        {
            lblDiscount.text = ""            
        }

        tblList.reloadData()
    }
}

extension SubscriptionCell:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell:SubscriptionListCell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionListCell", for: indexPath) as! SubscriptionListCell
        aCell.set(lbl: items[indexPath.row])
        return aCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
    
    
}
