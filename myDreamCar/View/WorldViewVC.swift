//
//  WorldView  ViewController.swift
//  My Dream Car
//
//  Created by David on 7/18/18.
//  Copyright © 2018 DigitalSuccess-Systems. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class WorldViewVC: UIViewController, UIGestureRecognizerDelegate, ARSCNViewDelegate {
  
    @IBOutlet  var arSceneView: ARSCNView!
    
   var delegate: AssetPreviewVC?
    var size: CGSize!
    var selectedAsset: Asset!
    var selectedAssetName: String!
    var selectedNode: SCNNode!
    var assetPreviewVC: AssetPreviewVC!
    let sceneManager: SceneManager = SceneManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate  (moved to SceneManager)
        arSceneView.delegate = self
        // Show statistics such as fps and timing information
        arSceneView.showsStatistics = true
        
        // Creat an an empty scene (moved to SceneManager)
       let scene = SCNScene(named: "art.scnassets/MainScene.scn")!
        
        // Set the scene to the view (moved to SceneManager)
       arSceneView.scene = scene
       // arSceneView = sceneManager.setUp(sceneView: arSceneView, using: "MainScene")
        
        print("WorldView: selectedNode \(String(describing: selectedNode))")
        //   print("...       : sceneView: \(sceneView)")
        print("...       ARView Delegate: \(String(describing: arSceneView.delegate))")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        arSceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        arSceneView.session.pause()
    }
  
   
    
    // MARK: - ARSCNViewDelegate
    

    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
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
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 0, 1, 0)
            planeNode.geometry = plane
            
            node.addChildNode(planeNode)
            print("Plane at: \(planeNode.transform)")
        } else {
            print("Plane NOT Detected")
            return
        }
    }
        
/*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let results = arSceneView.hitTest(touch.location(in: arSceneView), types: [.featurePoint])
        guard let hitFeature = results.last else {return}
        let hitTransform = SCNVector3
       
        let hitPosition = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43)
        
        
        placeObjectInScene(at: hitPosition, using: <#SCNVector3#>)
 
 }
    
  */
   /* func onObjectSelected(obj: SCNNode) {
        self.selectedAsset = obj
    }
*/
    
    func placeObjectInScene(at position: SCNVector3, using scale: SCNVector3) {
        if selectedNode != nil {
         //   let obj = SCNScene(named: "art.scnassets/Nissan_370Z_2013_ActualSize.copy.scn")
       // let node = obj?.rootNode.childNode(withName: "obj_pivot", recursively: true)!
            selectedNode.position = position
            selectedNode.scale = scale
            
        }
    }
 
    
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }


    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is re
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        <#code#>
    }
 */
    
    }


extension WorldViewVC: AssetPreviewDelegate {
    func selected(node: SCNNode) {
        self.selectedNode = node
    }
    
    func selected(asset: Asset) {
        self.selectedAsset = asset
        print("From WV-Extention: SelectedAsset: \(asset)")
        
    }
   
    func fetchScene(asset: Asset) {
        self.selectedAsset = asset
        print("From WV-Extention: SelectedAsset: \(asset)")
        }
 
}
