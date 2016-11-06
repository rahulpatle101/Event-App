//
//  HoldProduct+CoreDataProperties.h
//  MarketEventApp
//
//  Created by Rahul Patle on 1/12/16.
//  Copyright © 2016 CODECOOP. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HoldProduct.h"

NS_ASSUME_NONNULL_BEGIN

@interface HoldProduct (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *boothID;
@property (nullable, nonatomic, retain) NSNumber *time;

@end

NS_ASSUME_NONNULL_END
