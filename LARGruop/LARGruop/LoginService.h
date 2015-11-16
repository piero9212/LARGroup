//
//  LoginService.h
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "GenericService.h"
#import "User.h"

@interface LoginService : GenericService


+ (LoginService *)sharedService;

- (void)cancelLoginRequestsWithUsername:(NSString *)username
                               password:(NSString *)password;

- (void)loginWithUsername:(NSString *)username password:(NSString *)password;
- (void)logoutWithNotification:(BOOL)showNotification;

- (User *)lastLoggedInUser;
- (User *)lastLoggedInUserFromContext:(NSManagedObjectContext *)context;
- (void)setLastLoggedInUserID:(NSString *)lastLoggedInUserId;

- (NSString *)lastUsername;
- (void)setLastUsername:(NSString *)lastUsername;

- (NSString *)lastPassword;
- (void)setLastPassword:(NSString *)lastPassword;

- (User *)getUserWithUserID:(NSString *)userId;
- (User *)getUserWith:(User *)user fromContext:(NSManagedObjectContext *)context;
- (NSDate *)getDateOfLastLoggedIn;


- (NSString *)lastToken;
- (void)setLastToken:(NSString *)lastToken;


@end
