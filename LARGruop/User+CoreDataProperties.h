//
//  User+CoreDataProperties.h
//  LARGruop
//
//  Created by Piero on 2/03/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *imageURL;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSString *cellPhone;
@property (nullable, nonatomic, retain) NSString *celular;
@property (nullable, nonatomic, retain) id image;

@end

NS_ASSUME_NONNULL_END
