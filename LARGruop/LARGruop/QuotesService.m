//
//  QuotesService.m
//  LARGruop
//
//  Created by Piero on 29/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "QuotesService.h"
#import "QuotesConnectionManager.h"
#import "Quote.h"
#import "KeyConstants.h"
#import "ErrorCodes.h"
#import <MagicalRecord/MagicalRecord.h>
#import "ProyectTranslator.h"

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
    
   NSArray *tempquotes = [Quote MR_findAllSortedBy:@"name" ascending:YES inContext: [NSManagedObjectContext MR_defaultContext]];
    NSMutableArray* quotes = [[NSMutableArray alloc]init];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"uid" ascending:NO];
    NSArray *sortedDescArray = [tempquotes sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    
    for (Quote *quote in sortedDescArray)
    {
        if(!([[quotes valueForKeyPath:@"uid"] containsObject:quote.uid]))
        {
            [quotes addObject:quote];
        }
    }
    
    
    return quotes;
}


- (void)apiGetQuotesWithErrorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion
{
    [QuotesConnectionManager getAllQuotesWithsuccess:^(NSDictionary *responseDictionary)     {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            NSArray *promoResponse = (NSArray*)responseDictionary;
            
            NSNumber *showAlertView = [NSNumber numberWithBool:YES];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:showAlertView, USER_INFO_SHOW_ALERT_VIEW, nil];
            id errorObject = [responseDictionary valueForKeyPath:@"error"];
            NSString *error = ([errorObject isKindOfClass:[NSString class]])? errorObject : nil;
            if([error isEqualToString:GET_PROYECTS_ERROR_KEY])
            {
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAllProyectsFailed object:self userInfo:userInfo];
                });
                return;
            }
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                
                [Quote MR_truncateAllInContext:localContext];
                for (NSDictionary *quoteDictionary in promoResponse)
                {
                    id quoteIdObject = [quoteDictionary valueForKeyPath:@"id"];
                    NSString *quoteID = ([quoteIdObject isKindOfClass:[NSNumber class]])? [NSString stringWithFormat:@"%@", quoteIdObject] : nil;
                    Quote *quote = [Quote MR_createEntityInContext:localContext];
                    quote.uid = quoteID;
                    [ProyectTranslator quoteDictionary:quoteDictionary toQuoteEntity:quote context:localContext];
                }
                
                
            } completion:^(BOOL contextDidSave, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAllClientsSucced object:self userInfo:userInfo];
                    completion(YES);
                });
            }];
        }
                       );}
                                            failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         NSNumber *showAlertView = [NSNumber numberWithBool:NO];
         
         if(operation && operation.response.statusCode == StatusCodeNoInternetConnection) {
             showAlertView = [NSNumber numberWithBool:YES];
         }
         else {
             self.requestFailureErrorHandler(operation, error, YES, nil);
         }
         
         NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:showAlertView, USER_INFO_SHOW_ALERT_VIEW, nil];
         dispatch_async(dispatch_get_main_queue(), ^(void){
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAllProyectsFailed object:self userInfo:userInfo];
         });
     }];

}

- (void)apiCreateQuoteWithClientID:(NSString *)clientID
                     departamentID:(NSString *)departamentID
                    errorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion
{
    [QuotesConnectionManager createNewQuoteWithClientID:clientID departamentID:departamentID success:^(NSDictionary *responseDictionary)     {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                
                NSNumber *showAlertView = [NSNumber numberWithBool:YES];
                NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:showAlertView, USER_INFO_SHOW_ALERT_VIEW, nil];
                id errorObject = [responseDictionary valueForKeyPath:@"error"];
                NSString *error = ([errorObject isKindOfClass:[NSString class]])? errorObject : nil;
                if([error isEqualToString:GET_PROYECTS_ERROR_KEY] || !responseDictionary)
                {
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNewClientFailed object:self userInfo:userInfo];
                    });
                    return;
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(YES);
                    });
                    
                }
            }completion:^(BOOL contextDidSave, NSError *error) {
            }];
        }
                       );}
                                                failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         NSNumber *showAlertView = [NSNumber numberWithBool:NO];
         
         if(operation && operation.response.statusCode == StatusCodeNoInternetConnection) {
             showAlertView = [NSNumber numberWithBool:YES];
         }
         else {
             self.requestFailureErrorHandler(operation, error, YES, nil);
         }
         
         NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:showAlertView, USER_INFO_SHOW_ALERT_VIEW, nil];
         dispatch_async(dispatch_get_main_queue(), ^(void){
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNewClientFailed object:self userInfo:userInfo];
         });
     }];

}


@end
