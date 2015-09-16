//
//  LoginConnectionManager.h
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "GenericConnectionManager.h"

@interface LoginConnectionManager : GenericConnectionManager

+ (void)cancelLoginRequests;

+ (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                  success:(void (^) (NSDictionary *responseDictionary))success
                  failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure;

+ (void)logoutWithCompletion:(void (^) ())completion;


@end
