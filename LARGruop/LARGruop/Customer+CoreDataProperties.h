//
//  Customer+CoreDataProperties.h
//  LARGruop
//
//  Created by piero.sifuentes on 14/03/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Customer.h"

NS_ASSUME_NONNULL_BEGIN

@interface Customer (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *cellPhone;
@property (nullable, nonatomic, retain) NSString *comment;
@property (nullable, nonatomic, retain) NSNumber *dni;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSNumber *interestLevel;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *phoneNumber;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSSet<Quote *> *quotes;

@end

@interface Customer (CoreDataGeneratedAccessors)

- (void)addQuotesObject:(Quote *)value;
- (void)removeQuotesObject:(Quote *)value;
- (void)addQuotes:(NSSet<Quote *> *)values;
- (void)removeQuotes:(NSSet<Quote *> *)values;

@end

NS_ASSUME_NONNULL_END