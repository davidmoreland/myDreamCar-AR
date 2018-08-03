//
//  AssetPreviewVC.swift
//  myDreamCar
//
//  Created by David on 7/23/18.
//  Copyright © 2018 DigitalSuccess-Systems. All rights reserved.
//

import UIKit
import SceneKit
import CoreData

class AssetPreviewVC: UIViewController, UIGestureRecognizerDelegate {

    var sceneView: SCNView!
    var size: CGSize!
    var selectedObject: SCNNode!
    var selectedScene: SCNScene!
    var selectedSceneName: String!
    var selectedNodeName: String!
    var selectedAssetName: String!
    var selectedAsset: Asset!
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))

    weak var placeCarVC: PlaceCarVC!

    
    init(size: CGSize) {
        super.init(nibName: nil, bundle: nil)
    self.size = size
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.frame = CGRect(origin: CGPoint.zero, size: size)
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: size.width , height: size.height))
        
        view.insertSubview(sceneView, at: 0)
        preferredContentSize = size
        view.layer.borderWidth = 5.00
        view.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        
        
       
// test
       let selectedSceneName = "art.scnassets/370z_2013.scn"
        
    selectedScene = SCNScene(named: selectedSceneName)!
        sceneView.scene = selectedScene
        //testing
        let assetObject = AssetManager.getCar()
        
     //  Ramp.startRotation(node: car)
    selectedScene.rootNode.addChildNode(assetObject)
        

        
        // let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AssetPreviewVC.dismissVC))
 
            self.view.isUserInteractionEnabled = true
    //    tapGestureRecognizer.delegate = self
        
       self.view?.addGestureRecognizer(tapGestureRecognizer)
    }
    
   
    @objc func dismissVC() {
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func displaySelectedAssetIn(scene: SCNScene?, nodeName: String) -> SCNNode {
        //Camera
        
    //    let scene = SCNScene(named: "MainScene.scn")
        
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        scene?.rootNode.camera = camera
        
       //let parentScene = scene
       let parentObj = SCNScene(named:"art.scnassets/Nissan370Z2013ActualSize_Grey.scn")
        
let objNode = parentObj?.rootNode.childNode(withName: "pivot", recursively: true)
        //Car - refactor into object retrieval class
        objNode?.scale = SCNVector3Make(0.0200, 0.0200, 0.0200)
      //  parentNode?.position = SCNVector3Make(0, -1, 1) // centered X, off bottom Y
        objNode?.position = SCNVector3Make(0, -0.5, -2)
      scene?.rootNode.addChildNode(objNode!)
        
       let rotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.1 * Double.pi), z: 0, duration: 1.0))
        
    
        objNode?.runAction(rotate)
        
        return objNode!
    }
    
    //Add touch

    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
    //
        let touchPoint = gestureRecognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(touchPoint, options: [ : ])
      //  displaySelectedAssetIn(scene: selectedScene, name: selectedNodeName)
        
        if hitResults .count > 0 {
           // test scene
            let selectedNode = hitResults[0].node
            print("Node Name: \(selectedNode.name!)")
            
         //   displaySelectedAssetIn(scene: selectedScene, nodeName: selectedNodeName)
          //  placeCarVC.selectedObject = selectedNode
            
            
        }

    }
    
    
    
}
