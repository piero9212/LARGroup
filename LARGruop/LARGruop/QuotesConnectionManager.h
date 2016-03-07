//
//  QuotesConnectionManager.h
//  LARGruop
//
//  Created by Piero on 1/03/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "BaseConnectionManager.h"

@interface QuotesConnectionManager : BaseConnectionManager

+ (void)getAllQuotesWithsuccess:(void (^) (NSDictionary *responseDictionary))success
                         failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure;

+(void)createNewQuoteWithClientID:(NSString *)clientID
                    departamentID:(NSString *)departamentID
                    promoID:(NSString *)promoID
                         success:(void (^) (NSDictionary *responseDictionary))success
                         failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure;

+(void)editNewQuoteWithQuoteID:(NSString *)quoteID
                      ClientID:(NSString *)clientID
                 departamentID:(NSString *)departamentID
                       success:(void (^) (NSDictionary *responseDictionary))success
                       failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure;

+ (void)cancelAllQuotesRequest;

@end
