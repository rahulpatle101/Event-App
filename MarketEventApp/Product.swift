//
//  Product.swift
//  MarketEventApp
//
//  Created by Rahul Patle on 1/4/16.
//  Copyright © 2016 CODECOOP. All rights reserved.
//

import Foundation
class Product {
    private var _productId: Int!
    private var _name: String!
    private var _description: String!
    private var _price: String!
    private var _country: String!
    private var _culture: String!
    private var _artist: String!
    private var _category: String!
    private var _boothId: Int!
    
    private var _productUrl: String!
    
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
    
    func downloadProductDetails(completed: DownloadComplete){
        
    }
}
