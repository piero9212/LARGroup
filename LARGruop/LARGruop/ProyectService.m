//
//  ProyectService.m
//  LARGruop
//
//  Created by piero.sifuentes on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "ProyectService.h"
#import "ProyectConnectionManager.h"
#import "Proyect.h"
#import "Entity.h"
#import "ProyectTranslator.h"
#import "ErrorCodes.h"
#import <MagicalRecord/MagicalRecord.h>

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
    NSArray *proyects = [Proyect MR_findAllSortedBy:@"name" ascending:YES inContext: [NSManagedObjectContext MR_defaultContext]];
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

- (void)apiGetProyectsWithErrorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion;
{
    [ProyectConnectionManager getAllProyectsWithsuccess:^(NSDictionary *responseDictionary)     {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSArray *proyectsResponse = (NSArray*)responseDictionary;
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            [Proyect MR_truncateAllInContext:localContext];
            for (NSDictionary *proyectDictionary in proyectsResponse)
            {
                id proyectIdObject = [proyectDictionary valueForKeyPath:@"id"];
                NSString *proyectID = ([proyectIdObject isKindOfClass:[NSNumber class]])? [NSString stringWithFormat:@"%@", proyectIdObject] : nil;
                
                if (!proyectID && !proyectDictionary) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAllProyectsFailed object:self userInfo:userInfo];
                    });
                    
                    self.requestSuccessErrorHandler(nil, showAlertView, userInfo);
                    return;
                }
                
                Proyect *proyect = [Proyect MR_createEntityInContext:localContext];
                proyect.uid = proyectID;
                [ProyectTranslator proyectDictionary:proyectDictionary toProyectEntity:proyect context:localContext];
            }

            
        } completion:^(BOOL contextDidSave, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(YES);
            });
        }];
        }
        );}
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         NSNumber *showAlertView = [NSNumber numberWithBool:NO];
         
         if(operation && operation.response.statusCode == StatusCodeNoInternetConnection) {
             showAlertView = [NSNumber numberWithBool:YES];
         }
         else {
             self.requestFailureErrorHandler(operation, error, YES, nil);
         }
         
         NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:showAlertView, USER_INFO_SHOW_ALERT_VIEW, nil];
         dispatch_async(dispatch_get_main_queue(), ^(void){
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAllProyectsFailed object:self userInfo:userInfo];
         });
     }];
}

@end
