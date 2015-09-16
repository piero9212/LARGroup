//
//  ProyectFeatureService.m
//  LARGruop
//
//  Created by piero.sifuentes on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectFeatureService.h"

@implementation ProyectFeatureService


+ (ProyectFeatureService *)sharedService
{
    static ProyectFeatureService* _sharedProyectFeatureService = nil;
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken,^{
        _sharedProyectFeatureService = [[ProyectFeatureService alloc] init];
    });
    
    return  _sharedProyectFeatureService;
}
- (NSArray *)getAllFeaturesWithProyect:(Proyect*)proyect
{
    NSArray* features = [[NSArray alloc]initWithArray:[proyect.features allObjects]];
    return features;
}
@end
