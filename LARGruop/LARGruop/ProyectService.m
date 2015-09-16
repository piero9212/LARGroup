//
//  ProyectService.m
//  LARGruop
//
//  Created by piero.sifuentes on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectService.h"

static NSMutableArray *_filterProyects;

@implementation ProyectService

+ (ProyectService *)sharedService
{
    static ProyectService *_sharedProyectService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedProyectService = [[ProyectService alloc] init];
    });
    return _sharedProyectService;
}

+ (NSMutableArray *)filterProyects
{
    if (!_filterProyects) {
        _filterProyects = [[NSMutableArray alloc] init];
    }
    
    return _filterProyects;
}

+ (void)setFilterProyects:(NSMutableArray *)filterProyects
{
    _filterProyects = filterProyects;
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationFilterProyectsChanged object:self userInfo:nil];
}

- (void)resetProyectsFilter
{
    NSMutableArray *proyects = [[[ProyectService sharedService] getAllProyects] mutableCopy];
    
    [ProyectService setFilterProyects:proyects];

}
- (NSArray *)getAllProyects
{
    NSArray *proyects = [Proyect MR_findAllSortedBy:@"name" ascending:YES];
    return proyects;
}

- (Proyect *)newProyect
{
    __block Proyect *proyect = nil;
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext)
    {
        proyect = [Proyect MR_createEntityInContext:localContext];
    }];
    
    return proyect;
}

- (Proyect *)getProyect:(Proyect *)proyect fromContext:(NSManagedObjectContext *)context
{
    if (!proyect) {
        return nil;
    }
    
    return (context)? (Proyect *)[context objectWithID:proyect.objectID] : (Proyect *)[[NSManagedObjectContext MR_defaultContext] objectWithID:proyect.objectID];
}

- (NSCompoundPredicate *)getProyectFilterPredicate
{
    NSMutableArray *proyectFilterPredicates = [NSMutableArray array];
    NSMutableArray *filterProyects = [NSMutableArray arrayWithArray:[ProyectService filterProyects]];
    
    NSPredicate *noProyectFilterPredicate = [NSPredicate predicateWithFormat:@"SELF.proyect == nil"];
    [proyectFilterPredicates addObject:noProyectFilterPredicate];
    
    NSPredicate *someProyectFilterPredicate = [NSPredicate predicateWithFormat:@"SELF.proyect IN %@", filterProyects];
    [proyectFilterPredicates addObject:someProyectFilterPredicate];
    
    
    NSCompoundPredicate *proyectFilterPredicate = [[NSCompoundPredicate alloc] initWithType:NSOrPredicateType subpredicates:proyectFilterPredicates];
    
    return proyectFilterPredicate;

}
- (Proyect *)getProyectWithId:(NSString *)proyectId
{
    return [Proyect MR_findFirstByAttribute:@"uid" withValue:proyectId];
}

- (NSArray *)getFilteredProyectsWithoutNulls
{
    NSMutableArray *filteredProyects = [NSMutableArray arrayWithArray:[ProyectService filterProyects]];
    [filteredProyects removeObjectIdenticalTo:[NSNull null]];
    return filteredProyects;
}

@end
