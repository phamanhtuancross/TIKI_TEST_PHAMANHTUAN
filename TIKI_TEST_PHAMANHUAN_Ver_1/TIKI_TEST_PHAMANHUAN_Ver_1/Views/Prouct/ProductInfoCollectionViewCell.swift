//
//  ProductInfoCollectionViewCell.swift
//  TIKI_TEST_PHAMANHUAN_Ver_1
//
//  Created by LAP12217 on 3/28/19.
//  Copyright © 2019 LAP12217. All rights reserved.
//

import UIKit

class ProductInfoCollectionViewCell: UICollectionViewCell {
    
    let productIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let productKeyWord: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.makeBoundBorder(CornerRadius: 16, BorderColor: UIColor.white, BorderWith: 1)
    
        let attributes = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor : UIColor.white,
        ]
        
        textView.attributedText = NSAttributedString(string: "a", attributes: attributes)
        return textView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        self.backgroundColor = UIColor.white
        
        self.addSubview(productIcon)
        self.setProductIconConstraints()
        
        self.addSubview(productKeyWord)
        setProductKeyWordConstraints()
    }
    
    private func setProductIconConstraints(){
        self.productIcon.backgroundColor = UIColor.white
        self.productIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        self.productIcon.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        self.productIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        self.productIcon.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -80).isActive = true
    }
    
    private func setProductKeyWordConstraints(){
        self.productKeyWord.backgroundColor = UIColor.red
        self.productKeyWord.topAnchor.constraint(equalTo: self.productIcon.bottomAnchor, constant: 8).isActive = true
        self.productKeyWord.leftAnchor.constraint(equalTo: self.productIcon.leftAnchor).isActive = true
        self.productKeyWord.rightAnchor.constraint(equalTo: self.productIcon.rightAnchor).isActive = true
        self.productKeyWord.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    public func setData(ProductKeyWord keyword: String!, ProductIconURl iconUrl :String!){
        self.productKeyWord.text = keyword
        self.productKeyWord.centerText()
        downloadImage(from: URL(string: iconUrl)!)
    }
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.productIcon.image = UIImage(data: data)
            }
        }
    }
    
    
    
}
