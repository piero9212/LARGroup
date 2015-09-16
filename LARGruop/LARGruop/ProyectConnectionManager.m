//
//  ProyectConnectionManager.m
//  LARGruop
//
//  Created by piero.sifuentes on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectConnectionManager.h"

@implementation ProyectConnectionManager


+ (void)getAllProyectsWithsuccess:(void (^) (NSDictionary *responseDictionary))success
                          failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure;
{
    NSString * const getProyectPath = @"path";
    
    ServiceClient *client = [ServiceClient sharedClient];
    
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"",
                                nil];
    
    [client cancelAllHTTPOperationsWithMethod:@"GET" path:getProyectPath];
    [client startRequestMethod:RequestMethodGet url:getProyectPath parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        
    } failure:failure];
}


@end
