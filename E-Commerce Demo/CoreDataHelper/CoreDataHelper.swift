//
//  CoreDataHelper.swift
//  E-Commerce Demo
//
//  Created by Mohit Gorakhiya on 1/20/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHelperInstance {
    class var sharedInstance: CoreDataHelper {
        struct Static {
            static let instance: CoreDataHelper = CoreDataHelper()
        }
        return Static.instance
    }
}
class CoreDataHelper : NSObject {
    
    let storeName = "ECommerce"
    let storeFilename = "ECommerce.sqlite"
    override init() {
        super.init()
    }
    
    var applicationDocumentDirectory: URL = {
        
        let urls = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)
        var libraryURL: URL = urls[urls.count - 1]
        
        var strLibPath = libraryURL.path
        strLibPath = strLibPath + "/Database"
        if !FileManager.default.fileExists(atPath: strLibPath) {
            do {
                try FileManager.default.createDirectory(atPath: strLibPath, withIntermediateDirectories: true, attributes: nil)
            }
            catch {
                
            }
        }
        let strFinalURL: URL = URL.init(fileURLWithPath: strLibPath)
        return strFinalURL
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "E_Commerce_Demo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func fetchDataFrom(entityName: String, sorting : ObjCBool, predicate: NSPredicate?) -> Array<Any>? {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entityName)
        
        fetchRequest.predicate = predicate
        
        var array: [AnyObject]?
        do {
            array = try self.persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch {
        }
        
        return array
    }
}
