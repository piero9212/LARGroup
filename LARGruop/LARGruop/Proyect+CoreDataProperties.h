//
//  Proyect+CoreDataProperties.h
//  LARGruop
//
//  Created by piero.sifuentes on 14/03/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Proyect.h"

NS_ASSUME_NONNULL_BEGIN

@interface Proyect (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *district;
@property (nullable, nonatomic, retain) NSNumber *flatsCount;
@property (nullable, nonatomic, retain) NSNumber *floorsCount;
@property (nullable, nonatomic, retain) NSString *imageURL;
@property (nullable, nonatomic, retain) NSNumber *latitud;
@property (nullable, nonatomic, retain) NSNumber *leftDepartaments;
@property (nullable, nonatomic, retain) NSString *listImageURL;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSString *mapDescription;
@property (nullable, nonatomic, retain) NSString *maxPrice;
@property (nullable, nonatomic, retain) NSNumber *maxRooms;
@property (nullable, nonatomic, retain) NSString *minPrice;
@property (nullable, nonatomic, retain) NSNumber *minRooms;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *panoramicImageURL;
@property (nullable, nonatomic, retain) NSString *proyectDescription;
@property (nullable, nonatomic, retain) NSNumber *state;
@property (nullable, nonatomic, retain) NSString *videoURL;
@property (nullable, nonatomic, retain) NSSet<ProyectFeature *> *features;
@property (nullable, nonatomic, retain) NSSet<Floor *> *floors;
@property (nullable, nonatomic, retain) NSSet<Outside *> *outsideImages;

@end

@interface Proyect (CoreDataGeneratedAccessors)

- (void)addFeaturesObject:(ProyectFeature *)value;
- (void)removeFeaturesObject:(ProyectFeature *)value;
- (void)addFeatures:(NSSet<ProyectFeature *> *)values;
- (void)removeFeatures:(NSSet<ProyectFeature *> *)values;

- (void)addFloorsObject:(Floor *)value;
- (void)removeFloorsObject:(Floor *)value;
- (void)addFloors:(NSSet<Floor *> *)values;
- (void)removeFloors:(NSSet<Floor *> *)values;

- (void)addOutsideImagesObject:(Outside *)value;
- (void)removeOutsideImagesObject:(Outside *)value;
- (void)addOutsideImages:(NSSet<Outside *> *)values;
- (void)removeOutsideImages:(NSSet<Outside *> *)values;

@end

NS_ASSUME_NONNULL_END
