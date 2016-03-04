//
//  LoginTranslator.m
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "LoginTranslator.h"
#import "User.h"
#import "NSString+Utils.h"

@implementation LoginTranslator

+ (void)userDictionary:(NSDictionary *)userDictionary toUserEntity:(User *)user
{
    id uidObject = [userDictionary valueForKeyPath:@"id"];
    user.uid = ([uidObject isKindOfClass:[NSString class]])? uidObject: ((NSNumber*)uidObject).stringValue;
    
    id fullNameObject = [userDictionary valueForKeyPath:@"name"];
    
    if(fullNameObject && fullNameObject !=[NSNull class]  )
    {
        NSArray *components=[fullNameObject componentsSeparatedByString:@" "];
        if(components)
        {
            user.firstName  = components[0];
            if(components.count>1)
                user.lastName  = components[1];
        }
    }
    id usernameObject = [userDictionary valueForKeyPath:@"username"];
    user.username = ([usernameObject isKindOfClass:[NSString class]])? usernameObject: nil;
    
    id emailObject = [userDictionary valueForKeyPath:@"email"];
    user.email = ([emailObject isKindOfClass:[NSString class]])? emailObject: nil;
    
    id typeObject = [userDictionary valueForKeyPath:@"type"];
    user.type = ([typeObject isKindOfClass:[NSString class]])? typeObject: nil;
    
    id createdDateObject = [userDictionary valueForKeyPath:@"created_at"];
    NSDate* createdDate = ([createdDateObject isKindOfClass:[NSMutableString class]])?[NSString toDateFromDateString:createdDateObject] : nil;
    user.created = createdDate;
    
    id updatedDateObject = [userDictionary valueForKeyPath:@"updated_at"];
    NSDate* updateDate = ([updatedDateObject isKindOfClass:[NSMutableString class]])?[NSString toDateFromDateString:updatedDateObject] : nil;
    user.lastModified = updateDate;
    
    id cellPhoneObject = [userDictionary valueForKeyPath:@"cell_phone"];
    user.mobilePhone = ([usernameObject isKindOfClass:[NSString class]])? cellPhoneObject: nil;
    
    id phoneObject = [userDictionary valueForKeyPath:@"phone"];
    user.phone = ([usernameObject isKindOfClass:[NSString class]])? phoneObject: nil;
    
    id imageObject = [userDictionary valueForKeyPath:@"image"];
    user.imageURL = ([usernameObject isKindOfClass:[NSString class]])? imageObject: nil;
    user.imageURL = @"http://ia.media-imdb.com/images/M/MV5BMTY5NzY4NzgxNV5BMl5BanBnXkFtZTcwMzcyOTQwOQ@@._V1_UY317_CR4,0,214,317_AL_.jpg";
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
