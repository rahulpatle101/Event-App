//
//  HoldProduct+CoreDataProperties.swift
//  MarketEventApp
//
//  Created by Rahul Patle on 1/14/16.
//  Copyright © 2016 CODECOOP. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension HoldProduct {

    @NSManaged var boothID: String?
    @NSManaged var name: String?
    @NSManaged var time: String?
    @NSManaged var timeLeft: String?
    @NSManaged var timeAlert: String?

}
