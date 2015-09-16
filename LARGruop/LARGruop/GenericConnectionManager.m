//
//  GenericConnectionManager.m
//  LARGruop
//
//  Created by Piero on 15/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "GenericConnectionManager.h"

@implementation GenericConnectionManager

//+ (void)setDefaultXHaikuAuthHeader
//{
//    ServiceClient *client = [ServiceClient sharedClient];
//    [client.requestSerializer setValue:X_HAIKU_AUTH_HEADER_DEFAULT_VALUE forHTTPHeaderField:@"x-haiku-auth"];
//    //[client setDefaultHeader:@"x-haiku-auth" value:X_HAIKU_AUTH_HEADER_DEFAULT_VALUE];
//}
//
//+ (void)setXHaikuAuthHeaderWithToken:(NSString *)token userId:(NSString *)userId
//{
//    HaikuClient *client = [HaikuClient sharedClient];
//    client.oauthToken = token;
//    
//    //[client setDefaultHeader:@"x-haiku-auth" value:X_HAIKU_AUTH_HEADER_VALUE(userId, token)];
//    [client.requestSerializer setValue:X_HAIKU_AUTH_HEADER_VALUE(userId, token) forHTTPHeaderField:@"x-haiku-auth"];
//}

+ (AFNetworkReachabilityStatus)reachabilityStatus
{
    return [AFNetworkReachabilityManager sharedManager].reachable?AFNetworkReachabilityStatusReachableViaWiFi:AFNetworkReachabilityStatusNotReachable;
}

+ (void)cancelAllPreviousRequests
{
    ServiceClient *client = [ServiceClient sharedClient];
    [client.operationQueue cancelAllOperations];
}

+ (BOOL)networkAvailable{
    AFNetworkReachabilityStatus reachabilityStatus = [GenericConnectionManager reachabilityStatus];
    return reachabilityStatus != AFNetworkReachabilityStatusNotReachable;
}

+ (NSString*)getRequestMethod:(RequestMethod)method
{
    NSString *result = nil;
    switch (method) {
        case RequestMethodGet:
            result = @"GET";
            break;
        case RequestMethodPost:
            result = @"POST";
            break;
        case RequestMethodPut:
            result = @"PUT";
            break;
        case RequestMethodDelete:
            result = @"DELETE";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected FormatType."];
    }
    return result;
}


@end
