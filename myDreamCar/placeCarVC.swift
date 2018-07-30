//
//  placeCar View  Controller.swift
//  My Dream Car
//
//  Created by David on 7/18/18.
//  Copyright © 2018 DigitalSuccess-Systems. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class placeCarVC: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var selectedObject: SKNode!
    var assetPreviewVC: AssetPreviewVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Creat an an empty scene
        let scene = SCNScene(named: "art.scnassets/MainScene.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    
    
    
    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let results = sceneView.hitTest(touch.location(in: sceneView), types: [.featurePoint])
        guard let hitFeature = results.last else {return}
        let hitTransform = SCNMatrix4(hitFeature.worldTransform)
       /*
        let hitPosition = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43) placeObjectInScene(position: hitPosition)
 */
 }
    
    
    func onObjectSelected(obj: SKNode) {
        self.selectedObject = obj
    }
    /*
    func placeObjectInScene(position: SCNVector3) {
         if let objName = selectedObject {
            let obj = SCNScene(named: "art.scnassets/Nissan_370Z_2013_ActualSize.copy.scn")
        let node = obj?.rootNode.childNode(withName: "car", recursively: true)!
            node?.position = position
            }
 */
 
    
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is re
    }
}
