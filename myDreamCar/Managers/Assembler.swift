//
//  File.swift
//  myDreamCar
//
//  Created by Dave on 7/29/18.
//  Copyright © 2018 DigitalSuccess-Systems. All rights reserved.
//

import UIKit

class Assembly {
    
 
    class func stringParameter(location: String, assetName: String, extention: String ) -> String {
        
        let fullAssetPath: String  = location + assetName + extention
        
        return fullAssetPath
        
    }
    
    
}
