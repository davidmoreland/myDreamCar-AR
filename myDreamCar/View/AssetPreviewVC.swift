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
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        view.insertSubview(sceneView, at: 0)
        let scene = SCNScene(named: "art.scnassets/3dModelPreview.scn")
        sceneView.scene = scene
        
        let obj = SCNScene(named: "art.scnassets/Nissan_370Z_2013_ActualSize.scn")
        let node = obj?.rootNode.childNode(withName: "Nissan_370z_2013", recursively: true)!
        
        node?.scale = SCNVector3Make(0.0010, 0.0010, 0.0010)
        node?.position = SCNVector3Make(-0.95, 0.95, 0.95)
        // ssible crash
        scene?.rootNode.addChildNode(node!)
        
        preferredContentSize = size
        
        
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

}
