//
//  PromoService.m
//  LARGruop
//
//  Created by Piero on 29/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "PromoService.h"
#import "Promo.h"
#import "PromoConnectionManager.h"
#import "KeyConstants.h"
#import "ErrorCodes.h"
#import <MagicalRecord/MagicalRecord.h>
#import "ProyectTranslator.h"

@implementation PromoService


+ (PromoService *)sharedService
{
    static PromoService *_sharedProyectService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedProyectService = [[PromoService alloc] init];
    });
    return _sharedProyectService;
}

- (void)cancelAllPromoRequest
{
    [PromoConnectionManager cancelALLPromoRequest];
}

+ (void)setFilterProyects:(NSMutableArray *)filterPromos
{
    
}

- (NSArray *)getAllPromos
{
    NSArray *temppromos = [Promo MR_findAllSortedBy:@"name" ascending:YES inContext: [NSManagedObjectContext MR_defaultContext]];
    NSMutableArray* promos = [[NSMutableArray alloc]init];
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"uid" ascending:NO];
    NSArray *sortedDescArray = [temppromos sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    
    for (Promo *promo in sortedDescArray)
    {
        if(!([[promos valueForKeyPath:@"uid"] containsObject:promo.uid]))
        {
            [promos addObject:promo];
        }
    }
    

    return promos;
}

- (void)apiGetPromosWithErrorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion
{
    [PromoConnectionManager getAllPromosWithsuccess:^(NSDictionary *responseDictionary)     {
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
                
                [Promo MR_truncateAllInContext:localContext];
                for (NSDictionary *promoDictionary in promoResponse)
                {
                    id promoIdObject = [promoDictionary valueForKeyPath:@"id"];
                    NSString *promoID = ([promoIdObject isKindOfClass:[NSNumber class]])? [NSString stringWithFormat:@"%@", promoIdObject] : nil;
                    Promo *promo = [Promo MR_createEntityInContext:localContext];
                    promo.uid = promoID;
                    [ProyectTranslator promoDictionary:promoDictionary toPromoEntity:promo context:localContext];
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

@end
