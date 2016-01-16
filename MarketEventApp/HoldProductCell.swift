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
    
    var timerTable = [Int: NSTimer]()
    var id :Int = 0
    
    func startTimer(target: AnyObject, selector: Selector, interval: NSTimeInterval) -> Int {
        var timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: target, selector: selector, userInfo: nil, repeats: true)
        
        id += 1
        timerTable[id] = timer
        return id
    }
    
    /*! Stop a timer of an id
    */
    func stopTimer(id: Int) {
        if let timer = timerTable[id] {
            if timer.valid {
                timer.invalidate()
            }
        }
    }
    
    /*! Returns timer instance of an id
    */
    func getTimer(id: Int) -> NSTimer? {
        return timerTable[id]
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func configureCell(holdProduct: HoldProduct) {
        itemNameLbl.text = holdProduct.name
        boothIDLbl?.text = holdProduct.boothID
        timerLbl.text = holdProduct.timeLeft
        
    }
}

