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
    
    @IBOutlet var longPress: UILongPressGestureRecognizer!
    
    @IBOutlet var tap: UITapGestureRecognizer!
    
    var delegate: AssetPreviewVC?
    var size: CGSize!
    var selectedAsset: Asset!
    var selectedAssetName: String!
    var selectedNode: SCNNode!
    var assetPreviewVC: AssetPreviewVC!
    let sceneManager: SceneManager = SceneManager()
    var planeNodes: [SCNNode] = []
    var selectedFeaturePoint = SCNVector3Make(0, 0, 0)
    
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
        arSceneView.autoenablesDefaultLighting = true
        
     //   arSceneView.scene.rootNode.addChildNode(selectedNode)
        
      //  print("WorldView: selectedNode \(String(describing: selectedNode))")
        //   print("...       : sceneView: \(sceneView)")
        print("...       ARView Delegate: \(String(describing: arSceneView.delegate))")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
     //   configuration.planeDetection = [.horizontal]
        if #available(iOS 11.3, *) {
            configuration.planeDetection = [.horizontal, .vertical]
        } else {
            // Fallback on earlier versions
            configuration.planeDetection = .horizontal
        }
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
    /*
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        return node
    }
    */
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor {
            print("Plane Detected")
            
            let planeNode = sceneManager.buildPlaneNode(at: anchor, using: node)
            // rotate vertical pla ne to horizonal
              planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            
            self.planeNodes.append(planeNode)
            print("# of Planes in Nodes Array: \(planeNodes.count)")
            
            node.addChildNode(planeNode)
         
            print("Plane at: \(planeNode.transform)")
            
           // sceneManager.anchorGrid(node, anchor) {
         //       planeNode.transform = selectedFeaturePoint
         //   node.addChildNode(planeNode.worldTransform = selectedFeaturePoint)
        }
    }
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
    }
   
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let touchlocation = touch.location(in: arSceneView)
        // Locate Point on Grid
       // let results = arSceneView.hitTest(touchlocation, types: [.existingPlaneUsingExtent])
        let results = arSceneView.hitTest(touchlocation, types: [.featurePoint])
      
        guard let hitFeature = results.last else {return}
            
        let hitTransform = SCNMatrix4(hitFeature.worldTransform)
        let hitPosition = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43)
        /*
        if let hitResult = results.first {
            let hitPosition = SCNVector3(
                x: hitResult.worldTransform.columns.3.x,
                y: hitResult.worldTransform.columns.3.y,
                z: hitResult.worldTransform.columns.3.z
            )
 */
            print("=============================================")
            print("Position in Scene: \(hitPosition)")
            
       //     selectedNode.boundingBox = vector3(x:.boundingBox.x,y:.boundingBox.y, z:.boundingBox.z)
       let scale = SCNVector3(1, 1, 1)
            print("Scale: \(scale)")
            print("=============================================")
            //
            //Anchor Grid to 3D selected Position
            let gridAnchor = planeNodes[0]
            arSceneView.scene.rootNode.addChildNode(gridAnchor)
            
         //   placeObjectInScene(on: planeNodes[0], at: hitPosition, using: scale)
}
  
    */
    
    
   /* func onObjectSelected(obj: SCNNode) {
        self.selectedAsset = obj
    }
*/
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
    // single tap places Grid
        let touchlocation = sender.location(in: arSceneView)
        // Locate Point on Grid
        let results = arSceneView.hitTest(touchlocation, types: [.featurePoint])
        
        guard let hitFeature = results.last else {return}
        
        let hitTransform = SCNVector3Make(
            hitFeature.worldTransform.columns.3.x,
            hitFeature.worldTransform.columns.3.y - 0.5,
            hitFeature.worldTransform.columns.3.z
        )
        
        self.selectedFeaturePoint = hitTransform
       
        print("=============================================")
        print("Car Position in Scene: \(selectedFeaturePoint)")
        
        let scale = SCNVector3(1, 1, 1)
        print("Scale: \(scale)")
        print("=============================================")
        //
        //Anchor Grid to 3D selected Position
      //  let gridAnchor = planeNodes[0]
       // let gridAnchor = selectedFeaturePoint
     // gride
         selectedNode.position = selectedFeaturePoint
       arSceneView.scene.rootNode.addChildNode(selectedNode)
    }
    
        //   placeObjectInScene(on: planeNodes[0], at: hitPosition, using: scale)
    
    
    
    func placeObjectInScene(on gridNode: SCNNode, at position: SCNVector3, using scale: SCNVector3)
    {
        guard gridNode .isKind(of: SCNNode.self) else {return}
         //   let obj = SCNScene(named: "art.scnassets/Nissan_370Z_2013_ActualSize.copy.scn")
       // let node = obj?.rootNode.childNode(withName: "obj_pivot", recursively: true)!
            gridNode.position = position
            gridNode.scale = scale
            gridNode.addChildNode(self.selectedNode)
          //  arScene.scene.rootNode.addChildNode(selectedNode)
    
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
