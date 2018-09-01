//
//  ARWorldViewVC.swift
//  tabAR_testApp
//
//  Created by Dave on 8/7/18.
//  Copyright © 2018 David Moreland. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARWorldViewVC: UIViewController, ARSCNViewDelegate, UIGestureRecognizerDelegate {
    @IBOutlet var result: UILabel!
    @IBOutlet var arSceneView: ARSCNView!
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        self.result = UILabel()
     }
    
    
    var delegate: ARpreviewVC?
    var selectedAssetName:String?
    var selectedNode: SCNNode!
  //  var arSceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("World View Loaded!")
        self.result.text = delegate?.selectedAsset
       
        // Set View's Delegate
        arSceneView?.delegate = self
       
        // Create a new Scene
        let scene = SCNScene(named: "art.scnassets/MainScene.scn")!

        //Set the Scene in the View
        arSceneView.scene = scene
    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
    
     // Create a session configuration
    let configuration = ARWorldTrackingConfiguration()
    
    // Run the view's session
    arSceneView?.session.run(configuration)
    }
    
 
    @IBAction func openPreview(_ sender: Any) {
        if self.delegate != nil {
        //    show(self.delegate!, sender: self)
         //   view.bringSubview(toFront: (self.delegate?.view)!)
          //  self.delegate?.view.sendSubview(toBack: self.view)
        dismiss(animated: true, completion: nil)
        }
       
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ARWorldViewVC: PreviewDelegate {
    func fetchScene(asset: String) {
        self.result = UILabel.init()
        self.result.text =  asset
        print("Extension: Result: \(asset)")
    }
    
    
}

