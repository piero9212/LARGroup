//
//  Quote+CoreDataProperties.h
//  LARGruop
//
//  Created by piero.sifuentes on 14/03/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Quote.h"

NS_ASSUME_NONNULL_BEGIN

@interface Quote (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *clientID;
@property (nullable, nonatomic, retain) NSString *flatID;
@property (nullable, nonatomic, retain) NSNumber *interestLevel;
@property (nullable, nonatomic, retain) NSString *promoID;
@property (nullable, nonatomic, retain) NSString *proyectID;
@property (nullable, nonatomic, retain) Customer *customer;

@end

NS_ASSUME_NONNULL_END
