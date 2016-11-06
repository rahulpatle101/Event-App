//
//  SearchResultVC.swift
//  MarketEventApp
//
//  Created by Rahul Patle on 1/4/16.
//  Copyright © 2016 CODECOOP. All rights reserved.
//

import UIKit

class SearchResultVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var searchCategory: String!
    var products = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()

        print(searchCategory)
        self.title = searchCategory
        tableView.delegate = self
        tableView.dataSource = self
        
        let product = Product(name: "1. Test Product really good", productId: 1, price: "$30", description: "Lorem Ipsum Blah Blah Blah Lorem Ipsum Blah Blah Blah Lorem Ipsum Blah Blah Blah ")
        
        let product2 = Product(name: "2. Test Product really good", productId: 2, price: "$100", description: "Lorem Ipsum Blah Blah Blah Lorem Ipsum Blah Blah Blah Lorem Ipsum Blah Blah Blah ")
        
        let product3 = Product(name: "3. Test Product really good", productId: 3, price: "$200", description: "Lorem Ipsum Blah Blah Blah Lorem Ipsum Blah Blah Blah Lorem Ipsum Blah Blah Blah ")
        
        products.append(product)
        products.append(product2)
        products.append(product3)
        
        tableView.reloadData()
        
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell") as? ResultCell {
            cell.configureCell(product)
            return cell
        } else {
            let cell = ResultCell()
            cell.configureCell(product)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let product: Product!
        
        product = products[indexPath.row]
        
        performSegue(withIdentifier: "ProductDetailVC", sender: product)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductDetailVC" {
            if let detailsVC = segue.destination as? ProductDetailVC {
                if let product = sender as? Product {
                    detailsVC.product = product
                }
            }
        }
    }
}
