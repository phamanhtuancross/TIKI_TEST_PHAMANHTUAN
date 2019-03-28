//
//  UIViewExtension.swift
//  TIKI_TEST_PHAMANHUAN_Ver_1
//
//  Created by LAP12217 on 3/28/19.
//  Copyright © 2019 LAP12217. All rights reserved.
//

import UIKit
extension UIView{
    public func makeBoundBorder(CornerRadius cornerRadius: Float, BorderColor borderColor: UIColor, BorderWith borderWith: Float){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = CGFloat(borderWith)
    }
}
