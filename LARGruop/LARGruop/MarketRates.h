//
//  MarketRates.h
//  LARGruop
//
//  Created by piero.sifuentes on 21/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Customer, Proyect;

@interface MarketRates : Entity

@property (nonatomic, retain) NSNumber * interestLevel;
@property (nonatomic, retain) NSString * marketRateID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * promo;
@property (nonatomic, retain) Customer *customer;
@property (nonatomic, retain) Proyect *proyect;

@end
