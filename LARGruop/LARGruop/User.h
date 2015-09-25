//
//  User.h
//  LARGruop
//
//  Created by piero.sifuentes on 25/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"


@interface User : Entity

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * profileImageURL;
@property (nonatomic, retain) NSString * username;

@end
