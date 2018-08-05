//
//  TranslationControl.swift
//  myDreamCar
//
//  Created by Dave on 7/29/18.
//  Copyright © 2018 DigitalSuccess-Systems. All rights reserved.
//

import UIKit
import SceneKit

class TranslationControl: UIViewController {

    var x: SCNFloat = 0.0 { willSet {print("X-Value: \(newValue)")} }
    var y: SCNFloat = 0.0 { willSet {print("Y-Value: \(newValue)")} }
    var z: SCNFloat = 0.0 { willSet {print("Z-Value: \(newValue)")} }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func zoom(sender: UIControl, type: String)
    {
        
    
    }
    
    func rotate(object: SCNNode, aroundAxis: String) {
        
    }
    
    
    class func update3Dposition(x: Float, y: Float, z: Float ) -> SCNVector3 {
    // x = 0.5, y = 1.9, z = -2.0
        let nodePosition = SCNVector3Make(x, y, z)
        print("Update X: \(x)")
        print("Update Y: \(y)")
        print("Update Z: \(z)")
        
        return nodePosition
    }
    
     func updatePosition(x: Float) -> SCNVector3
    {
        let nodePosition = SCNVector3Make(x, self.y, self.z)
        print("Update X: \(x)")
        print("Update Y: \(y)")
        print("Update Z: \(z)")
        
        return nodePosition
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
