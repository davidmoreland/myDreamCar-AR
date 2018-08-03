//
//  AssetManager.swift
//  myDreamCar
//
//  Created by Dave on 8/2/18.
//  Copyright © 2018 DigitalSuccess-Systems. All rights reserved.
//

import SceneKit

class AssetManager {
    

class func getCar() -> SCNNode {
    
    var obj = SCNScene(named: "art.scnassets/370z_2013.scn")
    
    let node = obj?.rootNode.childNode(withName: "obj_pivot", recursively: true)!
    
    if (obj != nil) {
        print("Scene is loaded: , \(String(describing: obj)) as Any")
        
        
        if(node != nil) {
            node?.scale = SCNVector3Make(0.0090, 0.0090, 0.0090)
            node?.position = SCNVector3Make(0.0, 0.5, 0)
        }
            
        else {
            print("Node is empty: ")
            obj? = SCNScene(named: "art.scnassets/MainScene.scn")!
            obj?.rootNode.childNode(withName: "empty", recursively: true)
        }
    }
    else {
        print("Scene is empty: \(String(describing: obj)) as Any")
    }
    
    
    return node!
}


}
