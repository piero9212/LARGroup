//
//  User.h
//  LARGruop
//
//  Created by piero.sifuentes on 18/12/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"


@interface User : Entity

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * username;

@end
