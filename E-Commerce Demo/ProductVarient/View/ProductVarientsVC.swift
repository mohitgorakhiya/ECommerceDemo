//
//  ProductVarientsVC.swift
//  E-CommerceDemo
//
//  Created by Mohit Gorakhiya on 1/20/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import UIKit

class ProductVarientsVC: BaseViewController {
    
    var selectedIndex: Int = 0
    @IBOutlet weak var varientTableView: UITableView!
    var categoryObj: CategoryList!
    var productsArray = [ProductList]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = self.categoryObj.categoryName ?? ""
        self.varientTableView.register(UINib.init(nibName: "CategoryCell", bundle:nil), forCellReuseIdentifier: "CategoryCell")
        self.varientTableView.tableFooterView = UIView(frame: .zero)
        self.varientTableView.estimatedRowHeight = 500.0
        self.varientTableView.rowHeight = UITableView.automaticDimension
        self.setNavigationButton()
        self.fetchProductVarientsData()
    }
    func fetchProductVarientsData() {
        
        self.productsArray = self.categoryObj.categoryToProduct?.allObjects as! [ProductList]
        self.varientTableView.reloadData()
        
    }
}
extension ProductVarientsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell
        
        let productObj = self.productsArray[indexPath.row]
        
        let productNameAttributedStr = NSMutableAttributedString.init(string: productObj.productName ?? "")
        productNameAttributedStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 17.0), range: NSRange.init(location: 0, length: productNameAttributedStr.length))
        productNameAttributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange.init(location: 0, length: productNameAttributedStr.length))
        
        let varientAttributedStr = NSMutableAttributedString.init(string: "  varients (\(productObj.productToVarient?.count ?? 0))")
        varientAttributedStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 13.0), range: NSRange.init(location: 0, length: varientAttributedStr.length))
        varientAttributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.darkGray, range: NSRange.init(location: 0, length: varientAttributedStr.length))
        productNameAttributedStr.append(varientAttributedStr)
        categoryCell?.categoryLabel.text = ""
        categoryCell?.categoryLabel.attributedText = productNameAttributedStr
        
        return categoryCell!
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let productListVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductListVC") as! ProductListVC
        productListVC.productObj = self.productsArray[indexPath.row]
        productListVC.subCategoryObj = self.categoryObj
        self.navigationController?.pushViewController(productListVC, animated: true)

    }
}
