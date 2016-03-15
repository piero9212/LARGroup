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
//    NSDictionary *parameters ;
//    NSString* path = [NSString stringWithFormat:postImagePath];
//    
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
//    // Init the URLRequest
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
//    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
//    manager.requestSerializer.timeoutInterval = 0.30;
//    //
//    AFHTTPRequestOperation *op = [manager POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        //do not put image inside parameters dictionary as I did, but append it!
//        [formData appendPartWithFileData:imageData name:@"image" fileName:@"image.jpeg" mimeType:@"image/jpeg"];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
//        success(responseObject);
//    } failure:failure];
//    [op start];

    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
    [_params setObject:@"1.0" forKey:@"ver"];
    [_params setObject:@"en" forKey:@"lan"];
    [_params setObject:[NSString stringWithFormat:@"%@", [[LoginService sharedService] lastLoggedInUser].uid] forKey:@"userId"];
    
    // the boundary string : a random string, that will not repeat in post data, to separate post data fields.
    NSString *boundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    
    // string constant for the post parameter 'file'. My server uses this name: `file`. Your's may differ
    NSString* FileParamConstant = @"image";
    
    // the server url to which the image (or the media) is uploaded. Use your server url here
    NSString* path = [NSString stringWithFormat:@"%@%@",BaseURLString,postImagePath];
    NSURL* requestURL = [NSURL URLWithString:path];

    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    // add params (all params are strings)
    for (NSString *param in _params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    [request setURL:requestURL];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    // NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@",dict);
    
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
