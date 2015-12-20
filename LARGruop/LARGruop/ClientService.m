//
//  ClientService.m
//  LARGruop
//
//  Created by Piero on 29/11/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//

#import "ClientService.h"
#import "ErrorCodes.h"
#import <MagicalRecord/MagicalRecord.h>
#import "KeyConstants.h"
#import "ClientConnectionManager.h"
#import "Customer.h"
#import "ClientTranslator.h"

@implementation ClientService

+ (ClientService *)sharedService
{
    static ClientService *_sharedProyectService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedProyectService = [[ClientService alloc] init];
    });
    return _sharedProyectService;
}

- (void)cancelAllClientsRequests
{
    [ClientConnectionManager cancelALLClientsRequest];
}

- (void)apiGetClientsWithErrorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion
{
    [ClientConnectionManager getAllClientsWithsuccess:^(NSDictionary *responseDictionary)     {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            NSArray *customerResponse = (NSArray*)responseDictionary;
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                
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
                
                [Customer MR_truncateAllInContext:localContext];
                for (NSDictionary *customerDictionary in customerResponse)
                {
                    id proyectIdObject = [customerDictionary valueForKeyPath:@"id"];
                    NSString *customerID = ([proyectIdObject isKindOfClass:[NSNumber class]])? [NSString stringWithFormat:@"%@", proyectIdObject] : nil;
                    Customer *customer = [Customer MR_createEntityInContext:localContext];
                    customer.uid = customerID;
                    [ClientTranslator clientDictionary:customerDictionary toCustomerEntity:customer context:localContext];
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
- (void)apiCreateClientWithUsername:(NSString *)name
                              email:(NSString *)email
                              phone:(NSString *)phone
                           interest:(NSString *)interest
                            comment:(NSString *)comment
                     errorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion
{
    [ClientConnectionManager createNewUserWithUsername:name email:email phone:phone interest:interest comment:comment success:^(NSDictionary *responseDictionary)     {
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
                        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNewClientSucced object:self userInfo:userInfo];
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
