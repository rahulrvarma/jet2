//
//  PersistentManager.swift
//  Jet2
//
//  Created by Rahul Varma on 08/07/20.
//  Copyright © 2020 Rahul Varma. All rights reserved.
//

import Foundation
import CoreData

struct EntityAttributes{
    static let entityOfflineData = "Offlinedata"
    static let attributeAPIName = "apiname"
    static let attributePageNumber = "pagenumber"
    static let attributeResponseData = "responsedata"
}


class PersistentManager {
    static let shared = PersistentManager()
    public init(){}

    private var context : NSManagedObjectContext { return persistentContainer.viewContext }
    
    private lazy var persistentContainer: NSPersistentContainer = {
           /*
            The persistent container for the application. This implementation
            creates and returns a container, having loaded the store for the
            application to it. This property is optional since there are legitimate
            error conditions that could cause the creation of the store to fail.
           */
           let container = NSPersistentContainer(name: "Jet2")
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
                   // Replace this implementation with code to handle the error appropriately.
                   // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
           }
       }

    

    func insertData(apiName : String, apiData : Data, page : Int){
        
        let pageNumber : String = String(page)

        let offlineEntity = NSEntityDescription.entity(forEntityName: EntityAttributes.entityOfflineData, in: context)!
        let offlineData = NSManagedObject(entity: offlineEntity, insertInto: context)
        offlineData.setValue(apiName, forKeyPath: EntityAttributes.attributeAPIName)
        offlineData.setValue(apiData, forKey: EntityAttributes.attributeResponseData)
        offlineData.setValue(pageNumber, forKey: EntityAttributes.attributePageNumber)
        
        do {
            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            print(paths[0])

            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
        
    func retrieveData(apiName : String, page : Int) -> Data? {
        
        let pageNumber : String = String(page)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityAttributes.entityOfflineData)
        let predicate1 = NSPredicate(format: "\(EntityAttributes.attributeAPIName) = %@", apiName)
        let predicate2 = NSPredicate(format: "\(EntityAttributes.attributePageNumber) = %@", pageNumber)
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        
        do {
            let result = try context.fetch(fetchRequest)
            var finaldata = Data()
            for data in result as! [NSManagedObject] {
                finaldata = (data.value(forKey: EntityAttributes.attributeResponseData) as! Data)
                break
            }
            return finaldata
        } catch {
            
            print("Failed")
            return nil

        }
    }
    
    /*
    func updateData(apiName : String, responseData : Data){
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: EntityAttributes.entityOfflineData)
        fetchRequest.predicate = NSPredicate(format: "\(EntityAttributes.attributeAPIName) = %@", apiName)
        do
        {
            let result = try context.fetch(fetchRequest)
            
            let objectUpdate = result.first as! NSManagedObject
            
            objectUpdate.setValue(responseData, forKey: EntityAttributes.attributeResponseData)

            do{
                try context.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
        
    }*/
    
    
    func deleteData(apiName : String){
            
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityAttributes.entityOfflineData)
            fetchRequest.predicate = NSPredicate(format: "\(EntityAttributes.attributeAPIName) = %@", apiName)
           
            do
            {
                let result = try context.fetch(fetchRequest)
                
                for objectDelete in result
                {
                    context.delete(objectDelete as! NSManagedObject)
                }
                
                do{
                    try context.save()
                }
                catch
                {
                    print(error)
                }
                
            }
            catch
            {
                print(error)
            }
        }
    
        

}
