//
//  FlatFeature+CoreDataProperties.h
//  LARGruop
//
//  Created by Piero on 6/03/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FlatFeature.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlatFeature (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *featureDescription;
@property (nullable, nonatomic, retain) Flat *flat;

@end

NS_ASSUME_NONNULL_END
