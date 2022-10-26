//
//  UICollectionView+Ext.swift
//  movieApp
//
//  Created by Ios Developer on 25.10.2022.
//

import UIKit

extension UICollectionView{
    
    func reloadOnMainThread(){
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
