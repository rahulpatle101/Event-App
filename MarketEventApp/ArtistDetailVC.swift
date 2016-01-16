//
//  ArtistDetailVC.swift
//  MarketEventApp
//
//  Created by Rahul Patle on 1/6/16.
//  Copyright © 2016 CODECOOP. All rights reserved.
//

import UIKit

class ArtistDetailVC: UIViewController {
    
    @IBOutlet var artistLocationLbl: UILabel!
    @IBOutlet var artTypeLbl: UILabel!
    @IBOutlet var boothIdLbl: UILabel!
    @IBOutlet var contactInfoLbl: UILabel!
    @IBOutlet var artistNameLbl: UILabel!
    var artistDetail: Artist!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(artistDetail.name)
        
        artistNameLbl.text = artistDetail.name
    }




}
