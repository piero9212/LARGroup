//
//  GenericConnectionManager.h
//  LARGruop
//
//  Created by Piero on 15/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "NotificationConstants.h"
#import "ServiceClient.h"

@interface GenericConnectionManager : NSObject

//+ (void)setDefaultXHaikuAuthHeader;
//+ (void)setXHaikuAuthHeaderWithToken:(NSString *)token userId:(NSString *)userId;
+ (AFNetworkReachabilityStatus)reachabilityStatus;
+ (void)cancelAllPreviousRequests;
+ (BOOL)networkAvailable;
+ (NSString*)getRequestMethod:(RequestMethod)method;

@end
