//
//  ServiceClient.h
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

static NSString * const BaseURLString = @"theString";

typedef enum {
    RequestMethodGet = 0,
    RequestMethodPost,
    RequestMethodPut,
    RequestMethodDelete
}RequestMethod;

@interface ServiceClient : AFHTTPRequestOperationManager

@property (strong, nonatomic) NSString *oauthToken;

+ (ServiceClient *)sharedClient;
- (void)setBaseURL:(NSURL *)baseURL;
- (void)startRequestMethod:(RequestMethod)method
                       url:(NSString *)url
                parameters:(NSDictionary *)params
                   success:(void (^)(AFHTTPRequestOperation *, id responseObject))success
                   failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)cancelAllHTTPOperationsWithMethod:(NSString*)method path:(NSString*)path;

@end
