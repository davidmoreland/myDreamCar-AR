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
   
  

  //  var cellWidth: CGFloat!
  //  var cellHeight: CGFloat!
    func setImageViewAttributes(cell: UICollectionViewCell)->UIImageView
    {
        //let imageView: UIImageView = {
        let iv = UIImageView()
        iv.bounds = CGRect(x: 5.0, y: 5.0, width: cell.frame.width, height: cell.frame.height)
        //iv.sizeToFit()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 15
    
        iv.image = UIImage.init(named: "graphPaper.jpg")
        // test
        iv.backgroundColor = UIColor.brown
        return iv
    }
      //  return imageView
    
  /*
    required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    
    
     {
        self.cellWidth = self.cellWidth - 5.0
        self.cellHeight = self.cellHeight - 5.0
    }
 
   
    */
        
    func setAttributes(cell: UICollectionViewCell) {
    
      
    
      //  cell.backgroundColor = UIColor.cyan
       // cell.addSubview(self.imageView)
        
      //  let image: UIImage = UIImage.init(named: "Rufwood.jpg")!
       // self.imageView.image = image
        
        // let imageView: UIImageView = UIImageView()
        
      //  var image = UIImage(named: "test.png")!
      //  imageView.image = image
   //     self.addSubview(cellView!)
    //addSubview(self.imageView)
    //  setup()
      let imageView = setImageViewAttributes(cell: cell)
        print("ImageView Frame Width: \(imageView.frame.width)")
        
      //  imageView.frame.height = 25.0
        cell.addSubview(imageView)
}


}

