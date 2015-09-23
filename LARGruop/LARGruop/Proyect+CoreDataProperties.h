//
//  Proyect+CoreDataProperties.h
//  LARGruop
//
//  Created by Piero on 22/09/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Proyect.h"

NS_ASSUME_NONNULL_BEGIN

@interface Proyect (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *district;
@property (nullable, nonatomic, retain) NSString *imageURL;
@property (nullable, nonatomic, retain) NSNumber *leftDepartaments;
@property (nullable, nonatomic, retain) NSString *listImageURL;
@property (nullable, nonatomic, retain) NSString *mapDescription;
@property (nullable, nonatomic, retain) NSString *mapImageURL;
@property (nullable, nonatomic, retain) NSString *maxPrice;
@property (nullable, nonatomic, retain) NSString *minPrice;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) id pointCoordinate;
@property (nullable, nonatomic, retain) NSString *proyectDescription;
@property (nullable, nonatomic, retain) NSNumber *latitud;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSSet<ProyectFeature *> *features;
@property (nullable, nonatomic, retain) NSSet<Flat *> *flatPlains;
@property (nullable, nonatomic, retain) MarketRates *marketRates;
@property (nullable, nonatomic, retain) NSSet<Outside *> *outsideImages;

@end

@interface Proyect (CoreDataGeneratedAccessors)

- (void)addFeaturesObject:(ProyectFeature *)value;
- (void)removeFeaturesObject:(ProyectFeature *)value;
- (void)addFeatures:(NSSet<ProyectFeature *> *)values;
- (void)removeFeatures:(NSSet<ProyectFeature *> *)values;

- (void)addFlatPlainsObject:(Flat *)value;
- (void)removeFlatPlainsObject:(Flat *)value;
- (void)addFlatPlains:(NSSet<Flat *> *)values;
- (void)removeFlatPlains:(NSSet<Flat *> *)values;

- (void)addOutsideImagesObject:(Outside *)value;
- (void)removeOutsideImagesObject:(Outside *)value;
- (void)addOutsideImages:(NSSet<Outside *> *)values;
- (void)removeOutsideImages:(NSSet<Outside *> *)values;

@end

NS_ASSUME_NONNULL_END
