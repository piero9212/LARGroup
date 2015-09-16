//
//  ProyectFeatureConnectionManager.m
//  LARGruop
//
//  Created by piero.sifuentes on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectFeatureConnectionManager.h"

@implementation ProyectFeatureConnectionManager

+ (void)getFeaturessWithProyectID:(NSNumber *)proyectID
                          success:(void (^) (NSDictionary *responseDictionary))success
                          failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure
{
    [[ServiceClient sharedClient] startRequestMethod:RequestMethodGet url:[NSString stringWithFormat:@"proyects/%ld/features",(long)[proyectID integerValue]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];

}

@end
