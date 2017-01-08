//
//  CustomCell.swift
//  teratail_61308
//
//  Created by Kentarou on 2017/01/08.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var data: DataModel! {
        didSet {
            countLabel.text = data.count
            priceLabel.text = data.price
        }
    }
}
