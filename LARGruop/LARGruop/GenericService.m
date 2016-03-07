//
//  GenericService.m
//  LARGruop
//
//  Created by piero.sifuentes on 15/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "GenericService.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperation.h>
#import "NotificationConstants.h"
#import "BaseConnectionManager.h"
#import "LoginService.h"
#import "ErrorCodes.h"
#import "Proyect.h"
#import "ProyectFeature.h"
#import "Outside.h"
#import "Quote.h"
#import "Flat.h"
#import "Customer.h"
#import "Floor.h"
#import "Promo.h"
#import "FlatFeature.h"

static NSString * const STORE_NAME = @"LARGruop";

@implementation GenericService
#pragma mark -
#pragma mark Custom Accessors

- (NSError *)unexpectedError
{
    return [[NSError alloc] initWithDomain:AFURLResponseSerializationErrorDomain code:StatusCodeUnexpectedError userInfo:nil];
}

- (RequestFailureErrorHandlingBlock)requestFailureErrorHandler
{
    return ^(AFHTTPRequestOperation *operation, NSError *error, BOOL showAlertView, NSDictionary *userInfo) {
        
        BOOL networkIsReachable = [AFNetworkReachabilityManager sharedManager].reachable;
        NSNotification *errorNotification = nil;
        NSString *notificationIdentifier = nil;
        NSInteger statusCode = 0;
        
        if (!networkIsReachable) {
            statusCode = StatusCodeNoInternetConnection;
            notificationIdentifier = kNotificationNoInternetConnection;
        }
        else {
            
            statusCode = (operation && operation.response.statusCode != 0)? operation.response.statusCode : (error)? error.code : StatusCodeUnexpectedError;
            
            switch (statusCode) {
                case StatusCodeUnauthorized:
                    notificationIdentifier = kNotificationUnauthorized;
                    break;
                case StatusCodeNotFound:
                    notificationIdentifier = kNotificationNotFound;
                    break;
                case StatusCodeInternalServerError:
                    notificationIdentifier = kNotificationInternalServerError;
                    break;
                case StatusCodeRequestCancelled:
                    break;
                default:
                    statusCode = StatusCodeUnexpectedError;
                    notificationIdentifier = kNotificationUnexpectedError;
                    break;
            }
        }
        
        if (statusCode != StatusCodeRequestCancelled) {
            
            NSMutableDictionary *currentUserInfo;
            if (userInfo) {
                currentUserInfo = [NSMutableDictionary dictionaryWithDictionary:userInfo];
            }
            else {
                currentUserInfo = [[NSMutableDictionary alloc] init];
            }
            
            [currentUserInfo setObject:[NSNumber numberWithInteger:statusCode] forKey:ERROR_NOTIFICATION_STATUS_CODE];
            [currentUserInfo setObject:[NSNumber numberWithBool:showAlertView] forKey:ERROR_NOTIFICATION_SHOW_ALERT_VIEW];
            
            errorNotification = [NSNotification notificationWithName:notificationIdentifier object:currentUserInfo];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [[NSNotificationCenter defaultCenter] postNotification:errorNotification];
            });
            
        }
    };
}


- (RequestSuccessErrorHandlingBlock)requestSuccessErrorHandler
{
    return ^ (NSManagedObjectContext *context, BOOL showAlertView, NSDictionary *userInfo) {
        
        if (context) {
            [context rollback];
        }
        self.requestFailureErrorHandler(nil, [NSError errorWithDomain:AFURLResponseSerializationErrorDomain  code:StatusCodeUnexpectedError userInfo:nil], showAlertView, userInfo);
        
    };
}


#pragma mark -
#pragma mark Class Methods

+ (GenericService *)sharedService
{
    static GenericService *_sharedGenericService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedGenericService = [[GenericService alloc] init];
    });
    return _sharedGenericService;
}

#pragma mark -
#pragma mark Public Methods

- (void)cleanUpDatabase
{
    [MagicalRecord cleanUp];
}


- (void)setupDatabase
{
    [MagicalRecord setShouldDeleteStoreOnModelMismatch:YES];
    [MagicalRecord setupCoreDataStackWithStoreNamed:STORE_NAME];
    
    if ([[[NSPersistentStoreCoordinator MR_defaultStoreCoordinator] persistentStores] count] == 0){
        [MagicalRecord cleanUp];
        NSError *error;
        NSURL *fileURL = [NSPersistentStore MR_urlForStoreName:STORE_NAME];
        [[NSFileManager defaultManager] removeItemAtURL:fileURL error:&error];
        [MagicalRecord setupCoreDataStackWithStoreNamed:STORE_NAME];
    }
}

- (void)reset
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    [defaults synchronize];
    

}

- (void)dropDatabase
{
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext){
        [Entity MR_truncateAllInContext:localContext];
    }];
}

- (void)resetDatabase
{
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext){
        [Proyect MR_truncateAllInContext:localContext];
        [ProyectFeature MR_truncateAllInContext:localContext];
        [Outside MR_truncateAllInContext:localContext];
        [Quote MR_truncateAllInContext:localContext];
        [Flat MR_truncateAllInContext:localContext];
        [Customer MR_truncateAllInContext:localContext];
        [User MR_truncateAllInContext:localContext];
        [Floor MR_truncateAllInContext:localContext];
        [Promo MR_truncateAllInContext:localContext];
        [FlatFeature MR_truncateAllInContext:localContext];
        
    }];
}

- (BOOL)errorIsNotFoundErrorWithOperation:(AFHTTPRequestOperation *)operation error:(NSError *)error
{
    BOOL networkIsReachable = [AFNetworkReachabilityManager sharedManager].reachable;
    
    if (networkIsReachable) {
        
        NSInteger statusCode = (operation && operation.response.statusCode != 0)? operation.response.statusCode : (error)? error.code : StatusCodeUnexpectedError;
        
        return (statusCode == StatusCodeNotFound);
    }
    
    return NO;
}

- (void)cancelAllPreviousRequests
{
    [BaseConnectionManager cancelAllPreviousRequests];
}

- (NSManagedObject *)getManagedObjectFromCurrentThread:(NSManagedObject *)object
{
    if (object == nil) {
        return nil;
    }
    
    return [[NSManagedObjectContext MR_defaultContext] objectWithID:object.objectID];
}

@end