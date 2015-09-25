//
//  Floor.h
//  LARGruop
//
//  Created by piero.sifuentes on 25/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Flat, MarketRates;

@interface Floor : Entity

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) Flat *flat;
@property (nonatomic, retain) NSSet *marketRates;
@end

@interface Floor (CoreDataGeneratedAccessors)

- (void)addMarketRatesObject:(MarketRates *)value;
- (void)removeMarketRatesObject:(MarketRates *)value;
- (void)addMarketRates:(NSSet *)values;
- (void)removeMarketRates:(NSSet *)values;

@end
