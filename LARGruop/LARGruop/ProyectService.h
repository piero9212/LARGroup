//
//  ProyectService.h
//  LARGruop
//
//  Created by piero.sifuentes on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "GenericService.h"
#import "Proyect.h"

@interface ProyectService : GenericService

@property (nonatomic, readonly) BOOL allClassesSelected;

+ (ProyectService *)sharedService;
- (void)cancelAllProyectsRequest;
+ (NSMutableArray *)filterProyects;
+ (void)setFilterProyects:(NSMutableArray *)filterProyects;

- (void)resetProyectsFilter;
- (NSArray *)getAllProyects;


- (NSPredicate *)filterProyectsPredicate;
- (void)setfilterProyectsPredicate:(NSPredicate *)predicate;


- (NSArray *)getProyectsWithPredicate:(NSCompoundPredicate*)predicate;

- (Proyect *)getProyect:(Proyect *)proyect fromContext:(NSManagedObjectContext *)context;
- (Proyect *)newProyect;
- (NSCompoundPredicate *)getProyectFilterPredicate;
- (Proyect *)getProyectWithId:(NSString *)proyectId;

- (NSArray *)getFilteredProyectsWithoutNulls;

- (void)apiGetProyectsWithErrorAlertView:(BOOL)showAlertView userInfo:(NSDictionary *)userInfo andCompletionHandler:(void (^) (BOOL succeeded))completion;
@end
