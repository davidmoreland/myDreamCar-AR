//
//  SceneManager.swift
//  myDreamCar
//
//  Created by Dave on 8/4/18.
//  Copyright © 2018 DigitalSuccess-Systems. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

class SceneManager: UIView {
    
    /*
    class func sceneHitDetectionFor(sceneView: SCNView, gestureRecongnizer: UIGestureRecognizer)-> SCNNode {
        var tappedNodeName: String!
        var parentNodeName: String!
    
        
        let touchLocation = gestureRecongnizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(touchLocation, options: [:])
        
      //  if hitResults.count > 0 {
         //   let node = hitResults[0].node
            // test
        
            print("node Tapped: \(node.name!)")
            print("Parent: \(node.parent?.name!)")
            
        return node.parent!
        }
        else
        { return SCNNode()}
    }
*/
    
    func setUp(sceneView: ARSCNView, using sceneName: String)-> ARSCNView {
        print("Func-SetUpScene:")
   
    // Show statistics such as fps and timing information
    //  arSceneView.showsStatistics = true
    
    // Creat an an empty scene
        //test
       // sceneName = "art.scnassets/MainScene.scn"
        let scene = SCNScene(named: sceneName)!
    
    // Set the scene to the view
    sceneView.scene = scene
        
        //Set Configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        if #available(iOS 11.3, *) {
     //       configuration.planeDetection = .vertical
        } else {
            print("Vertical Plane Detection is only available on iOS 11.3 +")
        }
        
        
        sceneView.debugOptions = .showFeaturePoints
        
        sceneView.session.run(configuration)
        
    
        return sceneView
    
    }
    
    func planeDetectionAt(tap: UITapGestureRecognizer) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor {
            print("Plane Detected")
            let planeAnchor = anchor as! ARPlaneAnchor
            
            // convert anchor into a plane
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            
            let planeNode = SCNNode()
             let gridMaterial = SCNMaterial()
            gridMaterial.diffuse.contents = UIImage(named: "grid.png")
            plane.materials = [gridMaterial]
            // set position via the screen anchor position
            planeNode.position = SCNVector3(x: planeAnchor.center.x, y:0, z: planeAnchor.center.z)
            // rotate vertical plane to horizonal
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            planeNode.geometry = plane
            
            node.addChildNode(planeNode)
            
        } else {
            print("Plane NOT Detected")
        return
        }
    }
 }
