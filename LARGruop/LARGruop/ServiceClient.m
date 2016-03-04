//
//  ServiceClient.m
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ServiceClient.h"
#import "ApplicationConstants.h"

@interface ServiceClient()

@property (readwrite, strong, nonatomic) NSURL *baseURL;

@end

@implementation ServiceClient

@synthesize baseURL = _baseURL;

+ (ServiceClient *)sharedClient
{
    static ServiceClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ServiceClient alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
    });
    return _sharedClient;
}

-(void)startRequestMethod:(RequestMethod)method
                      url:(NSString *)url
               parameters:(NSDictionary *)params
                  success:(void (^)(AFHTTPRequestOperation *, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [ServiceClient sharedClient];
    NSString *fullURL = [[self.baseURL absoluteString] stringByAppendingString:url];
    switch (method) {
        case RequestMethodGet:
            [manager GET:fullURL parameters:params success:success failure:failure];
            break;
        case RequestMethodPost:
            [manager POST:fullURL parameters:params success:success failure:failure];
            break;
        case RequestMethodPut:
            [manager PUT:fullURL parameters:params success:success failure:failure];
            break;
        case RequestMethodDelete:
            [manager DELETE:fullURL parameters:params success:success failure:failure];
            break;
        default:
            break;
    }
}

- (void)cancelAllHTTPOperationsWithMethod:(NSString*)method path:(NSString*)path{
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:(method ?: @"GET") URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString] parameters:@{} error:nil];
    NSString *URLStringToMatched = [[request URL] absoluteString];
    
    for (NSOperation *operation in [self.operationQueue operations]) {
        if (![operation isKindOfClass:[AFHTTPRequestOperation class]]) {
            continue;
        }
        
        NSURL *matchymatchyURL = [[(AFHTTPRequestOperation *)operation request] URL];
        NSURLComponents *components = [[NSURLComponents alloc] initWithURL:matchymatchyURL resolvingAgainstBaseURL:YES];
        components.query = nil;
        components.fragment = nil;
        
        matchymatchyURL = [components URL];
        
        BOOL hasMatchingMethod = !method || [method isEqualToString:[[(AFHTTPRequestOperation *)operation request] HTTPMethod]];
        BOOL hasMatchingURL = [[matchymatchyURL absoluteString] isEqualToString:URLStringToMatched];
        
        if (hasMatchingMethod && hasMatchingURL) {
            [operation cancel];
        }
    }
}

@end
