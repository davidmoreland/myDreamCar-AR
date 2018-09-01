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
    var planeNodes: [SCNNode] = []
    
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
        
        arSceneView.scene.rootNode.addChildNode(selectedNode)
        
        print("WorldView: selectedNode \(String(describing: selectedNode))")
        //   print("...       : sceneView: \(sceneView)")
        print("...       ARView Delegate: \(String(describing: arSceneView.delegate))")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
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
            self.planeNodes.append(planeNode)
            
            node.addChildNode(planeNode)
            print("Plane at: \(planeNode.transform)")
        } else {
            print("Plane NOT Detected")
            return
        }
    }
        

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let touchlocation = touch.location(in: arSceneView)
        
        let results = arSceneView.hitTest(touchlocation, types: [.existingPlaneUsingExtent])
        
        if let hitResult = results.first {
            let hitPosition = SCNVector3(
                x: hitResult.worldTransform.columns.3.x,
                y: hitResult.worldTransform.columns.3.y,
                z: hitResult.worldTransform.columns.3.z
            )
            print("=============================================")
            print("Position in Scene: \(hitPosition)")
            
       //     selectedNode.boundingBox = vector3(x:.boundingBox.x,y:.boundingBox.y, z:.boundingBox.z)
       let scale = SCNVector3(1, 1, 1)
            print("Scale: \(scale)")
            print("=============================================")
            //
            //Anchor Grid to 3D selected Position
            let gridAnchor = planeNodes[0].
            placeObjectInScene(on: planeNodes[0], at: hitPosition, using: scale)
        }
 }
    

   /* func onObjectSelected(obj: SCNNode) {
        self.selectedAsset = obj
    }
*/
    
    func placeObjectInScene(on gridNode: SCNNode, at position: SCNVector3, using scale: SCNVector3)
    {
        if gridNode != nil {
         //   let obj = SCNScene(named: "art.scnassets/Nissan_370Z_2013_ActualSize.copy.scn")
       // let node = obj?.rootNode.childNode(withName: "obj_pivot", recursively: true)!
            gridNode.position = position
            gridNode.scale = scale
            gridNode.addChildNode(selectedNode)
          //  arScene.scene.rootNode.addChildNode(selectedNode)
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
