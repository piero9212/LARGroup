//
//  LoginConnectionManager.m
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "LoginConnectionManager.h"
#import "ServiceClient.h"
#import "User.h"

static NSString* const loginPath = @"ws/login?username=%@&password=%@";
static NSString* const editUserPath = @"ws/editUser?id=%@&username=%@&password=%@&email=%@&phone=%@&cell_phone=%@&type=%@&image=%@";


@implementation LoginConnectionManager


+ (void)cancelLoginRequestsWithUsername:(NSString *)username
                               password:(NSString *)password
{
    [[ServiceClient sharedClient] cancelAllHTTPOperationsWithMethod:@"GET" path:[NSString stringWithFormat:loginPath,username,password]];
}

+ (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                  success:(void (^) (NSDictionary *responseDictionary))success
                  failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    NSDictionary *parameters = nil;
    NSString* path = [NSString stringWithFormat:loginPath,username,password];
    
    ServiceClient *client = [ServiceClient sharedClient];
    [client cancelAllHTTPOperationsWithMethod:@"GET" path:path];
    [client.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    client.requestSerializer = [AFJSONRequestSerializer serializer];
    [client startRequestMethod:RequestMethodGet url:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:failure];
    
}

+ (void)logoutWithCompletion:(void (^) ())completion
{
    
}

+ (void)apiEditUserWithName:(NSString *)name
                   password:(NSString *)password
                      email:(NSString *)email
                      phone:(NSString *)phone
                mobilePhone:(NSString *)mobilePhone
                       User:(User*)user
                    success:(void (^) (NSDictionary *responseDictionary))success
                    failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSDictionary *parameters = nil;
    NSString* path = [NSString stringWithFormat:editUserPath,user.uid,user.username,password,email, phone,mobilePhone,user.type,user.imageURL];
    
    ServiceClient *client = [ServiceClient sharedClient];
    [client cancelAllHTTPOperationsWithMethod:@"GET" path:path];
    [client.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    client.requestSerializer = [AFJSONRequestSerializer serializer];
    [client startRequestMethod:RequestMethodGet url:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:failure];
}


@end
