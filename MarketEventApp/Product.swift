//
//  Product.swift
//  MarketEventApp
//
//  Created by Rahul Patle on 1/4/16.
//  Copyright © 2016 CODECOOP. All rights reserved.
//

import Foundation
class Product {
    fileprivate var _productId: Int!
    fileprivate var _name: String!
    fileprivate var _description: String!
    fileprivate var _price: String!
    fileprivate var _country: String!
    fileprivate var _culture: String!
    fileprivate var _artist: String!
    fileprivate var _category: String!
    fileprivate var _boothId: Int!
    
    fileprivate var _productUrl: String!
    
    var name: String {
        return _name
    }
    
    var productId: Int {
        return _productId
    }
    
    var description: String {
        return _description
    }
    
    var price: String {
        return _price
    }
    
    var country: String {
        return _country
    }
    
    
    
    init(name: String, productId: Int, price: String, description: String ){
        self._productId = productId
        self._name = name
        self._price = price
        self._description = description
        
        _productUrl = "\(URL_BASE)\(URL_PRODUCT)\(self.productId)/"
    }
    
    func downloadProductDetails(_ completed: DownloadComplete){
        
    }
}
