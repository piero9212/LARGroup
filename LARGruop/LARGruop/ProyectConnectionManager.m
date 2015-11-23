//
//  ProyectConnectionManager.m
//  LARGruop
//
//  Created by piero.sifuentes on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectConnectionManager.h"
#import "ServiceClient.h"

static NSString* const allProyectsPath = @"ws/getProyects";

@implementation ProyectConnectionManager


+ (void)getAllProyectsWithsuccess:(void (^) (NSDictionary *responseDictionary))success
                          failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure;
{
    
    ServiceClient *client = [ServiceClient sharedClient];
    NSDictionary *parameters = nil;
    [client cancelAllHTTPOperationsWithMethod:@"GET" path:allProyectsPath];
    [client startRequestMethod:RequestMethodGet url:allProyectsPath parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        
    } failure:failure];
}


@end
