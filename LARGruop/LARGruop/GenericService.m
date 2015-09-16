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
#import "Entities.h"
#import "NotificationConstants.h"
#import "GenericConnectionManager.h"
#import "LoginService.h"

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
#if defined(HAIKU_DEBUG) || defined(TFLOG_ENABLED)
        NSLog(@"REQUEST SUCCESS ERROR");
#endif
        
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

    NSPersistentStoreCoordinator *psc = [NSPersistentStoreCoordinator MR_coordinatorWithSqliteStoreNamed:STORE_NAME];
    NSString *sourceStoreType = NSSQLiteStoreType;
    NSURL *sourceStoreURL = [NSPersistentStore MR_urlForStoreName:STORE_NAME];
    NSError *error = nil;
    
    NSDictionary *sourceMetadata =
    [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:sourceStoreType
                                                               URL:sourceStoreURL
                                                             error:&error];
    
    if (sourceMetadata == nil) {
        // deal with error
    }
    
    NSString *configuration = nil;
    NSManagedObjectModel *destinationModel = [psc managedObjectModel];
    BOOL pscCompatibile = [destinationModel
                           isConfiguration:configuration
                           compatibleWithStoreMetadata:sourceMetadata];
    
    if (pscCompatibile) {
        // no need to migrate
        [MagicalRecord setupCoreDataStackWithStoreNamed:STORE_NAME];
    }
    else {
        
        //NSURL *storeURL = [sourceStoreURL URLByAppendingPathComponent:[STORE_NAME stringByAppendingString:@"mom"]];
        
        NSString *documentDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSBundle *bundleSourceModel = [NSBundle bundleWithPath:[NSBundle pathForResource:STORE_NAME ofType:@"sqlite" inDirectory:documentDir]];
        
        NSArray *bundlesForSourceModel = @[bundleSourceModel];/* an array of bundles, or nil for the main bundle */
        NSManagedObjectModel *sourceModel = [NSManagedObjectModel mergedModelFromBundles:bundlesForSourceModel
                                                                        forStoreMetadata:sourceMetadata];
        
        if (sourceModel == nil) {
            // deal with error
        }
        
        NSMigrationManager *migrationManager = [[NSMigrationManager alloc] initWithSourceModel:sourceModel
                                                                              destinationModel:destinationModel];
        
        
        NSMappingModel *firstMappingModel = [[NSMappingModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"MappingModel_1.1.6_1.3" withExtension:@"cdm"]];
        NSArray *bundlesForMappingModel = @[firstMappingModel];/* an array of bundles, or nil for the main bundle */ ;
        NSError *error = nil;
        
        NSMappingModel *mappingModel = [NSMappingModel mappingModelFromBundles:bundlesForMappingModel
                                                                forSourceModel:sourceModel
                                                              destinationModel:destinationModel];
        
        if (mappingModel == nil) {
            // deal with the error
        }
        
        
        
        NSDictionary *sourceStoreOptions = nil /* options for the source store */ ;
        NSURL *destinationStoreURL = [NSPersistentStore MR_urlForStoreName:[STORE_NAME stringByAppendingString:@"migration"]]/* URL for the destination store */ ;
        NSString *destinationStoreType = NSSQLiteStoreType /* type for the destination store */ ;
        NSDictionary *destinationStoreOptions = nil; /* options for the destination store */ ;
        
        BOOL ok = [migrationManager migrateStoreFromURL:sourceStoreURL
                                                   type:sourceStoreType
                                                options:sourceStoreOptions
                                       withMappingModel:mappingModel
                                       toDestinationURL:destinationStoreURL
                                        destinationType:destinationStoreType
                                     destinationOptions:destinationStoreOptions
                                                  error:&error];
        
        if (ok) {
            //delete old store and rename the new store
        }
        
        
    }
}

- (void)MR_SetupDatabase
{
    [MagicalRecord setShouldDeleteStoreOnModelMismatch:YES];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:STORE_NAME];
    
    if ([[[NSPersistentStoreCoordinator MR_defaultStoreCoordinator] persistentStores] count] == 0){
        [MagicalRecord cleanUp];
        NSError *error;
        NSURL *fileURL = [NSPersistentStore MR_urlForStoreName:STORE_NAME];
        [[NSFileManager defaultManager] removeItemAtURL:fileURL error:&error];
        [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:STORE_NAME];
    }
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
        [MarketRates MR_truncateAllInContext:localContext];
        [Flat MR_truncateAllInContext:localContext];
        [Customer MR_truncateAllInContext:localContext];
        [User MR_truncateAllInContext:localContext];
        
    }];
}

- (BOOL)errorIsNotFoundErrorWithOperation:(AFHTTPRequestOperation *)operation error:(NSError *)error
{
    //HaikuClient *client = [HaikuClient sharedClient];
    BOOL networkIsReachable = [AFNetworkReachabilityManager sharedManager].reachable;
    
    if (networkIsReachable) {
        
        NSInteger statusCode = (operation && operation.response.statusCode != 0)? operation.response.statusCode : (error)? error.code : StatusCodeUnexpectedError;
        
        return (statusCode == StatusCodeNotFound);
    }
    
    return NO;
}

- (void)cancelAllPreviousRequests
{
    [GenericConnectionManager cancelAllPreviousRequests];
}

- (NSManagedObject *)getManagedObjectFromCurrentThread:(NSManagedObject *)object
{
    if (object == nil) {
        return nil;
    }
    
    return [[NSManagedObjectContext MR_defaultContext] objectWithID:object.objectID];
}

@end