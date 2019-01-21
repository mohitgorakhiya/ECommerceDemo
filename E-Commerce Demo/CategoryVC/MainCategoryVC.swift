//
//  MainCategoryVC.swift
//  E-Commerce Demo
//
//  Created by Mohit Gorakhiya on 1/20/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import RxSwift
import SwiftyJSON
import CoreData

class MainCategoryVC: BaseViewController {
    
    @IBOutlet weak var segmentView: RadiusView!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var rankingButton: UIButton!
    @IBOutlet weak var mainCategoryTable: UITableView!
    let categoryViewModel = CategoryViewModel(CategoryFetchService())
    var categoryArray = [CategoryList]()
    var rankingArray = [RankingList]()
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Heady Shopping"
        self.mainCategoryTable.register(UINib.init(nibName: "CategoryCell", bundle:nil), forCellReuseIdentifier: "CategoryCell")
        self.mainCategoryTable.tableFooterView = UIView(frame: .zero)
        self.mainCategoryTable.estimatedRowHeight = 500.0
        self.mainCategoryTable.rowHeight = UITableView.automaticDimension
        
        self.categoryButton.setTitleColor(UIColor.white, for: .normal)
        self.categoryButton.backgroundColor = Constant.navigationColor
        
        self.rankingButton.setTitleColor(Constant.navigationColor, for: .normal)
        self.rankingButton.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchEcommerceDataFromService()
    }
    
    @IBAction func segmentClicked(_ sender: UIButton) {
        
        if sender.tag == 0 {
            self.categoryButton.setTitleColor(UIColor.white, for: .normal)
            self.categoryButton.backgroundColor = Constant.navigationColor
            
            self.rankingButton.setTitleColor(Constant.navigationColor, for: .normal)
            self.rankingButton.backgroundColor = UIColor.white
        }
        else {
            self.rankingButton.setTitleColor(UIColor.white, for: .normal)
            self.rankingButton.backgroundColor = Constant.navigationColor
            
            self.categoryButton.setTitleColor(Constant.navigationColor, for: .normal)
            self.categoryButton.backgroundColor = UIColor.white
        }
        selectedIndex = sender.tag
        self.mainCategoryTable.reloadData()
    }
    func fetchEcommerceDataFromService() {
        
        if UserDefaults.standard.bool(forKey: Constant.isDataSavedToLocal) {
            self.fetchDataFromLocal()
        }
        else {
            if (Connectivity.isConnectedToInternet()) {
                self.showLoading()
                categoryViewModel.fetchEcommerceDataFromService()
                    
                    .subscribe(onNext: { isSuccess in
                        self.hideLoading()
                        if isSuccess {
                            UserDefaults.standard.set(true, forKey: Constant.isDataSavedToLocal)
                            UserDefaults.standard.synchronize()
                            
                            DispatchQueue.main.async {
                                self.fetchDataFromLocal()
                            }
                        }
                        
                        
                    }, onError: { error in
                        self.hideLoading()
                        print("oh error occurred ! \(error.localizedDescription)")
                    })
            }
            else
            {
                self.hideLoading()
                self.showAlert(msg: "No internet connection", completion: nil)
            }
        }
    }
    func fetchDataFromLocal() {
        
        let predicate = NSPredicate.init(format: "parentId==%ld", 0)
        self.categoryArray = CoreDataHelperInstance.sharedInstance.fetchDataFrom(entityName: "CategoryList", sorting: false, predicate: predicate) as! [CategoryList]
        
        self.rankingArray = CoreDataHelperInstance.sharedInstance.fetchDataFrom(entityName: "RankingList", sorting: false, predicate: nil) as! [RankingList]
        
        self.mainCategoryTable.reloadData()
        
    }
}
extension MainCategoryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if selectedIndex == 0 {
            return self.categoryArray.count
        }
        else {
            return self.rankingArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell
        
        if selectedIndex == 0 {
            let categoryObj = self.categoryArray[indexPath.row]
            categoryCell?.categoryLabel.text = categoryObj.categoryName
        }
        else {
            let rankingObj = self.rankingArray[indexPath.row]
            categoryCell?.categoryLabel.text = rankingObj.name
        }
        return categoryCell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if selectedIndex == 0 {
            let subCategoryVC = self.storyboard?.instantiateViewController(withIdentifier: "SubCategoryVC") as! SubCategoryVC
            let categoryObj = self.categoryArray[indexPath.row]
            subCategoryVC.categoryObj = categoryObj
            self.navigationController?.pushViewController(subCategoryVC, animated: true)
        }
        else {
            let productRankingVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductRankingVC") as! ProductRankingVC
            productRankingVC.rankingObj = self.rankingArray[indexPath.row]
            self.navigationController?.pushViewController(productRankingVC, animated: true)
        }
    }
}
