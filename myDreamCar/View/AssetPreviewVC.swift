//
//  AssetPreviewVC.swift
//  myDreamCar
//
//  Created by David on 7/23/18.
//  Copyright © 2018 DigitalSuccess-Systems. All rights reserved.
//

import UIKit
import SceneKit

class AssetPreviewVC: UIViewController, UIGestureRecognizerDelegate {

    var sceneView: SCNView!
    var size: CGSize!
    var selectedObject: SCNNode!
    var selectedScene: SCNScene!
    var selectedNodeName: String!
    var selectedAssetName: String!
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AssetPreviewVC.dismissVC))

    weak var placeCarVC: placeCarVC!

    
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
        view.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        view.layer.borderWidth = 3.0
        
        
// test
        
        selectedScene = SCNScene(named: "art.scnassets/Nissan370Z2013ActualSize.scn")
   
      // selectedNodeName = "370z_2013_Coupe"
     selectedNodeName = "pivot"
        // pivot doesn't show anything
        //  selectedNodeName = "pivot"
        
        displaySelectedAsset(inScene: selectedScene, name: selectedNodeName)
        
    
        // let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AssetPreviewVC.dismissVC))
 
 self.view.isUserInteractionEnabled = true
        tapGestureRecognizer.delegate = self
        
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
    
    func displaySelectedAsset(inScene: SCNScene, name: String) {
      // let sence = inScene
        
        let scene = SCNScene(named: "art.scnassets/MainScene.scn")!
        sceneView.scene = scene
        
        //Camera
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        scene.rootNode.camera = camera
        
        let parentScene = SCNScene(named:"art.scnassets/Nissan370Z2013ActualSize.scn")
       
        let parentNode = parentScene?.rootNode.childNode(withName: name, recursively: true)!
  
        
      //  selectedObject = SCNScene(named: "art.scnassets/Nissan370Z2013ActualSize.scn")
        
      //  let obj = SCNScene(named: "art.scnassets/Nissan370Z2013ActualSize.scn")
        
 
        //Car - refactor into object retrieval class
        parentNode?.scale = SCNVector3Make(0.0200, 0.0200, 0.0200)
      //  parentNode?.position = SCNVector3Make(0, -1, 1) // centered X, off bottom Y
        parentNode?.position = SCNVector3Make(0, -0.5, -2)
        scene.rootNode.addChildNode(parentNode!)
        
       let rotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.1 * Double.pi), z: 0, duration: 1.0))
        
      //  let pivotNode = parentNode?.childNode(withName: "pivot", recursively: true)
        
        parentNode?.runAction(rotate)
        
    }
    
    //Add touch

    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
    //
        let touchPoint = gestureRecognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(touchPoint, options: [ : ])
        displaySelectedAsset(inScene: selectedScene, name: selectedNodeName)
        
        if hitResults .count > 0 {
           // test scene
            let selectedNode = hitResults[0].node
        
           displaySelectedAsset(inScene: selectedScene, name: selectedNodeName)
          //  placeCarVC.selectedObject = selectedNode
            
            
        }

    }
    
}
