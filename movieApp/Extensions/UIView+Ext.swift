//
//  UIView+Ext.swift
//  movieApp
//
//  Created by Ios Developer on 24.10.2022.
//

import UIKit

extension UIView {
    func pinToEdgesOf(view:UIView){
        NSLayoutConstraint.activate([
        
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
    }
}
