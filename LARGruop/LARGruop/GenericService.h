//
//  GenericService.h
//  LARGruop
//
//  Created by piero.sifuentes on 15/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorConstants.h"
#import <CoreData/CoreData.h>

@class AFHTTPRequestOperation;

typedef void(^RequestFailureErrorHandlingBlock)(AFHTTPRequestOperation *operation, NSError *error, BOOL showAlertView, NSDictionary *userInfo);
typedef void(^RequestSuccessErrorHandlingBlock)(NSManagedObjectContext *context, BOOL showAlertView, NSDictionary *userInfo);

@interface GenericService : NSObject

@property (readonly, strong, nonatomic) NSError *unexpectedError;
@property (readonly, copy, nonatomic) RequestFailureErrorHandlingBlock requestFailureErrorHandler;
@property (readonly, copy, nonatomic) RequestSuccessErrorHandlingBlock requestSuccessErrorHandler;

+ (GenericService *)sharedService;

- (void)cleanUpDatabase;
- (void)setupDatabase;
- (void)MR_SetupDatabase;
- (void)dropDatabase;
- (void)resetDatabase;

- (BOOL)errorIsNotFoundErrorWithOperation:(AFHTTPRequestOperation *)operation error:(NSError *)error;

- (void)cancelAllPreviousRequests;

- (NSManagedObject *)getManagedObjectFromCurrentThread:(NSManagedObject *)object;

@end