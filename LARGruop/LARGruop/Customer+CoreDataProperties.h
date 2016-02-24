//
//  Customer+CoreDataProperties.h
//  LARGruop
//
//  Created by piero.sifuentes on 24/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Customer.h"

NS_ASSUME_NONNULL_BEGIN

@interface Customer (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSNumber *interestLevel;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *phoneNumber;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSSet<Rate *> *rates;

@end

@interface Customer (CoreDataGeneratedAccessors)

- (void)addRatesObject:(Rate *)value;
- (void)removeRatesObject:(Rate *)value;
- (void)addRates:(NSSet<Rate *> *)values;
- (void)removeRates:(NSSet<Rate *> *)values;

@end

NS_ASSUME_NONNULL_END
