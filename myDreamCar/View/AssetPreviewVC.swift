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

var delegate: PlaceAssetVC?

class AssetPreviewVC: UIViewController, UIGestureRecognizerDelegate, ARSCNViewDelegate{

    init(size: CGSize) {
        super.init(nibName: nil, bundle: nil)
        self.size = size
         view.frame = CGRect(origin: CGPoint.zero, size: size)
        
    }

   let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (handleTap(_:)))
    
    //@IBOutlet var view: UIView!
    @IBOutlet weak var sceneView: SCNView!
    
    var controlsView: UIView!
    var size: CGSize!
    var selectedObject: SCNNode!
    var selectedScene: SCNScene!
    var selectedSceneName: String!
    var selectedNodeName: String!
    var selectedAssetName: String!
    var selectedAsset: Asset!
    var selctedNode: SCNNode!
    
    //Control Sliders
 // let control_X_Slider: UISlider = UISlider(frame: CGRect(x: 0, y: 50.00, width: sliderLength, height: 10.00))
    
  //  let control_Y_Slider: UISlider = UISlider(frame: CGRect(x: 0, y: 125.00, width: sliderLength, height: 10.00))
    var positionNegXlabel: UILabel!
    var positionNegYlabel: UILabel!
    var positionNegZlabel: UILabel!
    var positionPosXlabel: UILabel!
    var positionPosYlabel: UILabel!
    var positionPosZlabel: UILabel!
    
    
 // End Preview Positional Sliders
   
    //MARK Gesture Recognizers
 
    weak var placeAssetVC: PlaceAssetVC!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        print("Rendering AssetPreview: ")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
  //      view.frame = CGRect(origin: CGPoint.zero, size: size)
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: size.width , height: size.height))
      //  self.placeAssetVC = (storyboard?.instantiateInitialViewController())! as! PlaceAssetVC
         
            self.sceneView.delegate = self
        
        // control view
        controlsView = UIView()
        controlsView.backgroundColor = UIColor.black
        controlsView.backgroundColor?.withAlphaComponent(0.10)
        controlsView.frame = CGRect(x: 0, y: size.height - 250.00, width: size.width, height: 250.00)
        
        
        //control_X_Slider = UISlider()
        // MARK: Preview Posional Sliders
        
        let sliderLength = size.width - 400
        let sliderValueBoxWidth: CGFloat = 80.0
        let sliderValueBoxHeight: CGFloat = 60.0
        
        let control_X_Slider: UISlider = UISlider(frame: CGRect(x: 0, y: 50.00, width: sliderLength, height: 10.00))
     control_X_Slider.addTarget(self, action: #selector(position_X_action(sender:)), for: UIControlEvents.valueChanged)
        
        let control_Y_Slider: UISlider = UISlider(frame: CGRect(x: 0, y: 125.00, width: sliderLength, height: 10.00))
     control_Y_Slider.addTarget(self, action: #selector(position_Y_action(sender:)), for: UIControlEvents.valueChanged)
        
        let control_Z_Slider: UISlider = UISlider(frame: CGRect(x: 0, y: 200.00, width: sliderLength, height: 10.00))
        control_Z_Slider.addTarget(self, action: #selector(position_Z_action(sender:)), for: UIControlEvents.valueChanged)
        
        
        control_X_Slider.backgroundColor = UIColor.orange
        control_X_Slider.tintColor = UIColor.white
        control_X_Slider.minimumValue = -100.00
        control_X_Slider.maximumValue = 100.00
        control_X_Slider.value = 0.00
        control_X_Slider.center = CGPoint(x: size.width/2, y: 50.00)
        control_X_Slider.isContinuous = true
        
        control_Y_Slider.backgroundColor = UIColor.blue
        control_Y_Slider.tintColor = UIColor.white
        control_Y_Slider.minimumValue = -100.00
        control_Y_Slider.maximumValue = 100.00
        control_Y_Slider.value = 0.00
        control_Y_Slider.center = CGPoint(x: size.width/2, y: 125.00)
        control_Y_Slider.isContinuous = true
        
        control_Z_Slider.backgroundColor = UIColor.yellow
        control_Z_Slider.tintColor = UIColor.white
        control_Z_Slider.minimumValue = -100.00
        control_Z_Slider.maximumValue = 100.00
        control_Z_Slider.value = 0.00
        control_Z_Slider.center = CGPoint(x: size.width/2, y: 200.00)
        control_Z_Slider.isContinuous = true
        // control View
        controlsView.addSubview(control_X_Slider)
        controlsView.addSubview(control_Y_Slider)
        controlsView.addSubview(control_Z_Slider)
        view.addSubview(controlsView)
        controlsView.bringSubview(toFront: control_X_Slider)
        controlsView.bringSubview(toFront: control_Y_Slider)
        controlsView.bringSubview(toFront: control_Z_Slider)
        
        
        // Labels
        // X Label
        positionNegXlabel = UILabel()
        positionNegXlabel.frame = CGRect(x: (size.width/2 - sliderLength/2) - 150, y: 0, width: sliderValueBoxWidth, height: sliderValueBoxHeight)
        positionNegXlabel.backgroundColor = UIColor.clear
        positionNegXlabel.textColor = UIColor.white
        positionNegXlabel.textAlignment = NSTextAlignment.center
        positionNegXlabel.text = "0"
        positionNegXlabel.numberOfLines = 1
        positionNegXlabel.font = UIFont(name: "Courier", size: 32)
        // Y Label
        positionNegYlabel = UILabel()
        positionNegYlabel.frame = CGRect(x: (size.width/2 - sliderLength/2) - 150, y: 75, width: sliderValueBoxWidth, height: sliderValueBoxHeight)
        positionNegYlabel.backgroundColor = UIColor.clear
        positionNegYlabel.textColor = UIColor.white
        positionNegYlabel.textAlignment = NSTextAlignment.center
        positionNegYlabel.text = "0"
        positionNegYlabel.numberOfLines = 1
        positionNegYlabel.font = UIFont(name: "Courier", size: 32)
        // Z Label
        positionNegZlabel = UILabel()
        positionNegZlabel.frame = CGRect(x: (size.width/2 - sliderLength/2) - 150, y: 150, width: sliderValueBoxWidth, height: sliderValueBoxHeight)
        positionNegZlabel.backgroundColor = UIColor.clear
        positionNegZlabel.textColor = UIColor.white
        positionNegZlabel.textAlignment = NSTextAlignment.center
        positionNegZlabel.text = "0"
        positionNegZlabel.numberOfLines = 1
        positionNegZlabel.font = UIFont(name: "Courier", size: 32)
        
        
        // X Label
        positionPosXlabel = UILabel()
        positionPosXlabel.frame = CGRect(x: (size.width/2 + sliderLength/2) + 00, y: 0, width: sliderValueBoxWidth, height: sliderValueBoxHeight)
        positionPosXlabel.backgroundColor = UIColor.clear
        positionPosXlabel.textColor = UIColor.white
        positionPosXlabel.textAlignment = NSTextAlignment.center
        positionPosXlabel.text = "0"
        positionPosXlabel.numberOfLines = 1
        positionPosXlabel.font = UIFont(name: "Courier", size: 32)
        // Y Label
        positionPosYlabel = UILabel()
        positionPosYlabel.frame = CGRect(x: (size.width/2 + sliderLength/2) + 0, y: 75, width: sliderValueBoxWidth, height: sliderValueBoxHeight)
        positionPosYlabel.backgroundColor = UIColor.clear
        positionPosYlabel.textColor = UIColor.white
        positionPosYlabel.textAlignment = NSTextAlignment.center
        positionPosYlabel.text = "0"
        positionPosYlabel.numberOfLines = 1
        positionPosYlabel.font = UIFont(name: "Courier", size: 32)
        // Z Label
        positionPosZlabel = UILabel()
        positionPosZlabel.frame = CGRect(x: (size.width/2 + sliderLength/2) + 0, y: 150, width: sliderValueBoxWidth, height: sliderValueBoxHeight)
        positionPosZlabel.backgroundColor = UIColor.clear
        positionPosZlabel.textColor = UIColor.white
        positionPosZlabel.textAlignment = NSTextAlignment.center
        positionPosZlabel.text = "0"
        positionPosZlabel.numberOfLines = 1
        positionPosZlabel.font = UIFont(name: "Courier", size: 32)
        
        
        self.controlsView.addSubview(positionNegXlabel)
        self.controlsView.addSubview(positionNegYlabel)
        self.controlsView.addSubview(positionNegZlabel)
        
        self.controlsView.addSubview(positionPosXlabel)
        self.controlsView.addSubview(positionPosYlabel)
        self.controlsView.addSubview(positionPosZlabel)
        
        
        
// Asset Preview View
        view.insertSubview(sceneView, at: 0)
        preferredContentSize = size
        view.layer.borderWidth = 5.00
        view.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
       
// DISPLAY 3D - Object
    
        //let selectedSceneName = "art.scnassets/370z_2013.scn"
        let selectedSceneName = "art.scnassets/MainScene.scn"
        
    selectedScene = SCNScene(named: selectedSceneName)!
   // let nodeName = "pivot"
        sceneView.scene = selectedScene
        //testing
      // getCar WORKS
          let assetObject = AssetManager.getAsset()
        
        // Display Asset WORKS 8.4.18
       // let assetObject: SCNNode = displaySelectedAssetIn(scene: selectedScene, nodeName: nodeName)
     //  Ramp.startRotation(node: car)
    selectedScene.rootNode.addChildNode(assetObject)
        
      setupTapGestureRecon(view: self.view)
      
    }  // end viewDidLoad
  
    
    
    
    
    
    @objc func position_X_action(sender: UISlider) {
        if(sender.value < 0){
            positionNegXlabel.textColor = UIColor.green
            positionPosXlabel.textColor = UIColor.white
            positionNegXlabel.font = UIFont(name: "Copperplate-Bold", size: 34)
            positionPosXlabel.font = UIFont(name: "Courier", size: 30)
            positionNegXlabel.text = String(Int(sender.value))
        } else {
            positionPosXlabel.textColor = UIColor.green
            positionNegXlabel.textColor = UIColor.white
            positionPosXlabel.font = UIFont(name: "Copperplate-Bold", size: 34)
            positionNegXlabel.font = UIFont(name: "Courier", size: 30)
            positionPosXlabel.text = String(Int(sender.value))
              }
     //   TranslationControl().updatePosition(x: (sender.value))
    }
    
    @objc func position_Y_action(sender: UISlider) {
        if(sender.value < 0){
            positionNegYlabel.textColor = UIColor.green
            positionPosYlabel.textColor = UIColor.white
            positionNegYlabel.font = UIFont(name: "Copperplate-Bold", size: 34)
            positionPosYlabel.font = UIFont(name: "Courier", size: 30)
             positionNegYlabel.text = String(Int(sender.value))
        } else {
            positionPosYlabel.textColor = UIColor.green
            positionNegYlabel.textColor = UIColor.white
            positionPosYlabel.font = UIFont(name: "Copperplate-Bold", size: 34)
            positionNegYlabel.font = UIFont(name: "Courier", size: 30)
            positionPosYlabel.text = String(Int(sender.value))
          }
    }
    @objc func position_Z_action(sender: UISlider) {
        if(sender.value < 0){
            positionNegZlabel.textColor = UIColor.green
            positionPosZlabel.textColor = UIColor.white
            positionNegZlabel.font = UIFont(name: "Copperplate-Bold", size: 34)
            positionPosZlabel.font = UIFont(name: "Courier", size: 30)
            positionNegZlabel.text = String(Int(sender.value))
         } else {
            positionPosZlabel.textColor = UIColor.green
            positionNegZlabel.textColor = UIColor.white
            positionPosZlabel.font = UIFont(name: "Copperplate-Bold", size: 34)
            positionNegZlabel.font = UIFont(name: "Courier", size: 30)
            positionPosZlabel.text = String(Int(sender.value))
        }
    }
    
    func setupTapGestureRecon(view: UIView) {
         let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            tapGestureRecognizer.delegate = self
        self.view.isUserInteractionEnabled = true
         view.addGestureRecognizer(tapGestureRecognizer)
        self.dismiss(animated: true, completion: nil)
    }

    override func performSegue(withIdentifier identifier: String, sender: Any?) {

   // placeAssetVC = PlaceAssetVC()
      
     //  dismiss(animated: true, completion: nil)
     //   let placeAssetVC = PlaceAssetVC()
        //placeAssetVC.delegate = self
        print("PerformSegue, PlaceAssetVC: \(placeAssetVC)")
        show(placeAssetVC, sender: self)
        self.dismiss(animated: true, completion: nil)
        
      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "showCameraScreen"
        {    print("PlaceAsset 'prepareForSegue': ")
            let destinationVC = segue.destination as! PlaceAssetVC
            
            //test
            print("PA_VC: \(destinationVC)")
            // Pass the selected object to the new view controller.
        }
    }

    
//Add touch

    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
 
        let touchPoint = gestureRecognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(touchPoint, options: [ : ])
      
        if hitResults .count > 0 {
            // test scene
            let selectedNode = hitResults[0].node
            print("Parent Node: \(String(describing: selectedNode.parent?.name!))")
            print("Node Name: \(selectedNode.name!)")
        delegate?.selectedAsset = self.selectedAsset
            delegate?.selectedAssetName = self.selectedAssetName
 
        performSegue(withIdentifier: "showCameraScreen", sender: self)
           self.dismiss(animated: true, completion: nil)
              }
        
    }
  
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
}  //end Class




    /*
    func displaySelectedAssetIn(scene: SCNScene?, nodeName: String) -> SCNNode {
        //Camera
        
    //    let scene = SCNScene(named: "MainScene.scn")
        
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        scene?.rootNode.camera = camera
        
       //let parentScene = scene
      // let parentObj = SCNScene(named:"art.scnassets/370z_2013.scn")

let objNode = parentObj?.rootNode.childNode(withName: "pivot", recursively: true)
        //Car - refactor into object retrieval class
        objNode?.scale = SCNVector3Make(0.0200, 0.0200, 0.0200)
      //  parentNode?.position = SCNVector3Make(0, -1, 1) // centered X, off bottom Y
        objNode?.position = SCNVector3Make(0, -0.5, -15.00)
      scene?.rootNode.addChildNode(objNode!)
        
       let rotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.1 * Double.pi), z: 0, duration: 1.0))
        
    
        objNode?.runAction(rotate)
        
        return objNode!
    }
    */
    

        

  
    

