//
//  Outside+CoreDataProperties.h
//  LARGruop
//
//  Created by Piero on 22/11/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Outside.h"

NS_ASSUME_NONNULL_BEGIN

@interface Outside (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imageURL;
@property (nullable, nonatomic, retain) NSString *outsideDescription;
@property (nullable, nonatomic, retain) Proyect *proyect;

@end

NS_ASSUME_NONNULL_END
