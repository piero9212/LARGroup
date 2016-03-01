//
//  PromoService.m
//  LARGruop
//
//  Created by Piero on 29/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#import "PromoService.h"

@implementation PromoService


+ (PromoService *)sharedService
{
    static PromoService *_sharedProyectService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedProyectService = [[PromoService alloc] init];
    });
    return _sharedProyectService;
}

- (void)cancelAllPromoRequest
{
    //[ClientConnectionManager cancelALLClientsRequest];
}

+ (void)setFilterProyects:(NSMutableArray *)filterPromos
{
    
}

- (NSArray *)getAllPromos
{
    NSArray* promos ;
    
    return promos;
}
@end
