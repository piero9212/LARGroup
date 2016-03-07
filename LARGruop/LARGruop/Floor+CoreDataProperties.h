//
//  Floor+CoreDataProperties.h
//  LARGruop
//
//  Created by Piero on 6/03/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Floor.h"

NS_ASSUME_NONNULL_BEGIN

@interface Floor (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *image;
@property (nullable, nonatomic, retain) NSNumber *imageHeight;
@property (nullable, nonatomic, retain) NSNumber *imageWidth;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *number;
@property (nullable, nonatomic, retain) NSString *proyectID;
@property (nullable, nonatomic, retain) NSSet<Flat *> *flats;
@property (nullable, nonatomic, retain) Proyect *proyect;

@end

@interface Floor (CoreDataGeneratedAccessors)

- (void)addFlatsObject:(Flat *)value;
- (void)removeFlatsObject:(Flat *)value;
- (void)addFlats:(NSSet<Flat *> *)values;
- (void)removeFlats:(NSSet<Flat *> *)values;

@end

NS_ASSUME_NONNULL_END
