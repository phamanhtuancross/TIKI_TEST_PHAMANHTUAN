//
//  TikiTestMainViewController.swift
//  TIKI_TEST_PHAMANHUAN_Ver_1
//
//  Created by LAP12217 on 3/28/19.
//  Copyright © 2019 LAP12217. All rights reserved.
//

import UIKit

class TikiTestMainViewController: UIViewController ,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    let backgroundColors : [UIColor] =  [#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)]
    
    var products:[Product] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellConstant.PRODUCT_INFO_CELL_ID, for: indexPath) as! ProductInfoCollectionViewCell
        
        let keywordData = products[indexPath.item]
        cell.productKeyWord.backgroundColor = backgroundColors[indexPath.item % backgroundColors.count]
        cell.setData(ProductKeyWord: keywordData.keyword!, ProductIconURl: keywordData.iconUrl!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        
        let productKeyword = products[indexPath.item].keyword!
        if countNumberOfWordFormString(StringInput: productKeyword) > 1{
            var cellWidth = getWithOfCellByProductKeyWord(productKeyWord: productKeyword)
            if cellWidth < self.view.frame.width/3 {
                cellWidth =  self.view.frame.width/3
            }
            return CGSize(width: cellWidth, height: self.productInfoColelctionView.frame.height)
        }
        else{
             return CGSize(width: self.view.frame.width/3, height: self.productInfoColelctionView.frame.height)
        }
    }

    let productInfoColelctionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        
        DispatchQueue.main.async {
            ProductServerAPI.shared.getImagesInfoFromTikiDumServer(){
                products in
                self.products = products
                self.productInfoColelctionView.reloadData()
            }
        }
            
        setupViews()
     
        // Do any additional setup after loading the view.
    }
    
    private func setupDelegates(){
        self.productInfoColelctionView.delegate = self
        self.productInfoColelctionView.dataSource = self
    }
    private func setupViews(){
        self.view.backgroundColor = UIColor.white
        self.productInfoColelctionView.backgroundColor = UIColor.white
        
        self.view.addSubview(productInfoColelctionView)
        setProductInfoCollectionViewConstraints()
        
        self.productInfoColelctionView.register(ProductInfoCollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCellConstant.PRODUCT_INFO_CELL_ID)
        
    }
    
    private func setProductInfoCollectionViewConstraints(){
        self.productInfoColelctionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 48).isActive = true
        self.productInfoColelctionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.productInfoColelctionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.productInfoColelctionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/4).isActive = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func countNumberOfWordFormString(StringInput str: String!) -> Int{
        var numberOfWord = 0
        let components = str.components(separatedBy: .whitespacesAndNewlines)
        let words = components.filter { !$0.isEmpty }
        
        numberOfWord = words.count
        return numberOfWord
    }

    private func getWithOfCellByProductKeyWord(productKeyWord keyword: String) -> CGFloat{
        return ((keyword.size(withAttributes:[.font: UIFont.boldSystemFont(ofSize: 14)]).width)  + 128)/2
    }
}
