//
//  ProductList+CoreDataProperties.swift
//  E-CommerceDemo
//
//  Created by Mohit Gorakhiya on 1/20/19.
//  Copyright © 2019 Mohit. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductList> {
        return NSFetchRequest<ProductList>(entityName: "ProductList")
    }

    @NSManaged public var productDate: NSDate?
    @NSManaged public var productId: Int64
    @NSManaged public var productName: String?
    @NSManaged public var productToCategory: NSSet?
    @NSManaged public var productToTax: NSSet?
    @NSManaged public var productToVarient: NSSet?
    @NSManaged public var taxName: String?
    @NSManaged public var taxValue: Double
}

// MARK: Generated accessors for productToCategory
extension ProductList {

    @objc(addProductToCategoryObject:)
    @NSManaged public func addToProductToCategory(_ value: CategoryList)

    @objc(removeProductToCategoryObject:)
    @NSManaged public func removeFromProductToCategory(_ value: CategoryList)

    @objc(addProductToCategory:)
    @NSManaged public func addToProductToCategory(_ values: NSSet)

    @objc(removeProductToCategory:)
    @NSManaged public func removeFromProductToCategory(_ values: NSSet)

}

// MARK: Generated accessors for productToTax
extension ProductList {

    @objc(addProductToTaxObject:)
    @NSManaged public func addToProductToTax(_ value: TaxInfo)

    @objc(removeProductToTaxObject:)
    @NSManaged public func removeFromProductToTax(_ value: TaxInfo)

    @objc(addProductToTax:)
    @NSManaged public func addToProductToTax(_ values: NSSet)

    @objc(removeProductToTax:)
    @NSManaged public func removeFromProductToTax(_ values: NSSet)

}

// MARK: Generated accessors for productToVarient
extension ProductList {

    @objc(addProductToVarientObject:)
    @NSManaged public func addToProductToVarient(_ value: ProductVarients)

    @objc(removeProductToVarientObject:)
    @NSManaged public func removeFromProductToVarient(_ value: ProductVarients)

    @objc(addProductToVarient:)
    @NSManaged public func addToProductToVarient(_ values: NSSet)

    @objc(removeProductToVarient:)
    @NSManaged public func removeFromProductToVarient(_ values: NSSet)

}
