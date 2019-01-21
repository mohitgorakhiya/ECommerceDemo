//
//  ProductListCell.swift
//  E-CommerceDemo
//
//  Created by Mohit CCT on 21/01/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import UIKit

class ProductListCell: UITableViewCell {

    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var outerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()        
        self.outerView.layer.masksToBounds = true
        self.outerView.layer.borderColor = Constant.navigationColor.cgColor
        self.outerView.layer.borderWidth = 1.0
        self.outerView.layer.cornerRadius = 2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
