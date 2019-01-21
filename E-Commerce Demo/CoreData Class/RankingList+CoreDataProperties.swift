//
//  RankingList+CoreDataProperties.swift
//  E-CommerceDemo
//
//  Created by Mohit CCT on 21/01/19.
//  Copyright © 2019 Mohit. All rights reserved.
//
//

import Foundation
import CoreData


extension RankingList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RankingList> {
        return NSFetchRequest<RankingList>(entityName: "RankingList")
    }

    @NSManaged public var name: String?
    @NSManaged public var rankingKey: String?
    @NSManaged public var rankingName: String?
    @NSManaged public var rankingToProducts: NSSet?

}

// MARK: Generated accessors for rankingToProducts
extension RankingList {

    @objc(addRankingToProductsObject:)
    @NSManaged public func addToRankingToProducts(_ value: ProductRankingList)

    @objc(removeRankingToProductsObject:)
    @NSManaged public func removeFromRankingToProducts(_ value: ProductRankingList)

    @objc(addRankingToProducts:)
    @NSManaged public func addToRankingToProducts(_ values: NSSet)

    @objc(removeRankingToProducts:)
    @NSManaged public func removeFromRankingToProducts(_ values: NSSet)

}
