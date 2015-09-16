//
//  ProyectFeatureService.h
//  LARGruop
//
//  Created by piero.sifuentes on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "GenericService.h"

static NSString * const GROUP_BY_KEY = @"GroupBy";
static NSString * const LISTS_KEY = @"Lists";

@interface ProyectFeatureService : GenericService


+ (ProyectFeatureService *)sharedService;

- (NSArray *)getAllFeaturesWithProyect:(Proyect*)proyect;

@end
