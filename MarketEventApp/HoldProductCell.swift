//
//  HoldProductCell.swift
//  MarketEventApp
//
//  Created by Rahul Patle on 1/12/16.
//  Copyright © 2016 CODECOOP. All rights reserved.
//

import UIKit

class HoldProductCell: UITableViewCell {
    
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var boothIDLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    
    var timerTable = [Int: Timer]()
    var id :Int = 0
    
    func startTimer(_ target: AnyObject, selector: Selector, interval: TimeInterval) -> Int {
        let timer = Timer.scheduledTimer(timeInterval: interval, target: target, selector: selector, userInfo: nil, repeats: true)
        
        id += 1
        timerTable[id] = timer
        return id
    }
    
    /*! Stop a timer of an id
    */
    func stopTimer(_ id: Int) {
        if let timer = timerTable[id] {
            if timer.isValid {
                timer.invalidate()
            }
        }
    }
    
    /*! Returns timer instance of an id
    */
    func getTimer(_ id: Int) -> Timer? {
        return timerTable[id]
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func configureCell(_ holdProduct: HoldProduct) {
        itemNameLbl.text = holdProduct.name
        boothIDLbl?.text = holdProduct.boothID
        timerLbl.text = holdProduct.timeLeft
        
    }
}

