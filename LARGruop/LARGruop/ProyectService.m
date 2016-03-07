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
#import "KeyConstants.h"
#import "StandardDefaultConstants.h"

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
    [ProyectService setFilterProyects:nil];

}
- (NSArray *)getAllProyects
{
    NSArray *tempproyects = self.proyects;
    NSMutableArray* proyects = [[NSMutableArray alloc]init];
   
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"uid" ascending:NO];
    NSArray *sortedDescArray = [tempproyects sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    
    for (Proyect *proyect in sortedDescArray)
    {
        if(!([[proyects valueForKeyPath:@"uid"] containsObject:proyect.uid]))
        {
            [proyects addObject:proyect];
        }
    }
    
    return proyects;
}

- (NSArray *)getProyectsWithPredicate:(NSCompoundPredicate*)predicate
{
    NSArray *proyects = [Proyect MR_findAllSortedBy:@"name" ascending:YES withPredicate:predicate inContext:[NSManagedObjectContext MR_defaultContext]];
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

- (void)cancelAllProyectsRequest
{
    [ProyectConnectionManager cancelALLProyectsRequest];
}

- (NSPredicate *)filterProyectsPredicate
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSPredicate *proyectFilter = [defaults objectForKey:PROYECTS_FILTER];
    return proyectFilter;
}

- (void)setfilterProyectsPredicate:(NSPredicate *)predicate
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:[NSKeyedArchiver archivedDataWithRootObject:predicate] forKey:PROYECTS_FILTER];
    [def synchronize];
}

- (void)apiGetProyectsWithErrorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion;
{
    [ProyectConnectionManager getAllProyectsWithsuccess:^(NSDictionary *responseDictionary)     {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
        NSArray *proyectsResponse = (NSArray*)responseDictionary;
                
            NSNumber *showAlertView = [NSNumber numberWithBool:YES];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:showAlertView, USER_INFO_SHOW_ALERT_VIEW, nil];
            id errorObject = [responseDictionary valueForKeyPath:@"error"];
            NSString *error = ([errorObject isKindOfClass:[NSString class]])? errorObject : nil;
            if([error isEqualToString:GET_PROYECTS_ERROR_KEY])
            {
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAllClientsFailed object:self userInfo:userInfo];
                });
                return;
            }
            NSArray* proyects = [Proyect MR_findAllSortedBy:@"uid" ascending:TRUE];
            if (proyects) {
                [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext){
                    [Proyect MR_truncateAllInContext:localContext];
                }];
            }
            
            
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                for (int i = 0; i< proyectsResponse.count; i++)
                {
                    NSDictionary *proyectDictionary = [proyectsResponse objectAtIndex:i];
                    id proyectIdObject = [proyectDictionary valueForKeyPath:@"id"];
                    NSString *proyectID = ([proyectIdObject isKindOfClass:[NSNumber class]])? [NSString stringWithFormat:@"%@", proyectIdObject] : nil;
                    Proyect *proyect = [Proyect MR_findByAttribute:@"uid" withValue:proyectID].firstObject;
                    if(!proyect)
                    {
                        proyect = [Proyect MR_createEntityInContext:localContext];
                        proyect.uid = proyectID;
                        [ProyectTranslator proyectDictionary:proyectDictionary toProyectEntity:proyect context:localContext];
                    }
                }
            }completion:^(BOOL contextDidSave, NSError *error) {
            
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.filterActive = false;
                    self.proyects = [Proyect MR_findAllSortedBy:@"uid" ascending:TRUE];
                    completion(YES);
                });
            }];
        });
     }
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
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAllClientsFailed object:self userInfo:userInfo];
         });
     }];
}

@end
