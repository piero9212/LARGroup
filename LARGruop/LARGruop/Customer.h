//
//  Customer.h
//  LARGruop
//
//  Created by piero.sifuentes on 11/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class MarketRates;

@interface Customer : Entity

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSNumber * interestLevel;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) MarketRates *marketRates;

@end
