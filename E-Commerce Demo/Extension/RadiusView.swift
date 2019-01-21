//
//  RadiusView.swift
//  E-Commerce Demo
//
//  Created by Mohit Gorakhiya on 1/20/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import UIKit

class RadiusView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.height / 2.0
        self.layer.borderColor = Constant.navigationColor.cgColor
        self.layer.borderWidth = 1.0
    }
    
}
