//
//  ServiceClient.h
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "RequestMethod.h"

static NSString * const BaseURLString = @"http://45.55.152.89/grupolar/public/";

@interface ServiceClient : AFHTTPRequestOperationManager

+ (ServiceClient *)sharedClient;
- (void)setBaseURL:(NSURL *)baseURL;
- (void)startRequestMethod:(RequestMethod)method
                       url:(NSString *)url
                parameters:(NSDictionary *)params
                   success:(void (^)(AFHTTPRequestOperation *, id responseObject))success
                   failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)cancelAllHTTPOperationsWithMethod:(NSString*)method path:(NSString*)path;




@end
