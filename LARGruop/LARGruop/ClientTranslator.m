//
//  ClientTranslator.m
//  LARGruop
//
//  Created by Piero on 29/11/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//

#import "ClientTranslator.h"

@implementation ClientTranslator

+ (void)clientDictionary:(NSDictionary *)clientDictionary toCustomerEntity:(Customer *)client context:(NSManagedObjectContext *)context
{
    id uidObject = [clientDictionary valueForKeyPath:@"id"];
    client.uid = ([uidObject isKindOfClass:[NSString class]])? uidObject: ((NSNumber*)uidObject).stringValue;
    
    id nameObject = [clientDictionary valueForKeyPath:@"name"];
    NSString* firstName;
    NSString* lastName;
    NSArray* nameArray = [nameObject componentsSeparatedByString: @" "];
    if(nameArray.count>=2)
    {
        firstName = [nameArray objectAtIndex: 0];
        lastName = [nameArray objectAtIndex: 1];
    }
    else if(nameArray.count==1)
    {
        firstName = [nameArray objectAtIndex:0];
        lastName = @"";
    }
    else
    {
        firstName = @"Cliente Nuevo";
        lastName =@"";
    }
    
    client.firstName = firstName;
    client.lastName = lastName;
    
    id phoneObject = [clientDictionary valueForKeyPath:@"phone"];
    client.phoneNumber = ([phoneObject isKindOfClass:[NSString class]])? phoneObject: nil;
    
    
    id emailObject = [clientDictionary valueForKeyPath:@"email"];
    client.email = ([emailObject isKindOfClass:[NSString class]])? emailObject: nil;
    
    //id commentObject = [clientDictionary valueForKeyPath:@"comment"];
    //client. = ([commentObject isKindOfClass:[NSString class]])? commentObject: nil;
    
    id interestLevelObject = [clientDictionary valueForKeyPath:@"interest"];
    client.interestLevel = ([interestLevelObject isKindOfClass:[NSNumber class]])? interestLevelObject: nil;
    
}
@end
