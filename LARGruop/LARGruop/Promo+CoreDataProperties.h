//
//  Promo+CoreDataProperties.h
//  LARGruop
//
//  Created by piero.sifuentes on 25/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Promo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Promo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *promoDescription;

@end

NS_ASSUME_NONNULL_END
