//
//  ProyectFeatureConnectionManager.h
//  LARGruop
//
//  Created by piero.sifuentes on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "GenericConnectionManager.h"

@interface ProyectFeatureConnectionManager : GenericConnectionManager

+ (void)getFeaturessWithProyectID:(NSNumber *)proyectID
                           success:(void (^) (NSDictionary *responseDictionary))success
                           failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure;

@end