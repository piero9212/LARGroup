//
//  Floor.h
//  LARGruop
//
//  Created by piero.sifuentes on 18/12/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Flat, Rate;

@interface Floor : Entity

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) Flat *flat;
@property (nonatomic, retain) NSSet *rates;
@end

@interface Floor (CoreDataGeneratedAccessors)

- (void)addRatesObject:(Rate *)value;
- (void)removeRatesObject:(Rate *)value;
- (void)addRates:(NSSet *)values;
- (void)removeRates:(NSSet *)values;

@end
