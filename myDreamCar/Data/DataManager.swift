//
//  DataManager.swift
//  myDreamCar
//
//  Created by Dave Moreland on 7/30/18.
//  Copyright © 2018 DigitalSuccess-Systems. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//let dataManager = UIApplication.shared.delegate as? AppDelegate
let appDelegate = UIApplication.shared.delegate as! AppDelegate

struct AssetInfo {
    var name: String?
    var imageName: String?
    var fileType: String?
    var type: String?
    var price: Decimal = 0.00
    var numOfTriangles: Int16
    var note: String?
    
    
    init(name: String, imageName: String, fileType: String, type: String?, numOfTriangles: Int16, note: String, price: Decimal) {
        //  var priceFormatter: NumberFormatter = NumberFormatter()
        
        self.name = name
        self.imageName = imageName
        self.fileType = fileType
        self.type = type
        self.price = price
        self.numOfTriangles = numOfTriangles
        self.note = note
        
    }
    
}

struct SceneInfo {
    var name: String?
    var location: String?
    var file_size: UInt32
}


class DataManager:NSObject, NSFetchedResultsControllerDelegate    {
    

    
    /*
func setUpFRCwPredicate(entityName :String, predKey: NSPredicate )->NSFetchedResultsController<NSFetchRequestResult>
{
    let fetchedResultsController :NSFetchedResultsController<NSFetchRequestResult>
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    let sortByDBN = NSSortDescriptor(key: "dbn", ascending: true)
    request.sortDescriptors = [sortByDBN]
    request.predicate = predKey
    
    
    
  //  let context = self.persistentContainer.viewContext
    
    
    fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managed, sectionNameKeyPath: nil, cacheName: nil)
    
    
    do
        {
        try   fetchedResultsController.performFetch()
        
        
        } catch {
        print("Error setting up FetchedResultsController /n")
        
        
        }
    // returns the initalized controller to the calling class object
    return fetchedResultsController
    }  // end setup FetchController

}
*/
    

    
    struct ManufacturerInfo {
        var name: String
        var website: String
        var address1: String
        var address2: String
        var city: String
        var state: String
        var zipCode: String
        var country: String
    }


func addAssetTo(context: NSManagedObjectContext) {
    let asset = AssetInfo(name: "Nissan",imageName: "Nissan_370z_perspective.jpg", fileType: "dae", type: "vehicle", numOfTriangles: 1200, note: ""      , price: 75.00 )
    let cdAsset = Asset(context: context)
    cdAsset.name = asset.name
    cdAsset.fileType = asset.fileType
    cdAsset.type = asset.type
    cdAsset.numOfTriangles = asset.numOfTriangles
    cdAsset.note = asset.note
    cdAsset.price = asset.price as NSDecimalNumber
    
    print("MOC Asset: \(cdAsset)")
    
}
/*
    
 func checkDataExists() -> Bool {
        guard let managedContext = appDelegate.persistentContainer.viewContext else { return }
        
        let assets:[Asset] =
      //  let data = fetch {(completion: complete) {
            self.fetch { (complete) in
                if complete {
                    if assets.count >= 1 {
                        dataExists = true
                        complete = true
                    } else {
                      dataExists = false
                        complete = false
                    }
                   // print("Assets: \(assets.count)")
                }
            }
        }
 
    }
     */
    
    
func save(context: NSManagedObjectContext, completion: (_ finished: Bool) ->()) {
    
        do {
            try context.save()
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
        completion(false)
    }
}
    func save1(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data Saved: \(context)")
            
        } catch {
            print("Data NOT saved: ")
        }
    }
    
class func getMainManagedContext()-> NSManagedObjectContext
{
    let context = appDelegate.persistentContainer.viewContext
    return context
}

class func getBackGroundManagedContext()-> NSManagedObjectContext
{
    let context_bg = appDelegate.persistentContainer.newBackgroundContext()
    return context_bg
}

/*
    func validatePrice(num: Decimal) -> Decimal
    {
        let nsNumber = NSNumber(value: num)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        
        let formattedPrice: String = formatter.string(from: nsNumber)!
        
    }
  */
}


extension DataManager {
    
    // fetch Data
    func fetch(entityName: String, completion: (_ complete: Bool) ->()) {
        //   guard let context = appDelegate.persistentContainer.viewContext else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Asset>(entityName: entityName)
        
        do {
          let assets = try context.fetch(fetchRequest)
            print("Successfully fetched data.")
            print("# of Assets: \(assets.count)")
            completion(true)
            
        } catch {
            debugPrint("Could not Fetch: \(error.localizedDescription)")
            completion(false)
            
        }
    }
}
