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
  
    @IBOutlet var arSceneView: ARSCNView!
    
   var delegate: AssetPreviewVC?
    var size: CGSize!
    var selectedAsset: Asset!
    var selectedAssetName: String!
    var selectedNode: SCNNode!
    var assetPreviewVC: AssetPreviewVC!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        arSceneView.delegate = self
        
        // Show statistics such as fps and timing information
      //  arSceneView.showsStatistics = true
        
        // Creat an an empty scene
       let scene = SCNScene(named: "art.scnassets/MainScene.scn")!
        
        // Set the scene to the view
        arSceneView.scene = scene
        
        print("WorldView: selectedNode \(selectedNode)")
        //   print("...       : sceneView: \(sceneView)")
        print("...       : selectedAsset \(selectedAsset)")
        
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

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let results = arSceneView.hitTest(touch.location(in: arSceneView), types: [.featurePoint])
        guard let hitFeature = results.last else {return}
        let hitTransform = SCNMatrix4(hitFeature.worldTransform)
       
        let hitPosition = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43)
        placeObjectInScene(position: hitPosition)
 
 }
    
    
   /* func onObjectSelected(obj: SCNNode) {
        self.selectedAsset = obj
    }
*/
    
    func placeObjectInScene(position: SCNVector3) {
        if selectedAsset != nil {
            let obj = SCNScene(named: "art.scnassets/Nissan_370Z_2013_ActualSize.copy.scn")
        let node = obj?.rootNode.childNode(withName: "obj_pivot", recursively: true)!
            node?.position = position
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
    func selected(asset: Asset) {
        self.selectedAsset = asset
        print("From WV-Extention: SelectedAsset: \(asset)")
        
    }
   
    func fetchScene(asset: Asset) {
        self.selectedAsset = asset
        print("From WV-Extention: SelectedAsset: \(asset)")
        }
 
}
