//
//  ProductVarients+CoreDataProperties.swift
//  E-CommerceDemo
//
//  Created by Mohit Gorakhiya on 1/20/19.
//  Copyright © 2019 Mohit. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductVarients {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductVarients> {
        return NSFetchRequest<ProductVarients>(entityName: "ProductVarients")
    }

    @NSManaged public var varientColor: String?
    @NSManaged public var varientId: Int64
    @NSManaged public var varientPrice: Double
    @NSManaged public var varientSize: Int64
    @NSManaged public var varientToProduct: NSSet?

}

// MARK: Generated accessors for varientToProduct
extension ProductVarients {

    @objc(addVarientToProductObject:)
    @NSManaged public func addToVarientToProduct(_ value: ProductList)

    @objc(removeVarientToProductObject:)
    @NSManaged public func removeFromVarientToProduct(_ value: ProductList)

    @objc(addVarientToProduct:)
    @NSManaged public func addToVarientToProduct(_ values: NSSet)

    @objc(removeVarientToProduct:)
    @NSManaged public func removeFromVarientToProduct(_ values: NSSet)

}
