//
//  Flat.h
//  LARGruop
//
//  Created by piero.sifuentes on 18/12/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Floor, Plant, Proyect, Rate;

@interface Flat : Entity

@property (nonatomic, retain) NSString * flatDetail;
@property (nonatomic, retain) NSString * flatImageURL;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * posX;
@property (nonatomic, retain) NSString * posY;
@property (nonatomic, retain) NSString * projectUID;
@property (nonatomic, retain) NSString * size;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) Floor *floors;
@property (nonatomic, retain) Plant *plant;
@property (nonatomic, retain) Proyect *proyect;
@property (nonatomic, retain) NSSet *rates;
@end

@interface Flat (CoreDataGeneratedAccessors)

- (void)addRatesObject:(Rate *)value;
- (void)removeRatesObject:(Rate *)value;
- (void)addRates:(NSSet *)values;
- (void)removeRates:(NSSet *)values;

@end
