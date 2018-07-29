//
//  columnFlowLayout.swift
//  myDreamCar
//
//  Created by David on 7/22/18.
//  Copyright © 2018 DigitalSuccess-Systems. All rights reserved.
//

import UIKit

class ColumnFlowLayout: UICollectionViewFlowLayout {
    // called when layout orientation changes
    override func prepare() {
        super.prepare()
        
        guard let cv = collectionView else {return}
        
        // Swift 5:      let availableWidth = cv.bounds.inset(by: cv.layoutMargins).size.width
        let availableWidth = cv.bounds.width - 20
    //    let availableWidth = cv.bounds.size.width
        let minColumnWidth = CGFloat(100)
        // Swift 5: let maxNumColumns = (availableWidth //Volumes/Mac_Seirra/Users/Pony/Desktop/Xcode_Projects_2018/myDreamCar-VR/myDreamCar/Assets.xcassetsminColumnWidth).rounded(.down)
        let maxNumColumns = (availableWidth / minColumnWidth).rounded(.down)
        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
        let cellHeight: CGFloat = 70.0
        
        let layoutSize = cellWidth * CGFloat(maxNumColumns)
        
        self.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        self.sectionInset = UIEdgeInsets(top: 100, left: 100 + (availableWidth - layoutSize), bottom:10.0, right: 10.0)
        print("cellWidth: \(cellWidth)")
        print("MaxNum Columns: \(maxNumColumns)")
        print("Available Width: \(availableWidth)")
        print("Left computed: \(25 + (availableWidth - layoutSize))")
        
        
        self.sectionInsetReference = .fromLayoutMargins
       
    }
}
