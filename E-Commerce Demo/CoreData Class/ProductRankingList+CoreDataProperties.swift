//
//  ProductRankingList+CoreDataProperties.swift
//  E-CommerceDemo
//
//  Created by Mohit CCT on 21/01/19.
//  Copyright © 2019 Mohit. All rights reserved.
//
//

import Foundation
import CoreData

extension ProductRankingList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductRankingList> {
        return NSFetchRequest<ProductRankingList>(entityName: "ProductRankingList")
    }

    @NSManaged public var productId: Int64
    @NSManaged public var count: Int64
    @NSManaged public var productToRanking: NSSet?

}

// MARK: Generated accessors for productToRanking
extension ProductRankingList {

    @objc(addProductToRankingObject:)
    @NSManaged public func addToProductToRanking(_ value: RankingList)

    @objc(removeProductToRankingObject:)
    @NSManaged public func removeFromProductToRanking(_ value: RankingList)

    @objc(addProductToRanking:)
    @NSManaged public func addToProductToRanking(_ values: NSSet)

    @objc(removeProductToRanking:)
    @NSManaged public func removeFromProductToRanking(_ values: NSSet)

}
