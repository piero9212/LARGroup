//
//  BaseConnectionManager.h
//  LARGruop
//
//  Created by Piero on 8/11/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestMethod.h"
#import <AFNetworking/AFNetworking.h>

@interface BaseConnectionManager : NSObject

+ (void)setDefaultAuthHeader;
+ (AFNetworkReachabilityStatus)reachabilityStatus;
+ (void)cancelAllPreviousRequests;
+ (BOOL)networkAvailable;
+ (NSString*)getRequestMethod:(RequestMethod)method;

@end
