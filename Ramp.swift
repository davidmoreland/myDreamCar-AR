//
//  Ramp.swift
//  ramp-up
//
//  Created by Mark Price on 7/19/17.
//  Copyright © 2017 Devslopes. All rights reserved.
//

import Foundation
import SceneKit

class Ramp {
    
   func getRampForName(rampName: String) -> SCNNode {
        switch rampName{
        case "pipe":
            return Ramp.getPipe()
            
        case "car":
            return Ramp.getCar()
        case "quarter":
            return Ramp.getQuarter()
        case "pyramid":
            return Ramp.getPyramid()
        default:
            return Ramp.getPipe()
        }
    }
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
                obj? = SCNScene(named: "art.scnassets/main.scn")!
                obj?.rootNode.childNode(withName: "empty", recursively: true)
                }
        }
        else {
            print("Scene is empty: \(String(describing: obj)) as Any")
        }
        
       
       return node!
    }
    
    class func getPipe() -> SCNNode {
        let obj = SCNScene(named: "art.scnassets/pipe.dae")
        let node = obj?.rootNode.childNode(withName: "pipe", recursively: true)!
        node?.scale = SCNVector3Make(0.0022, 0.0022, 0.0022)
        node?.position = SCNVector3Make(0, 0.7, 0)
        return node!
    }
    
    class func getPyramid() -> SCNNode {
        let obj = SCNScene(named: "art.scnassets/pyramid.dae")
        let node = obj?.rootNode.childNode(withName: "pyramid", recursively: true)!
        node?.scale = SCNVector3Make(0.0058, 0.0058, 0.0058)
        node?.position = SCNVector3Make(-1, -0.45, -1)
        return node!
    }
    
    class func getQuarter() -> SCNNode {
        let obj = SCNScene(named: "art.scnassets/quarter.dae")
        let node = obj?.rootNode.childNode(withName: "quarter", recursively: true)!
        node?.scale = SCNVector3Make(0.0058, 0.0058, 0.0058)
        node?.position = SCNVector3Make(-1, -2.2, -1)
        return node!
    }
    
    class func startRotation(node: SCNNode) {
        let rotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.1 * Double.pi), z: 0, duration: 0.5))
        node.runAction(rotate)
    }
}







