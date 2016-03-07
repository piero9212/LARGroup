//
//  QuotesService.h
//  LARGruop
//
//  Created by Piero on 29/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "GenericService.h"

@interface QuotesService : GenericService


+ (QuotesService *)sharedService;

- (void)cancelAllQuotesRequests;

- (NSArray *)getAllQuotes;

- (void)apiGetQuotesWithErrorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion;

- (void)apiCreateQuoteWithClientID:(NSString *)clientID
                     departamentID:(NSString *)departamentID
                    promoID:(NSString *)promoID
                     errorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion;

- (void)apiEditQuoteWithQuoteID:(NSString *)quoteID
                       ClientID:(NSString *)clientID
                  departamentID:(NSString *)departamentID
                    errorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion;

@end
