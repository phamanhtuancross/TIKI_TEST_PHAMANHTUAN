//
//  ProductServerAPI.swift
//  TIKI_TEST_PHAMANHUAN_Ver_1
//
//  Created by LAP12217 on 3/28/19.
//  Copyright © 2019 LAP12217. All rights reserved.
//

import Foundation
import Alamofire

class ProductServerAPI{
    static let shared = ProductServerAPI()
    
    init() {
    }
    
    public func getImagesInfoFromTikiDumServer(CompletionHander : @escaping (_ products:[Product] )->Void){
        Alamofire.request(ServerInfoConstant.TIKI_IAMGES_SERVER_URL).responseJSON{
            response in
            
                if let result = response.result.value{
                    let items = (result as! [String: AnyObject])["keywords"]! as! [[String: AnyObject]]
                    
                    var products: [Product] = []
                    for item in items{
                        let product = Product(ProductKey: (item["keyword"] as! String), ProductIconURL: item["icon"] as! String)
                        products.append(product)
                    }
                    
                    CompletionHander(products)
                    
                }
            
        }
    }
}
