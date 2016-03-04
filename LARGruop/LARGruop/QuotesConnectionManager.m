//
//  QuotesConnectionManager.m
//  LARGruop
//
//  Created by Piero on 1/03/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "QuotesConnectionManager.h"
#import "ServiceClient.h"

static NSString* const allQuotesPath = @"ws/getQuotes";
static NSString* const createQuotePath = @"ws/newQuote?client_id=%@&department_id=%@";
static NSString* const editQuotePath = @"ws/editQuote?quote_id=%@&client_id=%@&department_id=%@";

@implementation QuotesConnectionManager


+ (void)getAllQuotesWithsuccess:(void (^) (NSDictionary *responseDictionary))success
                        failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure
{
    ServiceClient *client = [ServiceClient sharedClient];
    NSDictionary *parameters = nil;
    [client cancelAllHTTPOperationsWithMethod:@"GET" path:allQuotesPath];
    [client startRequestMethod:RequestMethodGet url:allQuotesPath parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        
    } failure:failure];

}

+(void)createNewQuoteWithClientID:(NSString *)clientID
                    departamentID:(NSString *)departamentID
                          success:(void (^) (NSDictionary *responseDictionary))success
                          failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    ServiceClient *client = [ServiceClient sharedClient];
    NSDictionary *parameters = nil;
    NSString* path = [NSString stringWithFormat:createQuotePath,clientID,departamentID];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [client cancelAllHTTPOperationsWithMethod:@"GET" path:path];
    [client startRequestMethod:RequestMethodGet url:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        
    } failure:failure];
}

+(void)editNewQuoteWithQuoteID:(NSString *)quoteID
                      ClientID:(NSString *)clientID
                 departamentID:(NSString *)departamentID
                       success:(void (^) (NSDictionary *responseDictionary))success
                       failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure
{
    ServiceClient *client = [ServiceClient sharedClient];
    NSDictionary *parameters = nil;
    NSString* path = [NSString stringWithFormat:editQuotePath,quoteID,clientID,departamentID];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [client cancelAllHTTPOperationsWithMethod:@"GET" path:path];
    [client startRequestMethod:RequestMethodGet url:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        
    } failure:failure];
    
}

+ (void)cancelAllQuotesRequest
{
    [[ServiceClient sharedClient] cancelAllHTTPOperationsWithMethod:@"GET" path:allQuotesPath];
}


@end
