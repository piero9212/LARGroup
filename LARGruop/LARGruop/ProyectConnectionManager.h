//
//  ProyectConnectionManager.h
//  LARGruop
//
//  Created by piero.sifuentes on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "GenericConnectionManager.h"

@interface ProyectConnectionManager : GenericConnectionManager


+ (void)getAllProyectsWithsuccess:(void (^) (NSDictionary *responseDictionary))success
                                     failure:(void (^) (AFHTTPRequestOperation *operation, NSError *error))failure;



@end
