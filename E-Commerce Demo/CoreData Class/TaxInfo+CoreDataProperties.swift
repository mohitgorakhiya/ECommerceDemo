//
//  TaxInfo+CoreDataProperties.swift
//  E-CommerceDemo
//
//  Created by Mohit Gorakhiya on 1/20/19.
//  Copyright © 2019 Mohit. All rights reserved.
//
//

import Foundation
import CoreData


extension TaxInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaxInfo> {
        return NSFetchRequest<TaxInfo>(entityName: "TaxInfo")
    }

    @NSManaged public var taxName: String?
    @NSManaged public var taxValue: Float
    @NSManaged public var taxToProduct: NSSet?

}

// MARK: Generated accessors for taxToProduct
extension TaxInfo {

    @objc(addTaxToProductObject:)
    @NSManaged public func addToTaxToProduct(_ value: ProductList)

    @objc(removeTaxToProductObject:)
    @NSManaged public func removeFromTaxToProduct(_ value: ProductList)

    @objc(addTaxToProduct:)
    @NSManaged public func addToTaxToProduct(_ values: NSSet)

    @objc(removeTaxToProduct:)
    @NSManaged public func removeFromTaxToProduct(_ values: NSSet)

}
