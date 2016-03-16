//
//  Promo+CoreDataProperties.h
//  LARGruop
//
//  Created by piero.sifuentes on 14/03/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Promo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Promo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *discount;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *promoDescription;
@property (nullable, nonatomic, retain) NSNumber *time;
@property (nullable, nonatomic, retain) NSNumber *discountValue;

@end

NS_ASSUME_NONNULL_END
