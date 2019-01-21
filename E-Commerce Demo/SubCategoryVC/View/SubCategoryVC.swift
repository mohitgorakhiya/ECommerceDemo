//
//  SubCategoryVC.swift
//  E-CommerceDemo
//
//  Created by Mohit Gorakhiya on 1/20/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import UIKit

class SubCategoryVC: BaseViewController {

    var selectedIndex: Int = 0
    @IBOutlet weak var subCategoryTableView: UITableView!
    var categoryObj: CategoryList!
    var subCategoryArray = [CategoryList]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = self.categoryObj.categoryName ?? ""
        self.subCategoryTableView.register(UINib.init(nibName: "CategoryCell", bundle:nil), forCellReuseIdentifier: "CategoryCell")
        self.subCategoryTableView.tableFooterView = UIView(frame: .zero)
        self.subCategoryTableView.estimatedRowHeight = 500.0
        self.subCategoryTableView.rowHeight = UITableView.automaticDimension
        self.setNavigationButton()
        self.fetchSubCategoryData()
    }
    func fetchSubCategoryData() {
        
        let predicate = NSPredicate.init(format: "parentId==%ld", categoryObj.categoryId)
        self.subCategoryArray = CoreDataHelperInstance.sharedInstance.fetchDataFrom(entityName: "CategoryList", sorting: false, predicate: predicate) as! [CategoryList]
        self.subCategoryTableView.reloadData()
    }
}
extension SubCategoryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subCategoryArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell
        
        let categoryObj = self.subCategoryArray[indexPath.row]
        
        categoryCell?.categoryLabel.text = categoryObj.categoryName
        
        return categoryCell!
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let categoryObj = self.subCategoryArray[indexPath.row]
        
        if categoryObj.categoryToProduct?.count == 0 {
            
            let subCategoryVC = self.storyboard?.instantiateViewController(withIdentifier: "SubCategoryVC") as! SubCategoryVC
            subCategoryVC.categoryObj = categoryObj
            self.navigationController?.pushViewController(subCategoryVC, animated: true)
            
        }
        else {
            
            let productVarientsVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductVarientsVC") as! ProductVarientsVC
            productVarientsVC.categoryObj = categoryObj
            self.navigationController?.pushViewController(productVarientsVC, animated: true)
            
        }
    }
}
