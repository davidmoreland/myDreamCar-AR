//
//  myInventoryCollectionView.swift
//  myDreamCar
//
//  Created by David on 7/21/18.
//  Copyright © 2018 DigitalSuccess-Systems. All rights reserved.
//

import UIKit
import SceneKit
import CoreData


class MyInventoryCollectionView: UICollectionViewController, UIPopoverPresentationControllerDelegate, UIGestureRecognizerDelegate {
    
   
    var selectedCell: UICollectionViewCell!
    var selectedAssetName: String!
   
    var flowLayout: UICollectionViewLayout!

    override func viewDidLoad() {
        super.viewDidLoad()

        // build mainView
    /*
 1. create view
 2. add components
 3. add subview to view
 */
        
        flowLayout = ColumnFlowLayout()
        
        collectionView = UICollectionView(frame: (view.bounds), collectionViewLayout: flowLayout)
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       // collectionView.backgroundColor = UIColor.blue
        let collectionViewBackGroundImageView: UIImageView = UIImageView()
     let image = UIImage.init(named: "Rufwood.jpg")
        collectionViewBackGroundImageView.image = image
        collectionViewBackGroundImageView.alpha = 0.2
        collectionViewBackGroundImageView.frame = view.bounds
        
        view.addSubview(collectionView!)
        view.addSubview(collectionViewBackGroundImageView)
        
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(InventoryCell.self, forCellWithReuseIdentifier: "InventoryCell")
        
        // Do any additional setup after loading the view.
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        //Add touch
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyInventoryCollectionView.cellTapped))
        self.view.isUserInteractionEnabled = true
        tapGestureRecognizer.delegate = self
    
        self.view?.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
 
    @objc func cellTapped() {
        
        let previewAssetVC = AssetPreviewVC(size: CGSize(width: 1400, height: 800 ))
        
        previewAssetVC.modalPresentationStyle = .popover
        previewAssetVC.popoverPresentationController?.delegate = self
        previewAssetVC.popoverPresentationController?.sourceView = self.view
        previewAssetVC.selectedAssetName = self.selectedAssetName
        
        //set popoverReferce to Main View
      //  previewAssetVC.selectedObject =
        
        present(previewAssetVC, animated: true, completion: nil)
    
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
        
      //  print ("ImageArray: \(self.image)")
        return 12
    }

    
    // MARK: Delegate Methods
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InventoryCell", for: indexPath) as! InventoryCell
        var selectedCellIndex = indexPath.row
        // Configure the cell
    //test
        var data: NSManagedObject! 
        cell.setAttributes(forCell: cell, withDataSet: data)
      
        //retrieve Asset From Index
        
        // test
        if( indexPath.row == 0) {
            
            let image = UIImage.init(named: "Nissan_370z_perspective")
            let cellImageView = UIImageView()
            cell.cellImageView = cellImageView
            if( cell.cellImageView != nil)
            {
                cell.cellImageView.image = image
                
            }
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        
        
        return true
    }
   
 /*
    @IBAction func onRampBtnPressed(_ sender: UIButton) {
        let rampPickerVC = RampPickerVC(size: CGSize(width: 400, height: 550))
        rampPickerVC.rampPlacerVC = self
        rampPickerVC.modalPresentationStyle = .popover
        rampPickerVC.popoverPresentationController?.delegate = self
        present(rampPickerVC, animated: true, completion: nil)
        rampPickerVC.popoverPresentationController?.sourceView = sender
        rampPickerVC.popoverPresentationController?.sourceRect = sender.bounds
    }
    */
    
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
*/
    
    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        
        
    }
 

}
