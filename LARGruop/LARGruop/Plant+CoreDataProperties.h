//
//  Plant+CoreDataProperties.h
//  LARGruop
//
//  Created by Piero on 22/11/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Plant.h"

NS_ASSUME_NONNULL_BEGIN

@interface Plant (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *plainURL;
@property (nullable, nonatomic, retain) NSSet<Flat *> *flats;
@property (nullable, nonatomic, retain) Proyect *proyect;

@end

@interface Plant (CoreDataGeneratedAccessors)

- (void)addFlatsObject:(Flat *)value;
- (void)removeFlatsObject:(Flat *)value;
- (void)addFlats:(NSSet<Flat *> *)values;
- (void)removeFlats:(NSSet<Flat *> *)values;

@end

NS_ASSUME_NONNULL_END
