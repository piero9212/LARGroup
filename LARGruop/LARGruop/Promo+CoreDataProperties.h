//
//  Promo+CoreDataProperties.h
//  LARGruop
//
//  Created by piero.sifuentes on 4/03/16.
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
@property (nullable, nonatomic, retain) NSSet<Quote *> *quotes;

@end

@interface Promo (CoreDataGeneratedAccessors)

- (void)addQuotesObject:(Quote *)value;
- (void)removeQuotesObject:(Quote *)value;
- (void)addQuotes:(NSSet<Quote *> *)values;
- (void)removeQuotes:(NSSet<Quote *> *)values;

@end

NS_ASSUME_NONNULL_END
