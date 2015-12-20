//
//  ClientService.h
//  LARGruop
//
//  Created by Piero on 29/11/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//

#import "GenericService.h"

@class Customer;
@interface ClientService : GenericService

+ (ClientService *)sharedService;

- (void)cancelAllClientsRequests;
+ (NSMutableArray *)clients;
+ (void)setClients:(NSMutableArray *)clients;

- (NSArray *)getAllClients;

- (Customer *)getCustomer:(Customer *)client fromContext:(NSManagedObjectContext *)context;


- (void)apiGetClientsWithErrorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion;
- (void)apiCreateClientWithUsername:(NSString *)name
                          email:(NSString *)email
                          phone:(NSString *)phone
                       interest:(NSString *)interest
                        comment:(NSString *)comment
                        errorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion;

@end
