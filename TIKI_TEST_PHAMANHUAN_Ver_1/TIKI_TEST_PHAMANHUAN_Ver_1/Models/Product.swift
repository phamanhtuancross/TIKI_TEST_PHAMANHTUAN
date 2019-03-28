//
//  Product.swift
//  TIKI_TEST_PHAMANHUAN_Ver_1
//
//  Created by LAP12217 on 3/28/19.
//  Copyright © 2019 LAP12217. All rights reserved.
//

import Foundation
class Product{
    public var keyword: String?
    public var iconUrl: String?
    
    init(ProductKey key: String!, ProductIconURL iconUrl : String!) {
        self.keyword  = key
        self.iconUrl  = iconUrl
    }
}
