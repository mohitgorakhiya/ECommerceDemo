//
//  CategoryList+CoreDataProperties.swift
//  E-CommerceDemo
//
//  Created by Mohit Gorakhiya on 1/20/19.
//  Copyright © 2019 Mohit. All rights reserved.
//
//

import Foundation
import CoreData


extension CategoryList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryList> {
        return NSFetchRequest<CategoryList>(entityName: "CategoryList")
    }

    @NSManaged public var categoryId: Int64
    @NSManaged public var categoryName: String?
    @NSManaged public var parentId: Int64
    @NSManaged public var categoryToProduct: NSSet?

}

// MARK: Generated accessors for categoryToProduct
extension CategoryList {

    @objc(addCategoryToProductObject:)
    @NSManaged public func addToCategoryToProduct(_ value: ProductList)

    @objc(removeCategoryToProductObject:)
    @NSManaged public func removeFromCategoryToProduct(_ value: ProductList)

    @objc(addCategoryToProduct:)
    @NSManaged public func addToCategoryToProduct(_ values: NSSet)

    @objc(removeCategoryToProduct:)
    @NSManaged public func removeFromCategoryToProduct(_ values: NSSet)

}
