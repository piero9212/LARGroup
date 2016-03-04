//
//  ClientConnectionManager.m
//  LARGruop
//
//  Created by Piero on 29/11/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//

#import "ClientConnectionManager.h"
#import "ServiceClient.h"

static NSString* const allClientsPath = @"ws/getClients";
static NSString* const createClientPath = @"ws/newClient?name=%@&email=%@&phone=%@&interest=%@&comment=%@";
static NSString* const editClientPath = @"ws/editClient?id=%@&name=%@&email=%@&phone=%@&interest=%@&comment=%@";


@implementation ClientConnectionManager

+(void)getAllClientsWithsuccess:(void (^)(NSDictionary *))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    ServiceClient *client = [ServiceClient sharedClient];
    NSDictionary *parameters = nil;
    [client cancelAllHTTPOperationsWithMethod:@"GET" path:allClientsPath];
    [client startRequestMethod:RequestMethodGet url:allClientsPath parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        
    } failure:failure];
}

+(void)apiCreateNewClientWithName:(NSString *)name
                                email:(NSString *)email
                                phone:(NSString *)phone
                             interest:(NSString *)interest
                              comment:(NSString *)comment
                         success:(void (^)(NSDictionary *))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    ServiceClient *client = [ServiceClient sharedClient];
    NSDictionary *parameters = nil;
    NSString* path = [NSString stringWithFormat:createClientPath,name,email,phone,interest,comment];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [client cancelAllHTTPOperationsWithMethod:@"GET" path:path];
    [client startRequestMethod:RequestMethodGet url:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        
    } failure:failure];
}

+(void)apiEditClientWithID:(NSString *)uid
                      name:(NSString *)name
                           email:(NSString *)email
                           phone:(NSString *)phone
                        interest:(NSString *)interest
                         comment:(NSString *)comment
                         success:(void (^) (NSDictionary *responseDictionary))success
                         failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure
{
    ServiceClient *client = [ServiceClient sharedClient];
    NSDictionary *parameters = nil;
    NSString* path = [NSString stringWithFormat:editClientPath,uid,name,email,phone,interest,comment];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [client cancelAllHTTPOperationsWithMethod:@"GET" path:path];
    [client startRequestMethod:RequestMethodGet url:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        
    } failure:failure];
}


+(void)cancelALLClientsRequest
{
    [[ServiceClient sharedClient] cancelAllHTTPOperationsWithMethod:@"GET" path:allClientsPath];
}

@end
