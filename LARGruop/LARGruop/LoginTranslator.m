//
//  LoginTranslator.m
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "LoginTranslator.h"
#import "User.h"

@implementation LoginTranslator

+ (void)userDictionary:(NSDictionary *)userDictionary toUserEntity:(User *)user
{
    id uidObject = [userDictionary valueForKeyPath:@"id"];
    user.uid = ([uidObject isKindOfClass:[NSNumber class]])? [NSString stringWithFormat:@"%@", uidObject] : nil;
    
//    id loginObject = [userDictionary valueForKeyPath:@"login"];
//    user.login = ([loginObject isKindOfClass:[NSString class]])? loginObject : nil;
//    
//    id firstNameObject = [userDictionary valueForKeyPath:@"first_name"];
//    user.firstName = ([firstNameObject isKindOfClass:[NSString class]])? firstNameObject : nil;
//    
//    id lastNameObject = [userDictionary valueForKeyPath:@"last_name"];
//    user.lastName = ([lastNameObject isKindOfClass:[NSString class]])? lastNameObject : nil;
//    
//    id fullNameObject = [userDictionary valueForKeyPath:@"full_name"];
//    user.fullName = ([fullNameObject isKindOfClass:[NSString class]])? fullNameObject : nil;
//    
//    id emailObject = [userDictionary valueForKeyPath:@"email"];
//    user.email = ([emailObject isKindOfClass:[NSString class]])? emailObject : nil;
//    
//    id googleEmailObject = [userDictionary valueForKeyPath:@"google_email_address"];
//    user.googleEmail = ([googleEmailObject isKindOfClass:[NSString class]])? googleEmailObject : nil;
//    
//    id userTypeObject = [userDictionary valueForKeyPath:@"user_type"];
//    user.userType = ([userTypeObject isKindOfClass:[NSString class]])? userTypeObject : nil;
//    
//    id avatarURLObject = [userDictionary valueForKeyPath:@"avatar_url"];
//    user.avatarURL = ([avatarURLObject isKindOfClass:[NSString class]])? avatarURLObject : nil;
    

    
}

+ (void)recipientDictionary:(NSDictionary *)userDictionary toUserEntity:(User *)user
{
    id uidObject = [userDictionary valueForKeyPath:@"id"];
    user.uid = ([uidObject isKindOfClass:[NSNumber class]])? [NSString stringWithFormat:@"%@", uidObject] : nil;
    
//    id fullNameObject = [userDictionary valueForKeyPath:@"full_name"];
//    user.fullName = ([fullNameObject isKindOfClass:[NSString class]])? fullNameObject : nil;
//    
//    id avatarURLObject = [userDictionary valueForKeyPath:@"avatar_url"];
//    user.avatarURL = ([avatarURLObject isKindOfClass:[NSString class]])? avatarURLObject : nil;
}



@end
