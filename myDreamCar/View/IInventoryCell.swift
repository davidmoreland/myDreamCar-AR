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

class InventoryCell: UICollectionViewCell {
   
   
    
    var cellImageView: UIImageView!
    var cellTitle: UILabel!

    func setImageViewAttributes(cell: UICollectionViewCell)->UIImageView
    {
        let iv = UIImageView()
        // cell size
        iv.bounds = CGRect(x: 5.0, y: 5.0, width: cell.frame.width, height: cell.frame.height)
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 15
    // cell image
        iv.image = UIImage.init(named: "Nissan_370z_perspective")
        iv.backgroundColor = UIColor.brown
        iv.backgroundColor?.withAlphaComponent(0.4)
        
        // set cell properties
        self.cellImageView = iv
        return iv
    }
    
 /*
    required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
     }
*/
        
    func setAttributes(cell: UICollectionViewCell) {
    
      let imageView = setImageViewAttributes(cell: cell)
        print("ImageView Frame Width: \(imageView.frame.width)")
        let cellTitle = buildCellTitle(cell: cell)
    
        cell.addSubview(imageView)
        cell.insertSubview(cellTitle, belowSubview: imageView)
        cell.bringSubviewToFront(cellTitle)
}

    
    
    func buildCellTitle(cell: UICollectionViewCell)-> UILabel {
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
    ct.text = "Title"
        // Set Cell title
        self.cellTitle = ct
        return ct
    }


/*
func assembleComponents(cell: UICollectionViewCell) -> UIView
{
    var mv: UIView? = UIView()
    var title: UILabel?
    
    
    
    return mv
}
*/
}

