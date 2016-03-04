//
//  PromoConnectionManager.m
//  LARGruop
//
//  Created by Piero on 1/03/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "PromoConnectionManager.h"
#import "ServiceClient.h"

static NSString* const allPromosPath = @"ws/getPromotions";

@implementation PromoConnectionManager

+ (void)getAllPromosWithsuccess:(void (^) (NSDictionary *responseDictionary))success failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure
{
    ServiceClient *client = [ServiceClient sharedClient];
    NSDictionary *parameters = nil;
    [client cancelAllHTTPOperationsWithMethod:@"GET" path:allPromosPath];
    [client startRequestMethod:RequestMethodGet url:allPromosPath parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        
    } failure:failure];
}

+ (void)cancelALLPromoRequest
{
    [[ServiceClient sharedClient] cancelAllHTTPOperationsWithMethod:@"GET" path:allPromosPath];
}

@end
