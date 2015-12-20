//
//  ClientConnectionManager.h
//  LARGruop
//
//  Created by Piero on 29/11/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//

#import "BaseConnectionManager.h"

@interface ClientConnectionManager : BaseConnectionManager

+ (void)getAllClientsWithsuccess:(void (^) (NSDictionary *responseDictionary))success
                          failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure;

+(void)createNewUserWithUsername:(NSString *)name
                           email:(NSString *)email
                           phone:(NSString *)phone
                        interest:(NSString *)interest
                         comment:(NSString *)comment
                         success:(void (^) (NSDictionary *responseDictionary))success
                        failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure;
+ (void)cancelALLClientsRequest;
@end
