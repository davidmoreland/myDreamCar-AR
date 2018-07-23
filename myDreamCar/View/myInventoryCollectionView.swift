//
//  myInventoryCollectionView.swift
//  myDreamCar
//
//  Created by David on 7/21/18.
//  Copyright © 2018 DigitalSuccess-Systems. All rights reserved.
//

import UIKit
import SceneKit



class MyInventoryCollectionView: UICollectionViewController {
    

    
   // var SceneView: SCNView!
    var flowLayout: UICollectionViewLayout!

    override func viewDidLoad() {
        super.viewDidLoad()

        // test
     //   print("Image Array: \(self.image)")
        
        flowLayout = ColumnFlowLayout()
        
        collectionView = UICollectionView(frame: (view.bounds), collectionViewLayout: flowLayout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       // collectionView.backgroundColor = UIColor.blue
        let collectionViewBackGroundImageView: UIImageView = UIImageView()
     let image = UIImage.init(named: "Rufwood.jpg")
        collectionViewBackGroundImageView.image = image
        collectionViewBackGroundImageView.alpha = 0.2
        collectionViewBackGroundImageView.frame = view.bounds
        
        view.addSubview(collectionView)
        view.addSubview(collectionViewBackGroundImageView)
        
        
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(InventoryCell.self, forCellWithReuseIdentifier: "InventoryCell")
        

        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    
  //  var image: UIImage = UIImage.init(named: "test.png")!
    
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
      //  print ("ImageArray: \(self.image)")
        return 25
    }

    
    // MARK: Delegate Methods
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InventoryCell", for: indexPath) as! InventoryCell
    
        // Configure the cell
        // cell.backgroundColor = UIColor.cyan
        cell.setAttributes(cell: cell)
        
        print("IndexPath.row: \(String(describing: UIImage.init(named: "Rufwood.jpg")))")
       // cell.imageView.image = self.image
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        
        
        return true
    }
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
