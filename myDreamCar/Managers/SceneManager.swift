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

class SceneManager: UIView{
    
 //   var arView = ARSCNView?
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
   
        // set ARView Delegate
      //  sceneView.delegate = delegate
    // Show statistics such as fps and timing information
    //  arSceneView.showsStatistics = true
    let scenePath = "art.scnassets/" + sceneName + ".scn"
        
        
    // Creat an an empty scene
        //test
       // sceneName = "art.scnassets/MainScene.scn"
        let scene = SCNScene(named: scenePath)!
    
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
        
        
     //   sceneView.debugOptions = .showFeaturePoints
        
        // set lighting
        sceneView.autoenablesDefaultLighting = true
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
            
            //build plane Node
            
            let planeNode = SCNNode()
            let gridMaterial = SCNMaterial()
            gridMaterial.diffuse.contents = UIImage(named: "grid.png")
            plane.materials = [gridMaterial]
            // set position via the screen anchor position
            planeNode.position = SCNVector3(x: planeAnchor.center.x, y:0, z: planeAnchor.center.z)
            // rotate vertical plane to horizonal
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 0, 1, 0)
            planeNode.geometry = plane
            
            node.addChildNode(planeNode)
            print("Plane at: \(planeNode.transform)")
        } else {
            print("Plane NOT Detected")
        return
        }
    }
    
    func buildPlaneNode(at anchor: ARAnchor, using node: SCNNode) -> SCNNode {
        let planeAnchor = anchor as! ARPlaneAnchor
        // convert anchor into a plane
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        
        let planeNode = SCNNode()
        planeNode.geometry = plane
        
        // rotate to orient correctly in scene
        // rotate vertical plane to horizonal
      //  planeNode.transform = SCNMatrix4MakeRotation(Float.pi/2, 1, 0, 0)
        // set position via the screen anchor position
        // change .extent.x to .center.x
        planeNode.position = SCNVector3(x: planeAnchor.extent.x, y:0, z: planeAnchor.extent.z)
        // Create Grid
        let gridMaterial = SCNMaterial()
        gridMaterial.diffuse.contents = UIImage(named: "grid.png")
        plane.materials = [gridMaterial]
        //node.addChildNode(planeNode)
        print("Plane at: \(planeNode.transform)")
        
    return planeNode
    }
    
    
    func anchorGrid(node:SCNNode, at anchor: ARAnchor) {
        print("Func: AnchorGrid ==")
        
        let hitTransform = SCNMatrix4(anchor.transform)
        let location = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43)
        /*
         if let hitResult = results.first {
         let hitPosition = SCNVector3(
         x: hitResult.worldTransform.columns.3.x,
         y: hitResult.worldTransform.columns.3.y,
         z: hitResult.worldTransform.columns.3.z
         )
         */
        print("=============================================")
        print("Grid Anchor Position in Scene: \(location)")
        
        //     selectedNode.boundingBox = vector3(x:.boundingBox.x,y:.boundingBox.y, z:.boundingBox.z)
        let scale = SCNVector3(1, 1, 1)
        print("Scale: \(scale)")
        print("=============================================")
        //
        //Anchor Grid to 3D selected Position
      //  let gridAnchor = planeNodes[0]
     //   arSceneView.scene.rootNode.addChildNode(gridAnchor)
        
        //   placeObjectInScene(on: planeNodes[0], at: hitPosition, using: scale)
    }
    
    
}

extension SceneManager {

    func setARSceneView(arView: ARSCNView) {
     //   self.arView = arView
    }
}

