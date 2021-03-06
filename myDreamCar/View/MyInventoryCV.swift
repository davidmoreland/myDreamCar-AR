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
    var selectedCell: InventoryCell!
    var selectedAssetName: String!
    var flowLayout: UICollectionViewLayout!
    var selectedAsset: Asset!
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
            self.selectedCell = self.collectionView?.cellForItem(at: indexPath) as? InventoryCell
          //  let cellItem = indexPath.item
         //   if cellItem != nil
         //   {
            print("Cell Item #: \(indexPath.item)")
         //   }
            if (self.selectedCell.cellTitle) != nil
            {
            print("Cell Title: \(String(describing: self.selectedCell.cellTitle))")
            }
                //  self.selectedAssetName = selectedAsset.name
    
        //  commented out to try segue
          /*  let assetPreviewVC = AssetPreviewVC(size: CGSize(width: 1400, height: 1000 ))
        
        assetPreviewVC.modalPresentationStyle = .popover
        assetPreviewVC.popoverPresentationController?.delegate = self
        assetPreviewVC.popoverPresentationController?.sourceView = self.view
        assetPreviewVC.selectedAssetName = self.selectedAssetName
        assetPreviewVC.selectedSceneName = "art.scnassets/Nissan370Z2013ActualSize.scn"
        //set popoverReferce to Main View
     assetPreviewVC.selectedAsset = selectedAsset
    //    previewAssetVC.WorldViewVC = WorldViewVC()
// present(assetPreviewVC, animated: true, completion: nil)
 */
            performSegue(withIdentifier: "showAssetPreviewScreen", sender: self)
 
    }

 
}
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAssetPreviewScreen" {
           let previewAssetVC = segue.destination as! AssetPreviewVC
        previewAssetVC.modalPresentationStyle = .popover
   //     previewAssetVC.popoverPresentationController?.delegate = self
        previewAssetVC.popoverPresentationController?.sourceView = self.view
        previewAssetVC.selectedAssetName = self.selectedAssetName
        previewAssetVC.selectedSceneName = "art.scnassets/Nissan370Z2013ActualSize.scn"
          //  previewAssetVC.size.width = 1400
          //  previewAssetVC.size.height = 800
        //set popoverReferce to Main View
        previewAssetVC.selectedAsset = selectedAsset
            print("CV: Selected Asset: \\(selectedAsset)")
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
        print("CV: Num Items: \(String(describing: assets?.count))")
       // return assets.count
        return assets!.count
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
     */
 

}

