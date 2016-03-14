//
//  Entity+CoreDataProperties.h
//  LARGruop
//
//  Created by piero.sifuentes on 14/03/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Entity.h"

NS_ASSUME_NONNULL_BEGIN

@interface Entity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *changeState;
@property (nullable, nonatomic, retain) NSDate *created;
@property (nullable, nonatomic, retain) NSDate *lastModified;
@property (nullable, nonatomic, retain) NSString *uid;

@end

NS_ASSUME_NONNULL_END
