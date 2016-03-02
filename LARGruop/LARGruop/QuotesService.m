//
//  QuotesService.m
//  LARGruop
//
//  Created by Piero on 29/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "QuotesService.h"
#import "QuotesConnectionManager.h"

@implementation QuotesService


+ (QuotesService *)sharedService
{
    static QuotesService *_sharedLoginService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLoginService = [[QuotesService alloc] init];
    });
    return _sharedLoginService;
}

- (void)cancelAllQuotesRequests
{
    [QuotesConnectionManager cancelAllQuotesRequest];
}

- (NSArray *)getAllQuotes
{
    NSArray *quotes;// = [Customer MR_findAllSortedBy:@"name" ascending:YES inContext: [NSManagedObjectContext MR_defaultContext]];
    return quotes;
}


- (void)apiGetQuotesWithErrorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion
{
    
}

- (void)apiCreateQuoteWithClientID:(NSString *)clientID
                     departamentID:(NSString *)departamentID
                    errorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion
{
}

- (void)apiEditQuoteWithQuoteID:(NSString *)quoteID
                       ClientID:(NSString *)clientID
                  departamentID:(NSString *)departamentID
                 errorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion
{
}

@end
