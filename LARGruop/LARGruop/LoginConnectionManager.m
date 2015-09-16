//
//  LoginConnectionManager.m
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "LoginConnectionManager.h"

@implementation LoginConnectionManager

+ (void)cancelLoginRequests
{
    //NSString *requestMethod = [LoginConnectionManager getRequestMethod:HLM_RequestMethodGet];
    [[ServiceClient sharedClient] cancelAllHTTPOperationsWithMethod:@"GET" path:@"sessions"];
    [[ServiceClient sharedClient] cancelAllHTTPOperationsWithMethod:@"GET" path:@"sessions/domains"];
}

+ (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                  success:(void (^) (NSDictionary *responseDictionary))success
                  failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString * const loginPath = @"sessions";
    
    ServiceClient *client = [ServiceClient sharedClient];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:password, @"password", username, @"username", nil];
    //    NSString *requestMethod = [LoginConnectionManager getRequestMethod:HLM_RequestMethodPost];
    //    NSURLRequest *request = [client requestWithMethod:requestMethod path:loginPath parameters:parameters];
    //
    //    AFHTTPRequestOperation *requestOperation = [client HTTPRequestOperationWithRequest:request
    //                                                                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //                                                                                   success(responseObject);
    //                                                                               }
    //                                                                               failure:failure
    //                                                ];
    //
    //    [client enqueueHTTPRequestOperation:requestOperation];
    [client startRequestMethod:RequestMethodPost url:loginPath parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:failure];
    //    return requestOperation;
}


+ (void)logoutWithCompletion:(void (^) ())completion
{
    NSString * const logoutPath = @"sessions";
    
    ServiceClient *client = [ServiceClient sharedClient];
    //    NSString *requestMethod = [LoginConnectionManager getRequestMethod:HLM_RequestMethodDelete];
    //    NSURLRequest *request = [client requestWithMethod:requestMethod path:logoutPath parameters:nil];
    //
    //    AFHTTPRequestOperation *requestOperation = [client HTTPRequestOperationWithRequest:request
    //                                                                               success:completion
    //                                                                               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //#ifdef HAIKU_DEBUG
    //                                                                                   //NSLog(@"Logout Error detected - Code: %i", operation.response.statusCode);
    //#endif
    //                                                                                   completion();
    //                                                                               }
    //                                                ];
    //
    //    [client enqueueHTTPRequestOperation:requestOperation];
    [client startRequestMethod:RequestMethodDelete
                           url:logoutPath
                    parameters:nil
                       success:completion
                       failure:^(AFHTTPRequestOperation *operation, NSError *error){
                           completion();
                       }];
    //    return requestOperation;
}


@end
