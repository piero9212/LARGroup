//
//  LoginTranslator.h
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>


@class User;

@interface LoginTranslator : NSObject

+ (void)userDictionary:(NSDictionary *)userDictionary toUserEntity:(User *)user;
+ (void)recipientDictionary:(NSDictionary *)userDictionary toUserEntity:(User *)user;



@end
