//
//  LoginService.m
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "LoginService.h"
#import <MagicalRecord/MagicalRecord.h>
#import "KeychainItemWrapper.h"
#import "LoginConnectionManager.h"
#import "LoginTranslator.h"

static NSString * const LAST_TOKEN = @"LastToken";
static NSString * const LAST_LOGGED_IN_USER_ID = @"LastLoggedInUserId";
static NSString * const DATE_OF_LAST_LOGGED_IN = @"dateOfLastLoggedIn";
static NSString * const LAST_USERNAME = @"LastUsername";
static NSString * const GROUPLAR_KEYCHAIN_IDENTIFIER = @"com.prsp.grouplar-ipad";


@implementation LoginService

#pragma mark -
#pragma mark Object Lifecycle

- (id)init
{
    if (self = [super init]) {
    }
    
    return self;
}

#pragma mark -
#pragma mark Class Methods

+ (LoginService *)sharedService
{
    static LoginService *_sharedLoginService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLoginService = [[LoginService alloc] init];
    });
    return _sharedLoginService;
}

#pragma mark -
#pragma mark Custom Accessors

- (User *)lastLoggedInUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastLoggedInUserId = [defaults objectForKey:LAST_LOGGED_IN_USER_ID];
    
    User *lastLoggedInUser = [User MR_findFirstByAttribute:@"uid" withValue:lastLoggedInUserId];
    
    return lastLoggedInUser;
}

- (User *)lastLoggedInUserFromContext:(NSManagedObjectContext *)context
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastLoggedInUserId = [defaults objectForKey:LAST_LOGGED_IN_USER_ID];
    
    User *lastLoggedInUser = [User MR_findFirstByAttribute:@"uid" withValue:lastLoggedInUserId inContext:context];
    
    return lastLoggedInUser;
}

- (void)setLastLoggedInUserID:(NSString *)lastLoggedInUserId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:lastLoggedInUserId forKey:LAST_LOGGED_IN_USER_ID];
    [defaults setObject:[NSDate date] forKey:DATE_OF_LAST_LOGGED_IN];
    [defaults synchronize];
}

- (NSString *)lastToken
{
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:GROUPLAR_KEYCHAIN_IDENTIFIER accessGroup:nil];
    NSString *lastToken = [keychainItem objectForKey:(__bridge id)(kSecValueData)];
    
    return lastToken;
}

- (void)setLastToken:(NSString *)lastToken
{
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:GROUPLAR_KEYCHAIN_IDENTIFIER accessGroup:nil];
    
    if (lastToken == nil) {
        [keychainItem resetKeychainItem];
    }
    
    [keychainItem setObject:lastToken forKey:(__bridge id)(kSecValueData)];
}

- (NSString *)lastUsername
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastUsername = [defaults objectForKey:LAST_USERNAME];
    return lastUsername;
}

- (void)setLastUsername:(NSString *)lastUsername
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:lastUsername forKey:LAST_USERNAME];
    [defaults synchronize];
}

- (NSString *)lastPassword
{
    /*KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:HAIKU_KEYCHAIN_IDENTIFIER accessGroup:nil];
     NSString *lastPassword = [keychainItem objectForKey:(__bridge id)(kSecValueData)];*/
    
    return nil;//lastPassword;
}

- (void)setLastPassword:(NSString *)lastPassword
{
    /*KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:HAIKU_KEYCHAIN_IDENTIFIER accessGroup:nil];
     
     if (lastPassword == nil) {
     [keychainItem resetKeychainItem];
     }
     
     [keychainItem setObject:lastPassword forKey:(__bridge id)(kSecValueData)];*/
}


#pragma mark -
#pragma mark API Methods

- (void)cancelLoginRequests
{
    [LoginConnectionManager cancelLoginRequests];
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
    
    [LoginConnectionManager loginWithUsername:username
                                     password:password
                                      success:^(NSDictionary *responseDictionary) {
                                          
                                          id tokenObject = [responseDictionary valueForKeyPath:@"token"];
                                          NSString *token = ([tokenObject isKindOfClass:[NSString class]])? tokenObject : nil;
                                          
                                          id userIdObject = [responseDictionary valueForKeyPath:@"user.id"];
                                          NSString *userId = ([userIdObject isKindOfClass:[NSNumber class]])? [NSString stringWithFormat:@"%@", userIdObject] : nil;
                                          
                                          id userObject = [responseDictionary valueForKeyPath:@"user"];
                                          NSDictionary *userDictionary = ([userObject isKindOfClass:[NSDictionary class]])? userObject : nil;
                                          
                                          NSNumber *showAlertView = [NSNumber numberWithBool:NO];
                                          NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:showAlertView, USER_INFO_SHOW_ALERT_VIEW, nil];
                                          
                                          if (!token || !userId || !userDictionary) {
                                              dispatch_async(dispatch_get_main_queue(), ^(void){
                                                  [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginFailed object:self userInfo:userInfo];
                                              });
                                              
                                              self.requestSuccessErrorHandler(nil, YES, nil);
                                              return;
                                              
                                          }
                                          
                                          User *lastLoggedInUser = [self lastLoggedInUser];
                                          
                                          if (lastLoggedInUser && ![userId isEqualToString:lastLoggedInUser.uid]) {
                                              
                                              [self dropDatabase];
                                              
                                          }
                                        
                                          [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                                            User *lastLoggedInUser = [self lastLoggedInUserFromContext:localContext];
                                              
                                              if (!(lastLoggedInUser && [userId isEqualToString:lastLoggedInUser.uid])) {
                                                  User *user = [User MR_createEntityInContext:localContext];
                                                  [LoginTranslator userDictionary:userDictionary toUserEntity:user];
                                              }
                                              else {
                                                  [LoginTranslator userDictionary:userDictionary toUserEntity:lastLoggedInUser];
                                              }
                                          }
                                                                                     completion:^(BOOL success, NSError *error) {
                                                                                         if (success) {
                                                                                             [self setLastLoggedInUserID:userId];
                                                                                             [self setLastToken:token];
                                                                                             //[GenericConnectionManager setXHaikuAuthHeaderWithToken:token userId:userId];
                                                                                             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginSucceeded object:self userInfo:nil];
                                                                                         }
                                                                                         else {
                                                                                             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginFailed object:self userInfo:userInfo];
                                                                                             
                                                                                             self.requestSuccessErrorHandler(nil, YES, nil);
                                                                                         }
                                                                                     }
                                           ];
                                      }
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                          
                                          NSNumber *showAlertView = [NSNumber numberWithBool:NO];
                                          
                                          if(operation && operation.response.statusCode == StatusCodeUnauthorized) {
                                              showAlertView = [NSNumber numberWithBool:YES];
                                          }
                                          else {
                                              self.requestFailureErrorHandler(operation, error, YES, nil);
                                          }
                                          
                                          NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:showAlertView, USER_INFO_SHOW_ALERT_VIEW, nil];
                                          dispatch_async(dispatch_get_main_queue(), ^(void){
                                              [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginFailed object:self userInfo:userInfo];
                                          });
                                          
                                      }];
}


- (void)logoutWithNotification:(BOOL)showNotification
{
    
    //    [GenericConnectionManager setDefaultXHaikuAuthHeader];
    //[GenericConnectionManager setXHaikuAuthHeaderWithToken:[[LoginService sharedService] lastToken] userId:[[LoginService sharedService] lastLoggedInUser].uid];
    
    [[GenericService sharedService] cancelAllPreviousRequests];
    
    [LoginConnectionManager logoutWithCompletion:^{
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogoutFinished object:self userInfo:nil];
        });
        
    }];
    
    if (showNotification) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationInvalidTokenDetected object:nil];
    }
}


- (User *)getUserWithUserID:(NSString *)userId
{
    User *user = [User MR_findFirstByAttribute:@"uid" withValue:userId];
    return user;
}

- (User *)getUserWith:(User *)user fromContext:(NSManagedObjectContext *)context
{
    NSManagedObject *userToReturn = nil;
    if (context) {
        userToReturn = [context objectWithID:user.objectID];
    }
    else {
        NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
        userToReturn = [defaultContext objectWithID:user.objectID];
    }
    
    return (User *)userToReturn;
}

- (NSDate *)getDateOfLastLoggedIn
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults objectForKey:DATE_OF_LAST_LOGGED_IN];
}

@end