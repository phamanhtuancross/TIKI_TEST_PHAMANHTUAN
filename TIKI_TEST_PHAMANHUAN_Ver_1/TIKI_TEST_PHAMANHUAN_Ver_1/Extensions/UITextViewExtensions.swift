//
//  UITextViewExtensions.swift
//  TIKI_TEST_PHAMANHUAN_Ver_1
//
//  Created by LAP12217 on 3/28/19.
//  Copyright © 2019 LAP12217. All rights reserved.
//

import UIKit
extension UITextView {
    
    func centerText() {
        self.textAlignment = .center
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
}
