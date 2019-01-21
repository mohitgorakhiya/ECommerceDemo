//
//  BaseViewController.swift
//  E-CommerceDemo
//
//  Created by Mohit CCT on 21/01/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    func setNavigationButton() {
        
        self.navigationItem.hidesBackButton = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "backArrow"), style: .plain, target: self, action: #selector(backButtonClicked))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }

    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    func getDisplayStringFrom(productDate: Date) -> String {
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: productDate)
    }
}
