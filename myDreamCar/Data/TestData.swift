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
        let  assetInfo = AssetInfo(name: "Nissan", fileType: "dae", type: "Car", numOfTriangles: 1000, note: "This is dummy Data", price: 75.00)
      
      //  Asset.init(entity: Asset, insertInto: context)
        let context = DataManager.getMainManagedContext()
        
          let asset = Asset(context: context )
        asset.name = assetInfo.name
        asset.fileType = assetInfo.fileType
        asset.type = assetInfo.type
        asset.numOfTriangles = assetInfo.numOfTriangles
       // asset.price = assetInfo.price
        asset.note = assetInfo.note
        

    }
    

    
}

