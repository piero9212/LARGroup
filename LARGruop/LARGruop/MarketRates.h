//
//  MarketRates.h
//  LARGruop
//
//  Created by piero.sifuentes on 11/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Customer;

@interface MarketRates : Entity

@property (nonatomic, retain) Customer *customer;

@end
