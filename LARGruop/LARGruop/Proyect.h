//
//  Proyect.h
//  LARGruop
//
//  Created by piero.sifuentes on 23/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Flat, MarketRates, Outside, ProyectFeature;

@interface Proyect : Entity

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * district;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSNumber * latitud;
@property (nonatomic, retain) NSNumber * leftDepartaments;
@property (nonatomic, retain) NSString * listImageURL;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * mapDescription;
@property (nonatomic, retain) NSString * mapImageURL;
@property (nonatomic, retain) NSString * maxPrice;
@property (nonatomic, retain) NSString * minPrice;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) id pointCoordinate;
@property (nonatomic, retain) NSString * proyectDescription;
@property (nonatomic, retain) NSSet *features;
@property (nonatomic, retain) NSSet *flatPlains;
@property (nonatomic, retain) MarketRates *marketRates;
@property (nonatomic, retain) NSSet *outsideImages;
@end

@interface Proyect (CoreDataGeneratedAccessors)

- (void)addFeaturesObject:(ProyectFeature *)value;
- (void)removeFeaturesObject:(ProyectFeature *)value;
- (void)addFeatures:(NSSet *)values;
- (void)removeFeatures:(NSSet *)values;

- (void)addFlatPlainsObject:(Flat *)value;
- (void)removeFlatPlainsObject:(Flat *)value;
- (void)addFlatPlains:(NSSet *)values;
- (void)removeFlatPlains:(NSSet *)values;

- (void)addOutsideImagesObject:(Outside *)value;
- (void)removeOutsideImagesObject:(Outside *)value;
- (void)addOutsideImages:(NSSet *)values;
- (void)removeOutsideImages:(NSSet *)values;

@end
