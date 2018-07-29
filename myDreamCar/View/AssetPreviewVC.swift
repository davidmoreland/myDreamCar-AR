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
        
       
        displaySelectedAsset(named: "370z_2013_Coupe")
        //Add touch
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AssetPreviewVC.dismissVC))
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
    
    func displaySelectedAsset(named: String) {
       let scene = SCNScene(named: "art.scnassets/MainScene.scn")!
        sceneView.scene = scene
        
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        scene.rootNode.camera = camera
        
        let obj = SCNScene(named: "art.scnassets/Nissan370Z2013ActualSize.scn")
        let parentNode = obj?.rootNode.childNode(withName: "370z_2013_Coupe", recursively: true)!
        
        
        
        //Car - refactor into object retrieval class
        parentNode?.scale = SCNVector3Make(0.0200, 0.0200, 0.0200)
        parentNode?.position = SCNVector3Make(0.00, -0.1
            , 1.0)
        scene.rootNode.addChildNode(parentNode!)
    }
    
        //let pivotNode = parentNod
        // let pivotNode?.scale = SCNVector3Make(0.0010, 0.0010, 0.0010)
        // parentNode?.position = SCNVector3Make(-0.95, 0.95, 0.95)
        // scene?.rootNode.addChildNode(parentNode!)    }

}
