//
//  LoginConnectionManager.m
//  LARGruop
//
//  Created by Piero on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "LoginConnectionManager.h"
#import "ServiceClient.h"
#import "User.h"
#import "ApplicationConstants.h"

static NSString* const loginPath = @"ws/login?username=%@&password=%@";
static NSString* const editUserPath = @"ws/editUser?id=%@&username=%@&password=%@&email=%@&phone=%@&cell_phone=%@&type=%@&image=%@&name=%@";
static NSString* const postImagePath = @"file/uploadImage";
static NSString* const forgetPassPATH = @"ws/forgetPassword?email=%@";


@implementation LoginConnectionManager


+ (void)cancelLoginRequestsWithUsername:(NSString *)username
                               password:(NSString *)password
{
    [[ServiceClient sharedClient] cancelAllHTTPOperationsWithMethod:@"GET" path:[NSString stringWithFormat:loginPath,username,password]];
}

+ (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                  success:(void (^) (NSDictionary *responseDictionary))success
                  failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    NSDictionary *parameters = nil;
    NSString* path = [NSString stringWithFormat:loginPath,username,password];
    
    ServiceClient *client = [ServiceClient sharedClient];
    [client cancelAllHTTPOperationsWithMethod:@"GET" path:path];
    [client.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    client.requestSerializer = [AFJSONRequestSerializer serializer];
    [client startRequestMethod:RequestMethodGet url:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:failure];
    
}

+(void)recoverPasswordWithEmail:(NSString*)email success:(void (^) (NSDictionary *responseDictionary))success
                        failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSDictionary *parameters = nil;
    NSString* path = [NSString stringWithFormat:forgetPassPATH,email];
    
    ServiceClient *client = [ServiceClient sharedClient];
    [client cancelAllHTTPOperationsWithMethod:@"GET" path:path];
    [client.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    client.requestSerializer = [AFJSONRequestSerializer serializer];
    [client startRequestMethod:RequestMethodGet url:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:failure];
}


+ (void)apiPostImageWithImage:(UIImage*)image success:(void (^) (NSDictionary *responseDictionary))success
                        failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSDictionary *parameters ;
    NSString* path = [NSString stringWithFormat:postImagePath];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // Init the URLRequest
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
    manager.requestSerializer.timeoutInterval = 0.30;
    AFHTTPRequestOperation *op = [manager POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"image" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
        success(responseObject);
    } failure:failure];
    [op start];
}

+ (void)logoutWithCompletion:(void (^) ())completion
{
    
}

+ (void)apiEditUserWithName:(NSString *)name
                   password:(NSString *)password
                      email:(NSString *)email
                      phone:(NSString *)phone
                mobilePhone:(NSString *)mobilePhone
                       User:(User*)user
                    success:(void (^) (NSDictionary *responseDictionary))success
                    failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSDictionary *parameters = nil;
    NSString* path = [NSString stringWithFormat:editUserPath,user.uid,user.username,password,email, phone,mobilePhone,user.type,user.imageURL,name];
    path  = [path stringByReplacingOccurrencesOfString:@" " withString: @"%20"];
    ServiceClient *client = [ServiceClient sharedClient];
    [client cancelAllHTTPOperationsWithMethod:@"GET" path:path];
    [client.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    client.requestSerializer = [AFJSONRequestSerializer serializer];
    [client startRequestMethod:RequestMethodGet url:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:failure];
}


@end
