//
//  Plant.h
//  LARGruop
//
//  Created by piero.sifuentes on 18/12/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Flat, Proyect;

@interface Plant : Entity

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * plainURL;
@property (nonatomic, retain) NSSet *flats;
@property (nonatomic, retain) Proyect *proyect;
@end

@interface Plant (CoreDataGeneratedAccessors)

- (void)addFlatsObject:(Flat *)value;
- (void)removeFlatsObject:(Flat *)value;
- (void)addFlats:(NSSet *)values;
- (void)removeFlats:(NSSet *)values;

@end
