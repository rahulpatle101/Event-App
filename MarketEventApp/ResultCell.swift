//
//  ResultCell.swift
//  MarketEventApp
//
//  Created by Rahul Patle on 1/4/16.
//  Copyright © 2016 CODECOOP. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(product: Product){
        titleLbl.text = product.name
        descLbl.text = product.description
        priceLbl.text = product.price
        
//        productImg.layer.cornerRadius = productImg.frame.size.width / 1
//        productImg.clipsToBounds = true
    }
    

}
