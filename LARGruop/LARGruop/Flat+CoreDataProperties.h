//
//  Flat+CoreDataProperties.h
//  LARGruop
//
//  Created by piero.sifuentes on 4/03/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Flat.h"

NS_ASSUME_NONNULL_BEGIN

@interface Flat (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *flatDetail;
@property (nullable, nonatomic, retain) NSString *flatImageURL;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *posX;
@property (nullable, nonatomic, retain) NSString *posY;
@property (nullable, nonatomic, retain) NSString *projectUID;
@property (nullable, nonatomic, retain) NSString *size;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSSet<FlatFeature *> *features;
@property (nullable, nonatomic, retain) Floor *floor;
@property (nullable, nonatomic, retain) Plant *plant;
@property (nullable, nonatomic, retain) Proyect *proyect;
@property (nullable, nonatomic, retain) Quote *quote;

@end

@interface Flat (CoreDataGeneratedAccessors)

- (void)addFeaturesObject:(FlatFeature *)value;
- (void)removeFeaturesObject:(FlatFeature *)value;
- (void)addFeatures:(NSSet<FlatFeature *> *)values;
- (void)removeFeatures:(NSSet<FlatFeature *> *)values;

@end

NS_ASSUME_NONNULL_END
