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
    
   var assets:[Asset]?
    var dataExists: Bool?
    var context = appDelegate.persistentContainer.viewContext
    var selectedCell: InventoryCell?
    var selectedAssetName: String?
    var flowLayout: UICollectionViewLayout!
    var selectedAsset: Asset?
    var assetPreviewVC: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
  
        // TEST - Create DUMMY DATA in MOC
     let testDataManager: TestData = TestData()
      testDataManager.createDummyData(context: DataManager.getMainManagedContext())

        flowLayout = ColumnFlowLayout()
        
        collectionView = UICollectionView(frame: (view.bounds), collectionViewLayout: flowLayout)
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (handleTap(_:)))
        
        
        self.view.isUserInteractionEnabled = true
        tapGestureRecognizer.delegate = self
    
        self.view?.addGestureRecognizer(tapGestureRecognizer)
    }
    
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        // build mainView
        /*
         1. create view
         2. add components
         3. add subview to view
         */

        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Asset>(entityName: "Asset")
        
        do {
             self.assets = try context.fetch(fetchRequest)
            print("CV: Successfully fetched data.")
            print("# of Assets: \(String(describing: assets?.count))")
            print("+++++++++++++++++++++++")
            print("CV: Retrieved Asset: \(assets![0])")
            
            // load 'assetNotFound'
            
        } catch {
            debugPrint("CV Could not Fetch: \(error.localizedDescription)")
               }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .popover
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true  // 1st
    }
  
    
    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
        // 2nd
        let touchPoint = gestureRecognizer.location(in: self.view)
        
        if let indexPath = self.collectionView?.indexPathForItem(at: touchPoint) {
            if let cellAtIndexPath = self.collectionView?.cellForItem(at: indexPath) as? InventoryCell {
            print("Cell Item #: \(indexPath.item)")
                print("Cell Title: \(String(describing: self.selectedCell?.cellTitle))")
      //  self.selectedAssetName = selectedAsset.name
            } else {
                print("Inventory 'selectedCell' is NIL")
            }
            
            performSegue(withIdentifier: "showAssetPreviewScreen", sender: self)
 
        }
 
}
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAssetPreviewScreen" {
           let previewAssetVC = segue.destination as! AssetPreviewVC
        previewAssetVC.modalPresentationStyle = .popover
   //     previewAssetVC.popoverPresentationController?.delegate = self
        previewAssetVC.popoverPresentationController?.sourceView = self.view
            // TODO: database fetch
        previewAssetVC.selectedAssetName = self.selectedAssetName
        previewAssetVC.selectedSceneName = "art.scnassets/370z_2013.scn"
            
            if selectedAsset != nil {
                
            
        previewAssetVC.selectedAsset = selectedAsset
            print("CV: Selected Asset: \\(selectedAsset)")
            } else {
                print("Inventory 'Selected Asset' is NIL")
            }
            }
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell Tapped: \(indexPath.item)")
    }
 
    
    /*
    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        
        //test
        print("Cell Tapped: \(indexPath.item)")
        let previewAssetVC = AssetPreviewVC(size: CGSize(width: 1400, height: 600 ))
        
        previewAssetVC.modalPresentationStyle = .popover
        previewAssetVC.popoverPresentationController?.delegate = self
        previewAssetVC.popoverPresentationController?.sourceView = self.view
        previewAssetVC.selectedAssetName = self.selectedAssetName
        previewAssetVC.selectedSceneName = "art.scnassets/Nissan370Z2013ActualSize.scn"
    }
    */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    
    
    // MARK: UICollectionViewDataSource
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if assets?.count != nil {
        
        print("CV: Num Items: \(String(describing: assets?.count))")
        return assets!.count
        } else {
            return 0
        }
    }

    
    // MARK: Delegate Methods
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InventoryCell", for: indexPath) as! InventoryCell
        
        // Configure the cell
        cell.setAttributesWith(dataSet: assets![indexPath.row])
        return cell
    }

    
    
// MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        
        return true
    }


 
    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    
    
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
    
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     */
 
}

