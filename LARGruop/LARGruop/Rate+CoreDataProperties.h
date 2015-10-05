//
//  Rate+CoreDataProperties.h
//  LARGruop
//
//  Created by Piero on 4/10/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Rate.h"

NS_ASSUME_NONNULL_BEGIN

@interface Rate (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *interestLevel;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Proyect *proyect;
@property (nullable, nonatomic, retain) Customer *customer;
@property (nullable, nonatomic, retain) Flat *flat;
@property (nullable, nonatomic, retain) Floor *floor;

@end

NS_ASSUME_NONNULL_END
