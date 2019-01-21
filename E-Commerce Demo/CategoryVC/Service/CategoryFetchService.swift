//
//  CategoryFetchService.swift
//  E-Commerce Demo
//
//  Created by Mohit Gorakhiya on 1/20/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import SwiftyJSON
import CoreData

class CategoryFetchService {

    func fetchEcommerceDataFromService() -> Observable<Bool> {
        
        let requestURL: String = Constant.ECOMMERCEDATAAPI
        
        return Observable<Bool>.create { observer in
        RxAlamofire.requestJSON(.get,requestURL,encoding: JSONEncoding.default, headers:nil)
                .debug()
                .subscribe(onNext: { (r, json) in
                    
                    let jsonObj = JSON(json)                    
                    let categoryArray = jsonObj["categories"].arrayObject!
                    
                    let managedContext = CoreDataHelperInstance.sharedInstance.persistentContainer.viewContext

                    for i in 0..<categoryArray.count
                    {
                        let categoryDict = categoryArray[i] as! Dictionary<String, Any>

                        let categoryEntity = NSEntityDescription.entity(forEntityName: "CategoryList", in: managedContext)!
                        let categoryObj = NSManagedObject(entity: categoryEntity, insertInto: managedContext) as! CategoryList

                        let catgrID = categoryDict["id"] as! Int

                        let namePredicate = NSPredicate(format: "child_categories contains %ld", catgrID)
                        let nameFilter = categoryArray.filter { namePredicate.evaluate(with: $0) }
                        
                        categoryObj.categoryName = categoryDict["name"] as? String ?? ""
                        
                        categoryObj.categoryId = categoryDict["id"] as? Int64 ?? 0
                        if nameFilter.count > 0
                        {
                            let pcategoryDict = nameFilter[0] as! Dictionary<String, Any>
                            categoryObj.parentId = pcategoryDict["id"] as? Int64 ?? 0
                        }
                        else
                        {
                            categoryObj.parentId = 0
                        }
                        
                        let productArray = categoryDict["products"] as! Array<Any>
                        for productIndex in 0..<productArray.count
                        {
                            let productDict = productArray[productIndex] as! Dictionary<String, Any>
                            
                            let productEntity = NSEntityDescription.entity(forEntityName: "ProductList", in: managedContext)!
                            let productObj = NSManagedObject(entity: productEntity, insertInto: managedContext) as! ProductList
                            
                            productObj.productId = productDict["id"] as? Int64 ?? 0
                            productObj.productName = productDict["name"] as? String ?? ""
                            productObj.productDate = NSDate.init()
                            productObj.addToProductToCategory(categoryObj)
                            
                            let varientsArray = productDict["variants"] as! Array<Any>
                            for varientIndex in 0..<varientsArray.count
                            {
                                let varientDict = varientsArray[varientIndex] as! Dictionary<String, Any>
                                
                                let varientEntity = NSEntityDescription.entity(forEntityName: "ProductVarients", in: managedContext)!
                                let varientObj = NSManagedObject(entity: varientEntity, insertInto: managedContext) as! ProductVarients
                                
                                varientObj.varientId = varientDict["id"] as? Int64 ?? 0
                                varientObj.varientSize = varientDict["size"] as? Int64 ?? 0
                                varientObj.varientPrice = varientDict["price"] as? Double ?? 0.0
                                varientObj.varientColor = varientDict["color"] as? String ?? "White"
                                varientObj.addToVarientToProduct(productObj)
                            }
                            let taxDict = productDict["tax"] as! Dictionary<String, Any>

                            productObj.taxValue = taxDict["value"] as? Double ?? 0.0
                            productObj.taxName = taxDict["name"] as? String ?? ""
                        }
                        CoreDataHelperInstance.sharedInstance.saveContext()
                    }
                    
                    let rankingArray = jsonObj["rankings"].arrayObject!
                    for i in 0..<rankingArray.count
                    {
                        let rankDict = rankingArray[i] as! Dictionary<String, Any>
                        
                        let rankingEntity = NSEntityDescription.entity(forEntityName: "RankingList", in: managedContext)!
                        let rankingObj = NSManagedObject(entity: rankingEntity, insertInto: managedContext) as! RankingList
                        rankingObj.name = rankDict["ranking"] as? String ?? ""
                        
                        if rankingObj.name == "Most Viewed Products"
{
                            rankingObj.rankingKey = "view_count"
                            rankingObj.rankingName = "View Count"
                        }
                        else if rankingObj.name == "Most OrdeRed Products" {
                            rankingObj.rankingKey = "order_count"
                            rankingObj.rankingName = "Order Count"
                        }
                        else if rankingObj.name == "Most ShaRed Products" {
                            rankingObj.rankingKey = "shares"
                            rankingObj.rankingName = "Share Count"
                        }
                        
                        let productsArray = rankDict["products"] as! Array<Any>
                        for productIndex in 0..<productsArray.count {
                            
                            let productRankingEntity = NSEntityDescription.entity(forEntityName: "ProductRankingList", in: managedContext)!
                            let productRankingObj = NSManagedObject(entity: productRankingEntity, insertInto: managedContext) as! ProductRankingList
                            
                            let productDict = productsArray[productIndex] as! Dictionary<String, Any>
                            
                            productRankingObj.productId = productDict["id"] as? Int64 ?? 0
                            productRankingObj.count = productDict[rankingObj.rankingKey ?? ""] as? Int64 ?? 0
                            rankingObj.addToRankingToProducts(productRankingObj)
                        }
                        
                        CoreDataHelperInstance.sharedInstance.saveContext()
                    }
                    
                    observer.onNext(true)
                    observer.onCompleted()
                    
                }, onError: { error in
                    observer.onError(error)
                })
        }
    }
}
