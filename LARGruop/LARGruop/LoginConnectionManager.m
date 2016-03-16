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
#import "LoginService.h"

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
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    
    // 1. Create `AFHTTPRequestSerializer` which will create your request.
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    NSString* path = [NSString stringWithFormat:@"%@%@",BaseURLString,postImagePath];
    NSDictionary *parameters = nil;
    int randomValue = (random() % 1000);
    NSString *filename = [NSString stringWithFormat:@"%d%@V2ymHFg03ehbqgZCaKO6jy.jpg",randomValue*100, [[LoginService sharedService] lastLoggedInUser].uid];
    
    
    NSError *__autoreleasing* error;
    // 2. Create an `NSMutableURLRequest`.
    NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST" URLString:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData
                                    name:@"image"
                                fileName:filename
                                mimeType:@"image/jpg"];
    } error:(NSError *__autoreleasing *)error];
    // 3. Create and use `AFHTTPRequestOperationManager` to create an `AFHTTPRequestOperation` from the `NSMutableURLRequest` that we just created.
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *operation =
    [manager HTTPRequestOperationWithRequest:request
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                 NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
                                         NSDictionary* dic = [[NSDictionary alloc]initWithObjects:@[filename] forKeys:@[@"filename"]];
                                                 success(dic);
                                             }
                                     failure:failure];
    
    // 4. Set the progress block of the operation.
    [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                        long long totalBytesWritten,
                                        long long totalBytesExpectedToWrite) {
        NSLog(@"Wrote %lld/%lld", totalBytesWritten, totalBytesExpectedToWrite);
    }];
    
    // 5. Begin!
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    
    [operation start];
}

+ (void)logoutWithCompletion:(void (^) ())completion
{
    
}

+ (void)apiEditUserWithName:(NSString *)name
                   password:(NSString *)password
                      email:(NSString *)email
                      phone:(NSString *)phone
                mobilePhone:(NSString *)mobilePhone
                image:(NSString *)imageURL
                       User:(User*)user
                    success:(void (^) (NSDictionary *responseDictionary))success
                    failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSDictionary *parameters = nil;
    NSString* path = [NSString stringWithFormat:editUserPath,user.uid,user.username,password,email, phone,mobilePhone,user.type,imageURL,name];
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
