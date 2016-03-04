//
//  LoginConnectionManager.h
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "BaseConnectionManager.h"

@class User;

@interface LoginConnectionManager : BaseConnectionManager

+ (void)cancelLoginRequestsWithUsername:(NSString *)username
                               password:(NSString *)password;

+ (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                  success:(void (^) (NSDictionary *responseDictionary))success
                  failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure;

+ (void)logoutWithCompletion:(void (^) ())completion;

+ (void)apiEditUserWithName:(NSString *)name
                   password:(NSString *)password
                          email:(NSString *)email
                          phone:(NSString *)phone
                mobilePhone:(NSString *)mobilePhone
                       User:(User*)user
                        success:(void (^) (NSDictionary *responseDictionary))success
                        failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure;
@end
