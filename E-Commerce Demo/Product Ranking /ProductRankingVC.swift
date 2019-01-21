//
//  ProductRankingVC.swift
//  E-CommerceDemo
//
//  Created by Mohit CCT on 21/01/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import UIKit

class ProductRankingVC: BaseViewController {

    @IBOutlet weak var productTableView: UITableView!
    var rankingObj: RankingList!
    var productsArray = [ProductList]()
    var productRankingArray = [ProductRankingList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.rankingObj.name ?? "Ranking"
        self.productTableView.register(UINib.init(nibName: "ProductRankingCell", bundle:nil), forCellReuseIdentifier: "ProductRankingCell")
        self.productTableView.tableFooterView = UIView(frame: .zero)
        self.productTableView.estimatedRowHeight = 500.0
        self.productTableView.rowHeight = UITableView.automaticDimension
        self.setNavigationButton()
        self.fetchRelatedProductList()
    }
    func fetchRelatedProductList() {
        
        self.productRankingArray = self.rankingObj.rankingToProducts?.allObjects as! [ProductRankingList]
        
        for i in 0..<productRankingArray.count {
            
            let productRank = productRankingArray[i]
            let relatedProducts = CoreDataHelperInstance.sharedInstance.fetchDataFrom(entityName: "ProductList", sorting: true, predicate: NSPredicate.init(format: "productId==%ld", productRank.productId)) as! [ProductList]
            
            if relatedProducts.count > 0 {
                self.productsArray.append(relatedProducts[0])
            }
        }
        
        self.productTableView.reloadData()
    }
}
extension ProductRankingVC: UITableViewDelegate, UITableViewDataSource {
    
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
        
        let productListCell = tableView.dequeueReusableCell(withIdentifier: "ProductRankingCell") as? ProductRankingCell
        
        productListCell?.countLabel.isHidden = false
        let productObj = self.productsArray[indexPath.row]
        
        let productNameAttributedStr = NSMutableAttributedString.init(string: productObj.productName ?? "")
        productNameAttributedStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 17.0), range: NSRange.init(location: 0, length: productNameAttributedStr.length))
        productNameAttributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange.init(location: 0, length: productNameAttributedStr.length))
        
        let varientAttributedStr = NSMutableAttributedString.init(string: "  varients (\(productObj.productToVarient?.count ?? 0))")
        varientAttributedStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 13.0), range: NSRange.init(location: 0, length: varientAttributedStr.length))
        varientAttributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.darkGray, range: NSRange.init(location: 0, length: varientAttributedStr.length))
        productNameAttributedStr.append(varientAttributedStr)
        
        productListCell?.productNameLabel.text = ""
        productListCell?.productNameLabel.attributedText = productNameAttributedStr
        
        var countValue: Int = 0
        let predicate = NSPredicate.init(format: "productId==%ld", productObj.productId)
        let filteredArray = self.productRankingArray.filter { predicate.evaluate(with: $0) }
        if filteredArray.count > 0 {
            let rankingProduct = filteredArray[0]
            countValue = Int(rankingProduct.count)
        }
        
        productListCell?.countLabel.text = "\(rankingObj.rankingName ?? "Count"): \(countValue)"
        
        let productDateStr = self.getDisplayStringFrom(productDate: productObj.productDate! as Date)
        productListCell?.dateLabel.text = "Date Added: \(productDateStr)"

        
        return productListCell!
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let productListVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductListVC") as! ProductListVC
        productListVC.productObj = self.productsArray[indexPath.row]
        productListVC.subCategoryObj = (productListVC.productObj.productToCategory?.allObjects[0] as! CategoryList)
        self.navigationController?.pushViewController(productListVC, animated: true)
    }
}
