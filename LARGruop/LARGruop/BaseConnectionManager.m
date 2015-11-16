//
//  BaseConnectionManager.m
//  LARGruop
//
//  Created by Piero on 8/11/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//

#import "BaseConnectionManager.h"
#import "ServiceClient.h"
#import "ApplicationConstants.h"

@implementation BaseConnectionManager


+ (void)setDefaultAuthHeader
{
    ServiceClient *client = [ServiceClient sharedClient];
    [client.requestSerializer setValue:GLAR_CONNECTION_HEADER_DEFAULT_VALUE forHTTPHeaderField:@"Connection"];
    [client.requestSerializer setValue:GLAR_ACCEPT_ENCODING_HEADER_DEFAULT_VALUE forHTTPHeaderField:@"Accept-Encoding"];
    [client.requestSerializer setValue:GLAR_USER_AGENT_HEADER_DEFAULT_VALUE forHTTPHeaderField:@"User-Agent"];
}

+ (AFNetworkReachabilityStatus)reachabilityStatus
{
    return [AFNetworkReachabilityManager sharedManager].reachable?AFNetworkReachabilityStatusReachableViaWiFi:AFNetworkReachabilityStatusNotReachable;
}

+ (void)cancelAllPreviousRequests
{
    ServiceClient *client = [ServiceClient sharedClient];
    [client.operationQueue cancelAllOperations];
}

+ (BOOL)networkAvailable
{
    AFNetworkReachabilityStatus reachabilityStatus = [BaseConnectionManager reachabilityStatus];
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
