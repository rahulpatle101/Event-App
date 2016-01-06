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
    
    func configureCell(artist: Artist) {
        self.artist = artist
        
        
        nameLbl.text = self.artist.name.capitalizedString
//        thumbImg.image = UIImage(named:
    }
}
