//
//  ProfuctListVC.swift
//  E-CommerceDemo
//
//  Created by Mohit CCT on 21/01/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import UIKit

class ProductListVC: BaseViewController {

    @IBOutlet weak var varientTableView: UITableView!
    var subCategoryObj: CategoryList!
    var productObj: ProductList!
    var productVarientList = [ProductVarients]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.productObj.productName ?? ""
        self.varientTableView.register(UINib.init(nibName: "ProductListCell", bundle:nil), forCellReuseIdentifier: "ProductListCell")
        self.varientTableView.tableFooterView = UIView(frame: .zero)
        self.varientTableView.estimatedRowHeight = 500.0
        self.varientTableView.rowHeight = UITableView.automaticDimension
        self.varientTableView.separatorStyle = .none
        self.setNavigationButton()
        self.fetchVarientsList()
    }
    func fetchVarientsList() {        
        self.productVarientList = productObj.productToVarient?.allObjects as! [ProductVarients]
        self.varientTableView.reloadData()
    }

}
extension ProductListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productVarientList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let productListCell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell") as? ProductListCell
        
        let productVarient = self.productVarientList[indexPath.row]
        
        var sizeStr = "\(productVarient.varientSize)"
        if sizeStr.count == 0 {
            sizeStr = "--"
        }
        productListCell?.sizeLabel.text = "Size: \(sizeStr)"
        
        var colorStr = "\(productVarient.varientColor ?? "")"
        if colorStr.count == 0 {
            colorStr = "--"
        }
        productListCell?.colorLabel.text = "Color: \(colorStr)"
        
        var productPrice = "\(productVarient.varientPrice)"
        if productPrice.count == 0 {
            productPrice = "0"
        }
        productListCell?.priceLabel.text = "Price: \(productPrice)"
        
        var taxValue = "\(productObj.taxValue)"
        if taxValue.count == 0 {
            taxValue = "0"
        }
        let taxAmount = (productVarient.varientPrice * productObj.taxValue) / 100.0
        productListCell?.taxLabel.text = "Tax (\(productObj.taxName ?? ""): \(taxValue)%): \(taxAmount)"
        
        let totalAmount = productVarient.varientPrice + taxAmount
        productListCell?.totalLabel.text = "Total: \(totalAmount)"
        
        productListCell?.selectionStyle = .none
        return productListCell!
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
