//
//  TestData.swift
//  myDreamCar
//
//  Created by Dave on 7/30/18.
//  Copyright © 2018 DigitalSuccess-Systems. All rights reserved.
//

import UIKit
import CoreData

/*   ATest Data

 Entity:
 1. Manufacturer
 2. Category
 3. Reviews
 4. Asset
 
 
 Relationships
 
 Manufacturer2Category
 Manufacturer2Asset
 Manufacturer2Review
 
 Category2Manufacturer
 Category2Review
 
 Asset2Category
 Asset2Manufacturer
 Asset2Review
 
 */
class TestData: DataManager
{


    func createDummyData(context: NSManagedObjectContext) {
        
        var  assetInfo = AssetInfo(name: "Nissan", imageName: "Nissan_370z_perspective.jpg", fileType: "dae", type: "Car", numOfTriangles: 1000, note: "This is dummy Data", price: 55000.00)
      
      
        let context = DataManager.getMainManagedContext()
        
        var asset = Asset(context: context )
        asset.name = assetInfo.name
        asset.imageName = assetInfo.imageName
        asset.fileType = assetInfo.fileType
        asset.type = assetInfo.type
        asset.numOfTriangles = assetInfo.numOfTriangles
       // asset.price = assetInfo.price
        asset.note = assetInfo.note
      //  asset.sceneName = assetInfo.sceneName
        
        NSEntityDescription.insertNewObject(forEntityName: "Asset", into: context)
        
        save1(context: context)
        
     /*
          assetInfo = AssetInfo(name: "Chev", imageName: "", fileType: "dae", type: "Car", numOfTriangles: 1000, note: "This is dummy Data", price: 0.00)
        
        asset.name = assetInfo.name
        asset.imageName = assetInfo.imageName
        asset.fileType = assetInfo.fileType
        asset.type = assetInfo.type
        asset.numOfTriangles = assetInfo.numOfTriangles
        // asset.price = assetInfo.price
        asset.note = assetInfo.note
        
        NSEntityDescription.insertNewObject(forEntityName: "Asset", into: context)
        
        save1(context: context)
        
        
         assetInfo = AssetInfo(name: "Ford", imageName: "", fileType: "dae", type: "Car", numOfTriangles: 1000, note: "This is dummy Data", price: 0.00)
        
        asset.name = assetInfo.name
        asset.imageName = assetInfo.imageName
        asset.fileType = assetInfo.fileType
        asset.type = assetInfo.type
        asset.numOfTriangles = assetInfo.numOfTriangles
        // asset.price = assetInfo.price
        asset.note = assetInfo.note
       
        NSEntityDescription.insertNewObject(forEntityName: "Asset", into: context)
        
        save1(context: context)
        
        
         assetInfo = AssetInfo(name: "Nissan", imageName: "", fileType: "dae", type: "Car", numOfTriangles: 1000, note: "This is dummy Data", price: 150.00)
        
        asset.name = assetInfo.name
        asset.imageName = assetInfo.imageName
        asset.fileType = assetInfo.fileType
        asset.type = assetInfo.type
        asset.numOfTriangles = assetInfo.numOfTriangles
        // asset.price = assetInfo.price
        asset.note = assetInfo.note
        
        NSEntityDescription.insertNewObject(forEntityName: "Asset", into: context)
        
        save1(context: context)
        */
        
        assetInfo = AssetInfo(name: "AssetNotFound", imageName: "AssetNotFound.jpg", fileType: "", type: "", numOfTriangles: 0, note: "This is dummy Data", price: 0.00)
        
        asset.name = assetInfo.name
        asset.imageName = assetInfo.imageName
        asset.fileType = assetInfo.fileType
        asset.type = assetInfo.type
        asset.numOfTriangles = assetInfo.numOfTriangles
        // asset.price = assetInfo.price
        asset.note = assetInfo.note
        
        NSEntityDescription.insertNewObject(forEntityName: "Asset", into: context)
        
        save1(context: context)
        /*
          assetInfo = AssetInfo(name: "Nissan", imageName: "Nissan_370z_perspective.jpg", fileType: "dae", type: "Car", numOfTriangles: 1000, note: "This is dummy Data", price: 75.00)
        
        asset.name = assetInfo.name
        asset.imageName = assetInfo.imageName
        asset.fileType = assetInfo.fileType
        asset.type = assetInfo.type
        asset.numOfTriangles = assetInfo.numOfTriangles
        // asset.price = assetInfo.price
        asset.note = assetInfo.note
        
        NSEntityDescription.insertNewObject(forEntityName: "Asset", into: context)
        
        save1(context: context)
*/
 }

 }


