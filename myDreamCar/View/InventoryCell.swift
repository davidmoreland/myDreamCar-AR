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

class InventoryCell: UICollectionViewCell, UIPopoverPresentationControllerDelegate, UIGestureRecognizerDelegate {
    
  //  var cellIndex: Int = 0
   // init(cellImageView: UIImageView,)
   // var title: UILabel?
    //  Testing
    var cellIndex = 0
    var cellImageView: UIImageView = UIImageView()
    let emptyCellImage: UIImage = (#imageLiteral(resourceName: "emptyCellImage.jpg"))
    var title: UILabel?
    
 //   testing dataSet
    var dataSet: NSManagedObject! = NSManagedObject()
    
    
    
    func setImageViewAttributesFor(cell: UICollectionViewCell, withDataSet: Asset)->UIImageView
    {
        let iv = UIImageView()
        // cell size
        iv.bounds = CGRect(x: 5.0, y: 5.0, width: cell.frame.width, height: cell.frame.height)
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 15
    // cell image
        
        // place holders presently
        
        iv.backgroundColor = UIColor.brown
        iv.backgroundColor?.withAlphaComponent(0.4)
      //test
        if(self.cellIndex == 0) {
         iv.image = UIImage.init(named: "Nissan_370z_perspective")
            //test
       //     print("Image Named: \(dataSet[atIndex].imageName)")
        }
        else {
           iv.image = UIImage.init(named: "emptyCell")
        }
        return iv
    }
    
 

        
    func setAttributesFor(cell: UICollectionViewCell, withDataSet: Asset) {
    self.cellIndex += self.cellIndex
        
        let imageView = setImageViewAttributesFor(cell: cell, withDataSet: withDataSet)
        let cellTitle = setTitleAttributesFor(cell: cell, withDataSet: withDataSet)
        print("ImageView Frame Width: \(imageView.frame.width)")
        
        cell.addSubview(imageView)
        cell.addSubview(cellTitle)
}

    
    
    func setTitleAttributesFor(cell: UICollectionViewCell, withDataSet: Asset)-> UILabel {
        let ct: UILabel = UILabel()
        // title size
        let titleXposition = CGFloat(cell.frame.width)
        let titleYposition = CGFloat( (cell.frame.height) * 0.80)
        print("TitleXposition: \(titleXposition)")
        print("TitleYposition: \(titleYposition)")
        
        
        // position Title in Cell
        
        // size title
        ct.bounds = CGRect(x: 0.0, y: 0.0, width: titleXposition, height: titleYposition * 0.20)
        ct.contentMode = .center
      //  ct.clipsToBounds = true
        ct.layer.cornerRadius = 05
        // cell image
       // ct.image = UIImage.init(named: "graphPaper.jpg")
        ct.backgroundColor = UIColor.orange
        ct.backgroundColor?.withAlphaComponent(0.10)
        
        // retrieve title text
      //  if(cell.)
        
 //   ct.text = assets[cellIndex].title
        
      
 
        return ct
    
    }

    func add(subview: UIView, toCell: UICollectionViewCell) -> UICollectionViewCell {
      addSubview(subview)  //toCell.insertSubview(cellTitle, toView: subview)
        return toCell
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


