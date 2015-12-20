//
//  Proyect.h
//  LARGruop
//
//  Created by piero.sifuentes on 18/12/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Flat, Outside, Plant, ProyectFeature, Rate;

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
@property (nonatomic, retain) NSString * panoramicImageURL;
@property (nonatomic, retain) NSString * proyectDescription;
@property (nonatomic, retain) NSString * videoURL;
@property (nonatomic, retain) NSSet *features;
@property (nonatomic, retain) NSSet *flats;
@property (nonatomic, retain) NSSet *outsideImages;
@property (nonatomic, retain) NSSet *plants;
@property (nonatomic, retain) NSSet *rates;
@end

@interface Proyect (CoreDataGeneratedAccessors)

- (void)addFeaturesObject:(ProyectFeature *)value;
- (void)removeFeaturesObject:(ProyectFeature *)value;
- (void)addFeatures:(NSSet *)values;
- (void)removeFeatures:(NSSet *)values;

- (void)addFlatsObject:(Flat *)value;
- (void)removeFlatsObject:(Flat *)value;
- (void)addFlats:(NSSet *)values;
- (void)removeFlats:(NSSet *)values;

- (void)addOutsideImagesObject:(Outside *)value;
- (void)removeOutsideImagesObject:(Outside *)value;
- (void)addOutsideImages:(NSSet *)values;
- (void)removeOutsideImages:(NSSet *)values;

- (void)addPlantsObject:(Plant *)value;
- (void)removePlantsObject:(Plant *)value;
- (void)addPlants:(NSSet *)values;
- (void)removePlants:(NSSet *)values;

- (void)addRatesObject:(Rate *)value;
- (void)removeRatesObject:(Rate *)value;
- (void)addRates:(NSSet *)values;
- (void)removeRates:(NSSet *)values;

@end
