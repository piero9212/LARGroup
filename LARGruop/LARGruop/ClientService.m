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


- (NSArray *)getAllClients
{
    NSArray *clients = [Customer MR_findAllSortedBy:@"name" ascending:YES inContext: [NSManagedObjectContext MR_defaultContext]];
    return clients;
}

- (void)apiGetClientsWithErrorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion
{
    [ClientConnectionManager getAllClientsWithsuccess:^(NSDictionary *responseDictionary)     {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            NSArray *customerResponse = (NSArray*)responseDictionary;
            
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
                
                [Customer MR_truncateAllInContext:localContext];
                for (NSDictionary *customerDictionary in customerResponse)
                {
                    id customerIdObject = [customerDictionary valueForKeyPath:@"id"];
                    NSString *customerID = ([customerIdObject isKindOfClass:[NSNumber class]])? [NSString stringWithFormat:@"%@", customerIdObject] : nil;
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
- (void)apiCreateClientWithName:(NSString *)name
                              email:(NSString *)email
                              phone:(NSString *)phone
                           interest:(NSString *)interest
                            comment:(NSString *)comment
                     errorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion
{
    [ClientConnectionManager apiCreateNewClientWithName:name email:email phone:phone interest:interest comment:comment success:^(NSDictionary *responseDictionary)     {
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

- (void)apiEditClientWithID:(NSString*)uid name:(NSString*)name email:(NSString *)email phone:(NSString *)phone interest:(NSString *)interest comment:(NSString *)comment errorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^)(BOOL))completion
{
    [ClientConnectionManager apiEditClientWithID:uid name:name email:email phone:phone interest:interest comment:comment success:^(NSDictionary *responseDictionary)     {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
           
                NSNumber *showAlertView = [NSNumber numberWithBool:YES];
                NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:showAlertView, USER_INFO_SHOW_ALERT_VIEW, nil];
                id errorObject = [responseDictionary valueForKeyPath:@"error"];
                NSString *error = ([errorObject isKindOfClass:[NSString class]])? errorObject : nil;
                if([error isEqualToString:GET_PROYECTS_ERROR_KEY] || !responseDictionary)
                {
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationEditClientFailed object:self userInfo:userInfo];
                    });
                    return;
                }
                else
                {
                    NSDictionary *customerDictionary = responseDictionary;
                    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                        id customerIdObject = [customerDictionary valueForKeyPath:@"id"];
                        NSString *customerID = ([customerIdObject isKindOfClass:[NSNumber class]])? [NSString stringWithFormat:@"%@", customerIdObject] : nil;
                        Customer* customer = [Customer MR_findByAttribute:@"uid" withValue:customerID inContext:localContext].firstObject;
                        if(customer)
                        {
                            [ClientTranslator clientDictionary:customerDictionary toCustomerEntity:customer context:localContext];
                        }
                        else
                        {
                            dispatch_async(dispatch_get_main_queue(), ^(void){
                                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationEditClientFailed object:self userInfo:userInfo];
                            });
                        }
                    } completion:^(BOOL contextDidSave, NSError * _Nullable error) {
                       
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationEditClientSucced object:self userInfo:userInfo];
                             if(!error)
                                 completion(YES);
                            else
                                completion(NO);
                        });

                    }];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationEditClientFailed object:self userInfo:userInfo];
                        completion(YES);
                    });
                    
                }
            });
    }
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
