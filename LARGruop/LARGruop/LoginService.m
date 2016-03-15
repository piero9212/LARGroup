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
#import "StandardDefaultConstants.h"
#import "ErrorCodes.h"
#import "Entity.h"
#import "KeyConstants.h"

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

-(NSString *)lastPassword
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastPass = [defaults objectForKey:LAST_LOGGED_IN_PASS];
    return lastPass;
}

- (void)setLastLoggedInUserID:(NSString *)lastLoggedInUserId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:lastLoggedInUserId forKey:LAST_LOGGED_IN_USER_ID];
    [defaults setObject:[NSDate date] forKey:DATE_OF_LAST_LOGGED_IN];
    [defaults synchronize];
}

- (void)setLastPassword:(NSString *)lastPassword
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:lastPassword forKey:LAST_LOGGED_IN_PASS];
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


#pragma mark -
#pragma mark API Methods

- (void)cancelLoginRequestsWithUsername:(NSString *)username
                               password:(NSString *)password
{
    [LoginConnectionManager cancelLoginRequestsWithUsername:username password:password];
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
    
    [LoginConnectionManager loginWithUsername:username
                                     password:password
                                      success:^(NSDictionary *responseDictionary) {
                                          
                                          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                                              
                                          NSNumber *showAlertView = [NSNumber numberWithBool:YES];
                                          NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:showAlertView, USER_INFO_SHOW_ALERT_VIEW, nil];
                                            id errorObject = [responseDictionary valueForKeyPath:@"error"];
                                          NSString *error = ([errorObject isKindOfClass:[NSString class]])? errorObject : nil;
                                          if([error isEqualToString:LOGIN_ERROR_KEY] || [error isEqualToString:LOGIN_PASWORD_ERROR_KEY])
                                              {
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^(void){
                                                      [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginFailed object:self userInfo:userInfo];
                                                  });
                                                  return;
                                                  
                                              }
                                          id userIdObject = [responseDictionary valueForKeyPath:@"id"];
                                          NSString *userId = ([userIdObject isKindOfClass:[NSNumber class]])? [NSString stringWithFormat:@"%@", userIdObject] : nil;
                                          
                                        User *lastLoggedInUser = [self lastLoggedInUser];
                                        if (!lastLoggedInUser) {
                                            //[self reset];
                                        }
                                        else if (lastLoggedInUser && ![userId isEqualToString:lastLoggedInUser.uid]) {
                                            [self dropDatabase];
                                        }
                                    
                                          [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                                              User *lastLoggedInUser = [self lastLoggedInUserFromContext:localContext];
                                              
                                              if (!(lastLoggedInUser && [userId isEqualToString:lastLoggedInUser.uid])) {
                                                  User *user = [User MR_createEntityInContext:localContext];
                                                  [LoginTranslator userDictionary:responseDictionary toUserEntity:user];
                                              }
                                              else {
                                                  [LoginTranslator userDictionary:responseDictionary toUserEntity:lastLoggedInUser];
                                              }
                                            } completion:^(BOOL success, NSError *error) {
                                                if (success || !error) {
                                                    [self setLastLoggedInUserID:userId];
                                                    [self setLastUsername:lastLoggedInUser.username];
                                                    [self setLastPassword:password];
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginSucceeded object:self userInfo:nil];
                                                }
                                                else {
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginFailed object:self userInfo:userInfo];
                                                    
                                                    self.requestSuccessErrorHandler(nil, YES, nil);
                                                }
                                          } ];
                                          });

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


-(void)apiRecoverPasswordWithEmail:(NSString*)email
{
    [LoginConnectionManager recoverPasswordWithEmail:email success:^(NSDictionary *responseDictionary) 
    {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            NSNumber *showAlertView = [NSNumber numberWithBool:YES];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:showAlertView, USER_INFO_SHOW_ALERT_VIEW, nil];
            id errorObject = [responseDictionary valueForKeyPath:@"error"];
            NSString *error = ([errorObject isKindOfClass:[NSString class]])? errorObject : nil;
            if([error isEqualToString:LOGIN_ERROR_KEY] || [error isEqualToString:LOGIN_PASWORD_ERROR_KEY])
            {
                
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationRememberFailed object:self userInfo:userInfo];
                });
                return;
                
            }
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationRememberSucces object:self userInfo:userInfo];
            });

            
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSNumber *showAlertView = [NSNumber numberWithBool:NO];
        
        if(operation && operation.response.statusCode == StatusCodeUnauthorized) {
            showAlertView = [NSNumber numberWithBool:YES];
        }
        else {
            self.requestFailureErrorHandler(operation, error, YES, nil);
        }
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:showAlertView, USER_INFO_SHOW_ALERT_VIEW, nil];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationRememberFailed object:self userInfo:userInfo];
        });
        
    }];
}

- (void)logoutWithNotification:(BOOL)showNotification
{
    
    
    [self dropDatabase];
    [[GenericService sharedService] cancelAllPreviousRequests];
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogoutFinished object:self userInfo:nil];
    });
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

- (void)apiEditUserWithName:(NSString *)name
                   password:(NSString *)password
                      email:(NSString *)email
                      phone:(NSString *)phone
                mobilePhone:(NSString *)mobilePhone
                      image:(NSString *)imageURL
                       User:(User*)user
                     errorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion
{
    [LoginConnectionManager apiEditUserWithName:name password:password email:email phone:phone mobilePhone:mobilePhone image:imageURL User:user success:^(NSDictionary *responseDictionary){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            
            NSNumber *showAlertView = [NSNumber numberWithBool:YES];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:showAlertView, USER_INFO_SHOW_ALERT_VIEW, nil];
            id errorObject = [responseDictionary valueForKeyPath:@"error"];
            NSString *error = ([errorObject isKindOfClass:[NSString class]])? errorObject : nil;
            if([error isEqualToString:LOGIN_EDIT_ERROR_KEY])
            {
                
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginFailed object:self userInfo:userInfo];
                });
                return;
                
            }
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                User *user = [self lastLoggedInUser];
                if(user.isFault)
                    user =(User *)[[NSManagedObjectContext MR_defaultContext] objectWithID:user.objectID];
                [LoginTranslator userDictionary:responseDictionary toUserEntity:user];
            } completion:^(BOOL success, NSError *error) {
                
                if (!error) {
                    completion(YES);
                }
                else {
                    completion(NO);
                }
            }
             ];
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


- (void)apiPostNewImage:(UIImage*)image
{
    [LoginConnectionManager apiPostImageWithImage:image success:^(NSDictionary *responseDictionary)
     {
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
             NSNumber *showAlertView = [NSNumber numberWithBool:YES];
             NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:showAlertView, USER_INFO_SHOW_ALERT_VIEW, nil];
             id errorObject = [responseDictionary valueForKeyPath:@"error"];
             NSString *error = ([errorObject isKindOfClass:[NSString class]])? errorObject : nil;
             if([error isEqualToString:LOGIN_ERROR_KEY] || [error isEqualToString:LOGIN_PASWORD_ERROR_KEY])
             {
                 
                 dispatch_async(dispatch_get_main_queue(), ^(void){
                     [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNewImageFailed object:self userInfo:userInfo];
                 });
                 return;
                 
             }
             User* user = [self lastLoggedInUser];
             NSString* name;
             if(user.firstName && user.lastName)
             {
                 name = [NSString stringWithFormat:@"%@ %@",user.firstName,user.lastName];
             }
             else if(user.firstName)
             {
                 name = [NSString stringWithFormat:@"%@",user.firstName];
             }
             
             NSString* pass = [[LoginService sharedService] lastPassword];
             NSString* imagepath = [responseDictionary objectForKey:@"filename"];

             [self apiEditUserWithName:name password:pass email:user.email phone:user.phone mobilePhone:user.mobilePhone image:imagepath User:user errorAlertView:NO userInfo:nil andCompletionHandler:^(BOOL succeeded) {
                 if(succeeded)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^(void){
                         [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNewImageSucces object:self userInfo:userInfo];
                     });
                 }
                 else
                 {
                     dispatch_async(dispatch_get_main_queue(), ^(void){
                         [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNewImageFailed object:self userInfo:userInfo];
                     });

                 }
             }];
             
             
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
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNewImageFailed object:self userInfo:userInfo];
         });
     }];
}



@end
