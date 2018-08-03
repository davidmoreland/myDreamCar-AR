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
import ARKit

class AssetPreviewVC: UIViewController, UIGestureRecognizerDelegate {

    init(size: CGSize) {
        super.init(nibName: nil, bundle: nil)
        self.size = size
         view.frame = CGRect(origin: CGPoint.zero, size: size)
    }
    
    //@IBOutlet var view: UIView!
    @IBOutlet weak var sceneView: SCNView!
   // var sceneView: SCNView!
    var controlsView: UIView!
    var size: CGSize!
    var selectedObject: SCNNode!
    var selectedScene: SCNScene!
    var selectedSceneName: String!
    var selectedNodeName: String!
    var selectedAssetName: String!
    var selectedAsset: Asset!
  
    
    
    @IBAction func position_X_Slider(_ sender: UISlider) {
    }
    
    let control_Y_Slider: UISlider! = UISlider()
    @IBAction func position_Y_Slider(_ sender: UISlider) {
    }
    
    
    @IBAction func position_Z_Slider(_ sender: UISlider) {
    }
 // End Preview Positional Sliders
   
    //MARK Gesture Recognizers
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))

    weak var placeCarVC: PlaceCarVC!

    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
  //      view.frame = CGRect(origin: CGPoint.zero, size: size)
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: size.width , height: size.height - 250))
        // control view
        controlsView = UIView()
        controlsView.backgroundColor = UIColor.blue
        controlsView.frame = CGRect(x: 0, y: size.height - 250.00, width: size.width, height: 250.00)
        
        
        //control_X_Slider = UISlider()
        // MARK: Preview Posional Sliders
        let control_X_Slider: UISlider = UISlider(frame: CGRect(x: 0, y: 50.00, width: size.width - 200.00, height: 20.00))
        
        let control_Y_Slider: UISlider = UISlider(frame: CGRect(x: 0, y: 125.00, width: size.width - 200.00, height: 20.00))
        
        let control_Z_Slider: UISlider = UISlider(frame: CGRect(x: 0, y: 200.00, width: size.width - 200.00, height: 20.00))
        
        
        control_X_Slider.backgroundColor = UIColor.green
        control_X_Slider.tintColor = UIColor.white
        control_X_Slider.minimumValue = -50.00
        control_X_Slider.maximumValue = 50.00
        control_X_Slider.value = 0.00
        control_X_Slider.center = CGPoint(x: size.width/2, y: 25.00)
        control_X_Slider.isContinuous = true
        
        control_Y_Slider.backgroundColor = UIColor.yellow
        control_Y_Slider.tintColor = UIColor.white
        control_Y_Slider.minimumValue = -50.00
        control_Y_Slider.maximumValue = 50.00
        control_Y_Slider.value = 0.00
        control_Y_Slider.center = CGPoint(x: size.width/2, y: 100.00)
        control_Y_Slider.isContinuous = true
        
        control_Z_Slider.backgroundColor = UIColor.cyan
        control_Z_Slider.tintColor = UIColor.white
        control_Z_Slider.minimumValue = -50.00
        control_Z_Slider.maximumValue = 50.00
        control_Z_Slider.value = 0.00
        control_Z_Slider.center = CGPoint(x: size.width/2, y: 175.00)
        control_Z_Slider.isContinuous = true
        // control View
        controlsView.addSubview(control_X_Slider)
        controlsView.addSubview(control_Y_Slider)
        controlsView.addSubview(control_Z_Slider)
        
        view.addSubview(controlsView)
        controlsView.bringSubview(toFront: control_X_Slider)
        controlsView.bringSubview(toFront: control_Y_Slider)
        controlsView.bringSubview(toFront: control_Z_Slider)
        
// Asset Preview View
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
        
        setupTapGestureRecon(view: self.view)
      
    }
    
    func setupTapGestureRecon(view: UIView) {
        // let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AssetPreviewVC.dismissVC))
        //    tapGestureRecognizer.delegate = self
        
        self.view.isUserInteractionEnabled = true
         view.addGestureRecognizer(tapGestureRecognizer)
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
