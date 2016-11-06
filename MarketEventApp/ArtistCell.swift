//
//  ArtistCell.swift
//  MarketEventApp
//
//  Created by Rahul Patle on 1/6/16.
//  Copyright © 2016 CODECOOP. All rights reserved.
//

import UIKit

class ArtistCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var artist: Artist!
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ artist: Artist) {
        self.artist = artist
        
        
        nameLbl.text = self.artist.name.capitalized
//        thumbImg.image = UIImage(named:
    }
}
