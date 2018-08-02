//
//  3dInventoryCell.swift
//  myDreamCar
//
//  Created by David on 7/22/18.
//  Copyright © 2018 DigitalSuccess-Systems. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import CoreData


struct hasData {
    var isCell: Bool = false
    var isData: Bool = false
}

class InventoryCell: UICollectionViewCell, UIPopoverPresentationControllerDelegate, UIGestureRecognizerDelegate {
    
  //  var cellIndex: Int = 0
   // init(cellImageView: UIImageView,)
   // var title: UILabel?
    //  Testing
    var cellIndex = 0
    var cellImageView: UIImageView!
    let emptyCellImage: UIImage = (#imageLiteral(resourceName: "emptyCellImage.jpg"))
    var cellTitle: UILabel!
    var asset: Asset?
   

  /*
    func validateData(cell: UICollectionViewCell, withDataSet: Asset) -> hasData{
        if(cell .isKind(of: UICollectionViewCell.self))
        {
            print("Cell is created: \(cell)")
    //       hasData.isCell = true
      //     hasData.isData = false
        } else {
            print("Cell is NIL!: \(cell)")
        }
        
        return hasData
        
    }
*/
    
    
    func setImageViewAttributesWith(dataSet: Asset) -> UIImageView
    {
        let iv = UIImageView()
        // cell size
        iv.bounds = CGRect(x: 5.0, y: 5.0, width: self.frame.width, height: self.frame.height)
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 15
    // cell image
        
        // place holders presently
        
        iv.backgroundColor = UIColor.brown
        iv.backgroundColor?.withAlphaComponent(0.4)
      //test
        
      //   iv.image = UIImage.init(named: "Nissan_370z_perspective")
        if (dataSet.imageName != nil)
        {
            print("Cell ImageName: \(String(describing: dataSet.imageName))")
            
        iv.image = UIImage.init(named: dataSet.imageName!)
        print("Cell Image: \(String(describing: iv.image))")
        }
        else {
            iv.image = UIImage.init(named: "emptyCellImage.jpg")
            print("Cell Image: NIL")
        }
        return iv
    }
    
 

        
    
    
    func setTitleAttributesWith(dataSet: Asset)-> UILabel {
        let ct: UILabel = UILabel()
        // title size
        let titleXposition = CGFloat(self.frame.width/2)
        let titleYposition = CGFloat( -(self.frame.height)/2)
       // let titleYposition = CGFloat(5.00)
        print("TitleXposition: \(titleXposition)")
        print("TitleYposition: \(titleYposition)")
        
        
        // position Title in Cell
        
        // size title
        ct.bounds = CGRect(x: self.frame.width/2, y: self.frame.height/2, width: self.frame.width, height: 20.00)
        ct.contentMode = .center
      //  ct.clipsToBounds = true
        ct.layer.cornerRadius = 05
        // cell image
       // ct.image = UIImage.init(named: "graphPaper.jpg")
        ct.backgroundColor = UIColor.orange
        ct.backgroundColor?.withAlphaComponent(0.050)
        
        // retrieve title text
        ct.text = dataSet.name
        return ct
    }
    
    
    func add(subview: UIView, toCell: UICollectionViewCell) -> UICollectionViewCell {
      addSubview(subview)  //toCell.insertSubview(cellTitle, toView: subview)
        return toCell
    }
    
    
    func setAttributesWith(dataSet: Asset) {
        //test
        print("Cell Asset: \(dataSet)")
        
        self.cellIndex += self.cellIndex
        
        self.cellImageView = setImageViewAttributesWith(dataSet: dataSet)
            self.cellTitle = setTitleAttributesWith(dataSet: dataSet)
            print("ImageView Frame Width: \(cellImageView.frame.width)")
            
            self.addSubview(cellImageView)
            self.addSubview(cellTitle)
        }
        

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return .none
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    return true
    }

    

}

/*
func assembleComponents(cell: UICollectionViewCell) -> UIView
{
    var mv: UIView? = UIView()
    var title: UILabel?
    
    
    
    return mv
}
*/


