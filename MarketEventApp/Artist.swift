//
//  Artist.swift
//  MarketEventApp
//
//  Created by Rahul Patle on 1/6/16.
//  Copyright © 2016 CODECOOP. All rights reserved.
//

import Foundation

class Artist {
    private var _name: String!
    private var _id: Int!
    private var _medium: String!
    private var _country: String!
    private var _type: String!
    private var _impact: Int!
    private var _wImpact: Int!
    private var _mImpact: Int!
    
    var name: String {
        return _name
    }
    
    var id: Int {
        return _id
    }
    
    var medium: String {
        return _medium
    }
    
    var country: String {
        return _country
    }
    
    var type: String {
        return _type
    }
    
    var impact: Int {
        return _impact
    }
    
    var wImpact: Int {
        return _wImpact
    }
    
    var mImpact: Int {
        return _mImpact
    }
    
    init(name: String, id: Int) {
        self._id = id
        self._name = name
    }
}