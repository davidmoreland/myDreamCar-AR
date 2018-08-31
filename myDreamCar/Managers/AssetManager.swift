//
//  AssetManager.swift
//  myDreamCar
//
//  Created by Dave on 8/2/18.
//  Copyright © 2018 DigitalSuccess-Systems. All rights reserved.
//

import SceneKit
import ARKit

class AssetManager {
    

class func getAsset() -> SCNNode {
    
    var obj = SCNScene(named: "art.scnassets/370z_2013.scn")
  //  var obj = SCNScene(named:"art.scnassets/MainScence.scn")
    
    var node = obj?.rootNode.childNode(withName: "obj_pivot", recursively: false)!
    
    if (obj != nil) {
        print("Scene is loaded: , \(String(describing: obj)) as Any")
        
        // Initial Position
        //To Do: update values from DB so item displays same each time.
        if(node != nil) {
         //   node?.scale = SCNVector3Make(0.0090, 0.0090, 0.0090)
         
    //  node?.position = SCNVector3Make(0.0, 0.5, 0)
         node?.scale = SCNVector3Make(0.020, 0.020, 0.020)
    //  node?.position = SCNVector3Make(0.0, 0.0, 0.0)
       
            node?.position = SCNVector3Make(0.5, -0.4, -5.0)
            }
        }
            
        else {
            print("Node is empty: ")
            obj? = SCNScene(named: "art.scnassets/MainScene.scn")!
            obj?.rootNode.childNode(withName: "empty", recursively: true)
        node = SCNNode()
        }
        return node!
}

    func place3D(asset: SCNNode, with assetInfo: Asset, at point: (x:Float,y:Float,z:Float)) {
        // 1.  get Node from info in Asset
        
    //    asset.position = SCNVector3()
        // 2.
        
        
    }
    
 //   func placePlaneAt(tap:)
}
